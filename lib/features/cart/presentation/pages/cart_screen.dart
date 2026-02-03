import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/routes/app_router.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';

import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/app_bar_widget2.dart';
import 'package:sales_app/core/widgets/circle_loading_indicator_widget.dart';
import 'package:sales_app/core/widgets/common_button_widget.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/cart/dependency/cart_get_it.dart';
import 'package:sales_app/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:sales_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:sales_app/features/cart/presentation/blocs/cart_state.dart'
    as cart_state;
import 'package:sales_app/features/cart/presentation/widgets/update_quantity_dialog_widget.dart';
import 'package:sales_app/features/product/data/models/product_details_response.dart';
import 'package:sales_app/features/product/dependency/product_get_it.dart';
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';
import 'package:sales_app/features/product/presentation/blocs/product_state.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ProductCubit _productCubit;
  late CartCubit _cartCubit;

  @override
  void initState() {
    super.initState();
    _cartCubit = cartGetIt.get<CartCubit>();
    _productCubit = productGetIt.get<ProductCubit>();
    _productCubit.getProductListFromPreference();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create: (context) => _productCubit,
      providers: [
        BlocProvider<ProductCubit>(create: (context) => _productCubit),
        BlocProvider<CartCubit>(create: (context) => _cartCubit),
      ],
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is SuccessStateCheckout) {
            showToastMsg(msgCheckoutSuccess);
            _productCubit.getProductListFromPreference();
          }
        },
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return AppScaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: AppBarWidget2(
                      isBackVisible: true,
                      title: titleCart,
                      isCartVisible: false,
                    )),
              ),
              body: (_productCubit.prefCartProductList.isEmpty)
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppUtils.emptyCartWidget(),
                      10.toSizedBoxHeight,
                      CommonButtonWidget(buttonText: "Continue Shopping", onPressed: (){
                            AutoRouter.of(context).pushAndPopUntil(
                              const DashboardRoute(),
                              predicate: (route) =>
                                  route.settings.name ==
                                  RouteConstant.cartScreen,
                            );
                          },verticalPadding: 10,fontSize: fontSizeSmall,horizontalMargin: 120,)
                    ],
                  )
                  : Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              // ✅ Changed from fixed height to Expanded
                              child: ListView.builder(
                                itemCount:
                                    _productCubit.prefCartProductList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return _listItem(index,
                                      _productCubit.prefCartProductList[index]);
                                },
                              ),
                            ),
                            _subTotalView(),
                          ],
                        ),
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, cartState) {
                            return Visibility(
                                visible: cartState is cart_state.LoadingState,
                                child: const CircleLoadingIndicatorWidget());
                          },
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  // Widget _btnCheckout({required Function onSwipe}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
  //     child: SliderButton(
  //       vibrationFlag: true,
  //       shimmer: true,
  //       height: 70,
  //       action: () async {
  //         await onSwipe();
  //         return false;
  //       },
  //       label: Center(
  //         child: "Confirm Order".textWidget(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 16,
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //       width: MediaQuery.of(context).size.width * 0.90,
  //       // radius: 360,
  //       highlightedColor: Colors.white,
  //       child: Container(
  //         width: 70,
  //         height: 70,
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               AppColors.gradient1,
  //               AppColors.gradient2,
  //             ],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           borderRadius: BorderRadius.circular(360),
  //         ),
  //         child: Icon(
  //           Icons.done,
  //           color: AppColors.colorLightGrey,
  //           size: 30,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _listItem(int index, ProductInfo? item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.colorLightGrey,
      ),
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      child: Slidable(
        // enabled: true,
        key: UniqueKey(),
        endActionPane: ActionPane(
          extentRatio: 0.20,
          dragDismissible: false,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
              dismissalDuration: const Duration(milliseconds: 1000),
              dismissThreshold: 0.1,
              onDismissed: () {}),
          children: [
            CustomSlidableAction(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              onPressed: (context) {
                AppUtils.showCustomTwoBtnDialog(
                  ctx: context,
                  dialogBtnTextRight: lblYes,
                  dialogBtnTextLeft: lblNo,
                  dialogMessage: msgRemoveProductFromCart,
                  dialogTitle: lblAlert,
                  dialogBtnRightFnc: () {
                    _productCubit.removeProductFromCartListingScreen(index);
                  },
                );
              },
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              // backgroundColor: AppColors.colorLightGrey,
              foregroundColor: AppColors.colorPrimary,
              child: Icon(
                Icons.delete,
                size: 26,
                color: AppColors.colorPrimary,
              ),
            ),
          ],
        ),
        child: Container(

          decoration: BoxDecoration(
            color: AppColors.colorBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
            boxShadow: [
              BoxShadow(
                color: AppColors.colorPrimary.withOpacity(0.25),
                blurRadius: 0,
                spreadRadius: 0.0,
                offset: const Offset(0, 1.5),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.colorLightGrey
                          .withOpacity(0.15), // Base layer
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.colorWhite.withOpacity(0.15),
                            AppColors.gradientImage2.withOpacity(0.15)
                          ],
                        ),
                      ),
                      child: (item?.image ?? '').imageBase64(
                        height: 90,
                        width: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  AppUtils.commonSizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: (item?.productName ?? '').textWidget(
                                fontSize: fontSizeLarge,
                                fontWeight: FontWeight.w600,
                                color: AppColors.colorWhite,
                              ),
                            ),
                            '$currencySymbol${item?.totalIncluded?.toStringAsFixed(2) ?? 0}'
                                .textWidget(
                              color: AppColors.colorWhite,
                              fontSize: fontSizeMedium,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppConstants.fontFamilyRoboto
                            ),
                          ],
                        ),
                        5.toSizedBoxHeight,
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                '$lblSteps : '.richTextView(
                                    color: AppColors.colorLightGrey,
                                    textSpanList: [
                                      const WidgetSpan(
                                          child: SizedBox(width: 4)),
                                      TextSpan(
                                          text: item?.selectedSize?.name ??
                                              'N/A',
                                          style: const TextStyle(
                                            color: AppColors.colorWhite,
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ]),
                                2.toSizedBoxHeight,
                                '$lblColor : '.richTextView(
                                    color: AppColors.colorLightGrey,
                                    textSpanList: [
                                      const WidgetSpan(
                                          child: SizedBox(width: 4)),
                                      TextSpan(
                                          text: item?.selectedColor?.name,
                                          style: const TextStyle(
                                            color: AppColors.colorWhite,
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ]),
                                2.toSizedBoxHeight,
                                // (item?.selectedMaterial?.name ?? 'N/A')
                                //     .textWidget(
                                //         color: AppColors.colorPrimary,
                                //         fontWeight: FontWeight.bold),
                              ],
                            )),
                            _productItemCountView(index, item),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _productItemCountView(int index, ProductInfo? item) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              if ((item?.qty ?? 1) > 1) {
                _productCubit.updateProductQtyFromCartListingScreen(
                    index, (item?.qty ?? 1) - 1);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1.3,
                    color: AppColors.colorWhite,
                  )),
              child: const Icon(
                Icons.remove,
                size: 16,
                color: AppColors.colorWhite,
              ),
            ),
          ),
          // 12.toSizedBoxWidth,
          InkWell(
            onTap: () {
              _productCubit.qtyEditController.text = '${item?.qty ?? 1}';
              showAlertDialog(
                context: context,
                title: titleUpdateQuantity,
                isTitleCenter: true,
                widget: UpdateQuantityDialogWidget(
                  qtyTextEditingController: _productCubit.qtyEditController,
                  positiveCallBack: (val) {
                    _productCubit.updateProductQtyFromCartListingScreen(
                        index, int.parse(val));
                  },
                ),
              );
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
              child: ('${item?.qty ?? 1}') .textWidget(
                fontSize: fontSizeMedium,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                color: AppColors.colorWhite,

              ),
            ),
          ),
          // 12.toSizedBoxWidth,
          InkWell(
            onTap: () {
              _productCubit.updateProductQtyFromCartListingScreen(
                  index, (item?.qty ?? 1) + 1);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration:
              AppUtils.commonGradientBoxDecoration(borderRadius: 8),
              child: const Icon(
                Icons.add,
                size: 16,
                color: AppColors.colorWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subTotalView() {
    return Visibility(
      visible: _productCubit.prefCartProductList.isNotEmpty,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.colorBg, // background color for visibility
          borderRadius: BorderRadius.circular(12), // rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Spacer(),
                '$lblSubtotal (${_productCubit.cartTotalQty} Items) : '
                    .textWidget(
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSizeNormal,
                ),
                '$currencySymbol${_productCubit.cartSubtotal.toStringAsFixed(2)}'.textWidget(
                    color: AppColors.colorWhite,
                    fontSize: fontSizeMedium,
                    fontFamily: AppConstants.fontFamilyRoboto,
                    fontWeight: FontWeight.bold
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Spacer(),
                'Gst (18%) : '.textWidget(
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSizeNormal,
                ),
                '$currencySymbol${_productCubit.cartGstTotal.toStringAsFixed(2)}'
                    .textWidget(
                    color: AppColors.colorWhite,
                    fontSize: fontSizeMedium,
                    fontFamily: AppConstants.fontFamilyRoboto,
                    fontWeight: FontWeight.bold)
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Spacer(),
                'Total : '.textWidget(
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSizeNormal,
                ),
                '$currencySymbol${_productCubit.cartTotal.toStringAsFixed(2)}'
                    .textWidget(
                    color: AppColors.colorWhite,
                    fontSize: fontSizeMedium,
                    fontFamily: AppConstants.fontFamilyRoboto,
                    fontWeight: FontWeight.bold)
              ],
            ),
            AppUtils.slideButton(onSwipe: (){
              AppUtils.showCustomTwoBtnDialog(
                ctx: context,
                dialogBtnTextRight: "Confirm",
                dialogBtnTextLeft: "Cancel",
                dialogMessage: msgCartCheckoutAlert,
                dialogTitle: lblConfirmation,
                dialogBtnRightFnc: () {
                  _cartCubit.apiCallCheckout();
                },
              );
            }, context: context,
              text: "Confirm Order"

            )
            // _btnCheckout(onSwipe: () {
            //
            // }),
          ],
        ),
      ),
    );
  }
}
