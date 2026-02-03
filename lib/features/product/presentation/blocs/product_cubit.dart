import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:sales_app/features/product/data/models/get_product_by_categories_request.dart';
import 'package:sales_app/features/product/data/models/get_product_by_categories_response.dart';
import 'package:sales_app/features/product/data/models/product_details_request.dart';
import 'package:sales_app/features/product/data/models/product_details_response.dart'
    as detail_res;
import 'package:sales_app/features/product/domain/usecase/favorite_unfavorite_usecase.dart';
import 'package:sales_app/features/product/domain/usecase/get_products_by_categories_usecase.dart';
import 'package:sales_app/features/product/domain/usecase/products_details_usecase.dart';
import 'package:sales_app/features/product/presentation/blocs/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.iPreference,
    required this.getProductsByCategoriesUseCase,
    required this.productsDetailsUsecase,
    required this.favoriteUnFavoriteUsecase,
  }) : super(ProductState().init());


  AnimationController? animationController;

  TextEditingController qtyEditController = TextEditingController();
  FlutterCarouselController carouselController = FlutterCarouselController();

  IPreference iPreference;
  GetProductsByCategoriesUseCase getProductsByCategoriesUseCase;
  ProductsDetailsUsecase productsDetailsUsecase;
  FavoriteUnfavoriteUsecase favoriteUnFavoriteUsecase;

  List<ProductInfo> productList = [];

  detail_res.ProductInfo? productDetailsResponseProductInfo;
  List<detail_res.Color> colorVariantList = [];
  List<detail_res.Steps> stepVariantList = [];
  List<detail_res.Material> materialVariantList = [];

  List<detail_res.ProductInfo?> prefCartProductList = [];

  detail_res.Color? selectedColorVariant;
  detail_res.Steps? selectedSizeVariant;
  detail_res.Material? selectedMaterialVariant;

  double cartSubtotal = 0;
  int cartTotalQty = 0;
  double cartGstRate = 0;
  double cartGstTotal =0;
  double cartTotal = 0;
  String? token;

  Future<void> _getPrefUserToken() async {
    token = await iPreference.getPreferenceValue(
        preferenceKey: PreferenceKey.token, defaultValue: '');
  }

  /// this function updates cart's count
  Future<void> updateCartItemCount() async {
    await iPreference.setPreferenceValue(
        preferenceKey: PreferenceKey.cartItemCountPref,
        value: prefCartProductList.length);
    cartItemCount = await iPreference.getPreferenceValue(
        preferenceKey: PreferenceKey.cartItemCountPref, defaultValue: 0);
  }

  /// this function get cart count from preference
  Future<void> getCartItemCount() async {
    cartItemCount = await iPreference.getPreferenceValue(
        preferenceKey: PreferenceKey.cartItemCountPref, defaultValue: 0);
    emit(CartCountState());
  }

  /// this function calculate subtotal price for cart screen
  void calculateSubtotal() {
    cartSubtotal = 0;
    cartTotalQty = 0;
    cartGstTotal = 0;
    cartTotal = 0;

    double gstRatePercent = 18; // for example, 18%
    double gstRate = gstRatePercent / 100;

    if (prefCartProductList.isNotEmpty) {
      for (int i = 0; i < prefCartProductList.length; i++) {
        final product = prefCartProductList[i];
        if (product != null) {
          double inclusivePrice = product.calculatedPrice ?? 0;
          int qty = product.qty ?? 0;

          // Reverse-calculate base price (exclusive of GST)
          double basePrice = inclusivePrice / (1 + gstRate);
          double gstAmount = inclusivePrice - basePrice;

          cartSubtotal += basePrice;
          cartGstTotal += gstAmount;
          cartTotalQty += qty;
        }
      }
    }

    cartGstRate = gstRatePercent;
    cartTotal = cartSubtotal + cartGstTotal;

    emit(ProductState().init());
  }

  // void calculateSubtotal() {
  //   cartSubtotal = 0;
  //   cartTotalQty = 0;
  //   if (prefCartProductList.isNotEmpty) {
  //     for (int i = 0; i < prefCartProductList.length; i++) {
  //       cartSubtotal =
  //           cartSubtotal + (prefCartProductList[i]?.calculatedPrice ?? 0);
  //       cartTotalQty = cartTotalQty + (prefCartProductList[i]?.qty ?? 0);
  //     }
  //   }
  //   emit(ProductState().init());
  // }

  /// this function call an api of get product details to refresh the page when color variant changed by user
  refreshScreenOnColorChange(int productId, detail_res.Color newItem) {
    selectedColorVariant?.id = newItem.id;
    apiCallGetProductDetails(productId);
  }

  /// this function call an api of get product details to refresh the page when size/steps variant changed by user
  refreshScreenOnSizeChange(int productId, detail_res.Steps newItem) {
    selectedSizeVariant?.id = newItem.id;
    apiCallGetProductDetails(productId);
  }

  /// this function call an api of get product details to refresh the page when material variant changed by user
  refreshScreenOnMaterialChange(int productId, detail_res.Material newItem) {
    selectedMaterialVariant?.id = newItem.id;
    apiCallGetProductDetails(productId);
  }

  /// this function get product list from preference those are added into the cart for cart listing screen
  Future<void> getProductListFromPreference() async {
    prefCartProductList = await getCartProductListFromPreference();
    // emit(ProductState().init());
    calculateSubtotal();
  }

  /// this function called when quantity changed and then check if product exist into preference cart list then update over there as well */
  updateProductQty(int qty) async {
    productDetailsResponseProductInfo?.qty = qty;
    /* calculated price for cart screen */
    productDetailsResponseProductInfo?.calculatedPrice =
        qty * (productDetailsResponseProductInfo?.totalIncluded ?? 1);

    if (productDetailsResponseProductInfo?.isExistInPrefList ?? false) {
      updateProductInPreferenceCartList(
          productDetailsResponseProductInfo?.productVariantId ?? 0);
    }
    emit(UpdateQuantityState());
  }

  /// this function only used from cart listing screen to update product's quantity */
  updateProductQtyFromCartListingScreen(int index, int qty) async {
    prefCartProductList[index]?.qty = qty;
    /* calculated price for cart screen */
    prefCartProductList[index]?.calculatedPrice =
        qty * (prefCartProductList[index]?.totalIncluded ?? 0);
    await saveProductInCartListPreference(prefCartProductList);
    // emit(ProductState().init());
    calculateSubtotal();
  }

  /// this function will get product if exist in preference cart list, it will check/compare current product which get from api response */
  Future<void> getProductFromCartPreference() async {
    prefCartProductList = await getCartProductListFromPreference();
    int i = prefCartProductList.indexWhere((element) =>
        (element?.productVariantId ?? -1) ==
        (productDetailsResponseProductInfo?.productVariantId ?? 0));
    if (i != -1) {
      var prefProduct = prefCartProductList[i];
      productDetailsResponseProductInfo = prefProduct;
    }
    emit(ProductState().init());
  }

  /// this function save current product in preference cart list, this will check if product already exist then replace or else saved it */
  void saveProductInPreferenceCartList() async {
    if (selectedColorVariant == null ||
        selectedSizeVariant == null ||
        selectedMaterialVariant == null) {
      showToastMsg(errorMsgSelectVariant);
      return;
    }
    productDetailsResponseProductInfo?.isExistInPrefList = true;

    /// below three object stored customised bCoz it will help to display in cart listing screen easily */
    productDetailsResponseProductInfo?.selectedColor = selectedColorVariant;
    productDetailsResponseProductInfo?.selectedSize = selectedSizeVariant;
    productDetailsResponseProductInfo?.selectedMaterial =
        selectedMaterialVariant;
    /* calculated price for cart screen */
    productDetailsResponseProductInfo?.calculatedPrice =
        (productDetailsResponseProductInfo?.qty ?? 1) *
            (productDetailsResponseProductInfo?.totalIncluded ?? 1);
    prefCartProductList.add(productDetailsResponseProductInfo);
    await updateCartItemCount();
    await saveProductInCartListPreference(prefCartProductList);
    emit(ProductState().init());
    showToastMsg(msgProductAddedInCart);
  }

  /// this function update specific object in preference cart list item with updated value */
  void updateProductInPreferenceCartList(int productVariantId) async {
    int i = prefCartProductList.indexWhere(
        (element) => (element?.productVariantId ?? -1) == productVariantId);
    if (i != -1) {
      prefCartProductList[i] = productDetailsResponseProductInfo;
    }
    await saveProductInCartListPreference(prefCartProductList);
    emit(ProductState().init());
  }

  /// this function remove product from preference cart list and save again updated product list into cart preference */
  Future<void> removeProductFromCartPreference() async {
    prefCartProductList = await getCartProductListFromPreference();
    int i = prefCartProductList.indexWhere((element) =>
        (element?.productVariantId ?? -1) ==
        (productDetailsResponseProductInfo?.productVariantId ?? 0));
    if (i != -1) {
      prefCartProductList.removeAt(i);
    }
    await saveProductInCartListPreference(prefCartProductList);

    /// below fields reset to make ui updated */
    productDetailsResponseProductInfo?.isExistInPrefList = false;
    productDetailsResponseProductInfo?.qty = 1;
    await updateCartItemCount();
    emit(ProductState().init());
    showToastMsg(msgProductRemovedFromCart);
  }

  Future<void> removeProductFromCartListingScreen(int index) async {
    prefCartProductList.removeAt(index);
    await updateCartItemCount();
    await saveProductInCartListPreference(prefCartProductList);
    getProductListFromPreference();
    showToastMsg(msgProductRemovedFromCart);
  }

  /// this api call get all product by given category */
  void apiCallGetProductByCategory(int? categoryId) async {
    await _getPrefUserToken();
    emit(LoadingState());
    final res = await getProductsByCategoriesUseCase(
        GetProductByCategoriesRequest(token: token, categoryId: categoryId));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      productList = r.data?.productInfo ?? [];
      emit(SuccessState());
      return r;
    });
  }

  /// this function call an api to get product details and then check same product exist in preference list then get same object from preference list and displayed */
  void apiCallGetProductDetails(int? productId) async {
    await _getPrefUserToken();
    emit(LoadingState());

    List<int> attributeList = [];
    int? colorId = selectedColorVariant?.id;
    int? sizeId = selectedSizeVariant?.id;
    int? materialId = selectedMaterialVariant?.id;

    if (colorId != null) {
      attributeList.add(colorId);
    }
    if (materialId != null) {
      attributeList.add(materialId);
    }
    if (sizeId != null) {
      attributeList.add(sizeId);
    }
    final res = await productsDetailsUsecase(ProductDetailsRequest(
      token: token,
      productId: productId,
      productAttributeValues: attributeList,
    ));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) async {
      _resetFilledData();
      detail_res.ProductDetailsResponse productDetailsResponse = r;
      if ((productDetailsResponse.data?.productInfo ?? []).isNotEmpty) {
        productDetailsResponseProductInfo =
            productDetailsResponse.data?.productInfo?[0];
        productDetailsResponseProductInfo?.qty = 1;
        (productDetailsResponseProductInfo?.allVariants)
            ?.forEach((action) async {
          if ((action.color ?? []).isNotEmpty) {
            colorVariantList = action.color ?? [];
          }
          if ((action.steps ?? []).isNotEmpty) {
            stepVariantList = action.steps ?? [];
          }
          if ((action.material ?? []).isNotEmpty) {
            materialVariantList = action.material ?? [];
          }
        });

        if (productDetailsResponseProductInfo?.productVariant != null) {
          selectedColorVariant =
              productDetailsResponseProductInfo?.productVariant?.color;
          selectedSizeVariant =
              productDetailsResponseProductInfo?.productVariant?.steps;
          selectedMaterialVariant =
              productDetailsResponseProductInfo?.productVariant?.material;
          productDetailsResponseProductInfo?.selectedColor =
              selectedColorVariant;
          productDetailsResponseProductInfo?.selectedSize = selectedSizeVariant;
          productDetailsResponseProductInfo?.selectedMaterial =
              selectedMaterialVariant;
        }
      }
      getProductFromCartPreference();
      emit(SuccessState());
      Future.delayed(Duration(milliseconds: 100), () {
        if ((productDetailsResponseProductInfo?.productImages ?? []).isNotEmpty) {
          carouselController.jumpToPage(0);
        }
        emit(SuccessState());
      });
      return r;
    });
  }

  /// this function reset some variable
  void _resetFilledData() {
    productDetailsResponseProductInfo = null;
    selectedColorVariant = null;
    selectedSizeVariant = null;
    selectedMaterialVariant = null;
    colorVariantList = [];
    stepVariantList = [];
    materialVariantList = [];
  }

  void apiCallFavoriteUnFavorite(int? productId, int isFav,
      {Function? callBack}) async {
    await _getPrefUserToken();
    emit(LoadingState());
    final res = await favoriteUnFavoriteUsecase(HashMap.from({
      'token': token,
      'product_id': productId,
      'option': isFav,
    }));

    if (kDebugMode) {
      print('logcat :: api response cubit = ${res.toString()} ');
    }

    res.fold((l) {
      showToastMsg(l.errorMessage);
      emit(FailureState());
      return l;
    }, (r) {
      if (callBack != null) {
        callBack();
      } else {
        productDetailsResponseProductInfo?.favourite = isFav;
      }
      emit(SuccessState());
      return r;
    });
  }
}

class ProductVariantTypeEnum {
  static const String colorVariant = 'color';
  static const String stepVariant = 'step';
  static const String materialVariant = 'material';
}

class ProductColor {

  static Color hexToColor(String hexCode) {
    final cleanedHex = hexCode.replaceFirst('#', '');
    final buffer = StringBuffer();

    // If only 6 characters are provided, assume it's opaque and add 'FF'
    if (cleanedHex.length == 6) {
      buffer.write('FF');
    }

    buffer.write(cleanedHex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  static Color getColor({required String colorName}) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return AppColors.colorRed;
      case 'blue':
        return AppColors.colorBlue;
      case 'green':
        return AppColors.colorGreen;
      default:
        return AppColors.colorPrimary;
    }



  }


}
