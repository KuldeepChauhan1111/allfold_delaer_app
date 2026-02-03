import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/core/routes/app_router.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/orders/data/models/get_order_list_response.dart';
import 'package:sales_app/features/orders/data/models/order_details_response.dart';
import 'package:sales_app/features/orders/data/models/order_picking_list_response.dart';
import 'package:sales_app/features/orders/domain/usecase/get_orders_usecase.dart';
import 'package:sales_app/features/orders/domain/usecase/order_details_usecase.dart';
import 'package:sales_app/features/orders/domain/usecase/order_picking_list_usecase.dart';
import 'package:sales_app/features/orders/domain/usecase/order_receive_usecase.dart';
import 'package:sales_app/features/orders/domain/usecase/update_orders_usecase.dart';
import 'package:sales_app/features/orders/presentation/blocs/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({
    required this.iPreference,
    required this.getOrdersUsecase,
    required this.orderDetailsUsecase,
    required this.updateOrdersUsecase,
    required this.orderPickingListUsecase,
    required this.orderReceiveUsecase,
  }) : super(OrderState().init());

  IPreference iPreference;
  GetOrdersUsecase getOrdersUsecase;
  OrderDetailsUsecase orderDetailsUsecase;
  UpdateOrdersUsecase updateOrdersUsecase;
  OrderPickingListUsecase orderPickingListUsecase;
  OrderReceiveUsecase orderReceiveUsecase;

  TextEditingController qtyEditController = TextEditingController();

  List<OrderList>? orderList;
  OrderDetails? orderDetails;
  OrderPickingListResponse? orderPickingListResponse;

  String? token;
  bool isAllowUpdateOrder = true;
  bool isOrderReceived = false;
  List<int?> productId = [];

  double cartSubtotal = 0;
  int cartTotalQty = 0;
  double cartGstRate = 0;
  double cartGstTotal = 0;
  double cartTotal = 0;

  void refreshPage() {
    emit(OrderState().init());
  }

  Future<void> _getPrefUserToken() async {
    token = await iPreference.getPreferenceValue(
        preferenceKey: PreferenceKey.token, defaultValue: '');
  }

  void apiCallGetOrders({required String orderFilter}) async {
    await _getPrefUserToken();
    emit(LoadingState());
    final res = await getOrdersUsecase(HashMap.from({
      'token': token,
      'filter': orderFilter,
    }));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((Failure l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      orderList = null;
      orderList = r.data?.orderList ?? [];
      emit(SuccessState());
      return r;
    });
  }

  void apiCallGetOrderDetails({int? orderId}) async {
    await _getPrefUserToken();
    emit(LoadingState());
    final res = await orderDetailsUsecase(HashMap.from({
      'token': token,
      'OrderID': orderId,
    }));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      orderDetails = r.data?.orderDetails?[0];
      isAllowUpdateOrder = orderDetails?.state == OrderStatusType.draft;
      isOrderReceived = orderDetails?.state == OrderStatusType.delivered;
      if (orderDetails != null) {
        calculateSubtotal(orderDetails!);
      }

      // emit(SuccessState());
      apiCallOrderPickings(orderId: orderId);
      return r;
    });
  }

  void apiCallUpdateQuantity(
      {int? orderId, int? productId, required int qty}) async {
    await _getPrefUserToken();
    emit(LoadingState());
    final res = await updateOrdersUsecase(HashMap.from({
      'token': token,
      'OrderID': orderId,
      'linedatas': '[{\'lineid\': $productId, \'quantity\': $qty}]',
    }));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      showToastMsg(r.message ?? '');
      emit(SuccessState());
      apiCallGetOrderDetails(orderId: orderId);
      return r;
    });
  }

  void apiCallOrderPickings({int? orderId}) async {
    await _getPrefUserToken();
    emit(LoadingState());
    final res = await orderPickingListUsecase(HashMap.from({
      'token': token,
      'OrderID': orderId,
      // 'OrderID': 12, // TODO static change
    }));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      orderPickingListResponse = r;
      findDeliveredProduct(orderPickingListResponse);
      emit(SuccessState());
      return r;
    });
  }

  void apiCallOrderReceive(
      {int? orderId, String? receiptNo, String? productLine,required BuildContext context}) async {
    await _getPrefUserToken();
    emit(LoadingState());
    final res = await orderReceiveUsecase(HashMap.from({
      'token': token,
      'ReceiptNO': receiptNo,
      'Productline': "$productLine"
    }));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      showToastMsg(r.message ?? 'Order Received');
      emit(SuccessState());
      AutoRouter.of(context).popForced(true);
      // apiCallGetOrderDetails(orderId: orderId);
      return r;
    });
  }

  /// this function calculate subtotal price for cart screen
  void calculateSubtotal(OrderDetails order) {
    cartSubtotal = 0;
    cartTotalQty = 0;
    cartGstTotal = 0;
    cartTotal = 0;

    double gstRatePercent = 18; // for example, 18%
    double gstRate = gstRatePercent / 100;

    if (order.products != null) {
      for (int i = 0; i < order.products!.length; i++) {
        double inclusivePrice = order.products![i].priceIncludeTax ?? 0;
        int qty = order.products![i].quantity ?? 0;

        // Reverse-calculate base price (exclusive of GST)
        double basePrice = inclusivePrice / (1 + gstRate);
        double gstAmount = inclusivePrice - basePrice;

        cartSubtotal += basePrice;
        cartGstTotal += gstAmount;
        cartTotalQty += qty;
      }
    }

    cartGstRate = gstRatePercent;
    cartTotal = cartSubtotal + cartGstTotal;
    emit(OrderState().init());
  }

  void findDeliveredProduct(
      OrderPickingListResponse? orderPickingListResponse) {
    if (orderPickingListResponse == null) {
      return;
    }
    orderPickingListResponse.data?.forEach(
      (data) {
        String? status = data.status;
        if (status == 'delivered') {
          data.products?.forEach(
            (product) {
              print("productIdDelivered${product.productId}");
              productId.add(product.productId);
            },
          );
        }
      },
    );
    //filter list
    for (var id in productId) {
      orderDetails?.products?.forEach((product) {
        if(product.productId == id){
          product.productStatus = "Delivered";
        }

      },);
    }

  }
}

class OrderStatusType {
  static const String draft = 'draft';
  static const String inProgress = 'inProgress';
  static const String delivered = 'delivered';
  static const String cancel = 'cancel';
  static const String intransit = 'intransit';
  static const String partial = 'partial';
}
