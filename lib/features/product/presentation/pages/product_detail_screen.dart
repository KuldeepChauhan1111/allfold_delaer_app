import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:readmore/readmore.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/utils/image_path.dart';
import 'package:sales_app/core/widgets/app_bar_widget.dart';
import 'package:sales_app/core/widgets/app_bar_widget2.dart';
import 'package:sales_app/core/widgets/circle_loading_indicator_widget.dart';
import 'package:sales_app/core/widgets/common_functions.dart';
import 'package:sales_app/features/cart/presentation/widgets/update_quantity_dialog_widget.dart';
import 'package:sales_app/features/product/dependency/product_get_it.dart';
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';
import 'package:sales_app/features/product/presentation/blocs/product_state.dart';

@RoutePage()
class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = productGetIt.get<ProductCubit>();
    _productCubit.apiCallGetProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _productCubit,
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          String description = _productCubit
                  .productDetailsResponseProductInfo?.variantDescription ??
              'N/A';
          return Stack(
            children: [
              AppScaffold(
                isBgAsset: true,
                bg: icBg2,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: AppBarWidget2(
                      textAlign: TextAlign.center,
                      isCartVisible: true,
                      isFavVisible: true,
                      title: titleProductDetails,
                      isBackVisible: true,
                      isFavColor: (_productCubit
                                  .productDetailsResponseProductInfo
                                  ?.favourite ==
                              1)
                          ? Colors.red
                          : AppColors.colorLightGrey,
                      onBackPressed: () {
                        Navigator.pop(context, true);
                      },
                      onPressedFav: () {
                        int isFav = _productCubit
                                .productDetailsResponseProductInfo?.favourite ??
                            0;
                        int updateFav = (isFav == 0) ? 1 : 0;
                        _productCubit.apiCallFavoriteUnFavorite(
                            _productCubit.productDetailsResponseProductInfo
                                ?.productVariantId,
                            updateFav);
                      },
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        12.toSizedBoxHeight,
                        _imageCarouselSliderView(context),

                      ],
                    ),
                  ],
                ),
                bottomSheet: BottomSheet(
                    enableDrag: false,
                    showDragHandle: false,
                    onClosing: () {},
                    backgroundColor: AppColors.colorBg.withOpacity(0.9),
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.48,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    10.toSizedBoxHeight,
                                    _productNameView(),
                                    12.toSizedBoxHeight,
                                    _readMoreDescription(
                                        context,
                                        description.isNotEmpty
                                            ? description
                                            : 'N/A'),
                                    20.toSizedBoxHeight,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: _colorListView()),
                                        10.toSizedBoxWidth,
                                        // Expanded(
                                        //   child: _sizeListView(),
                                        // )
                                        Expanded(child: _materialTypeListView()),
                                      ],
                                    ),

                                    _sizeListView(),
                                    80.toSizedBoxHeight,
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AppUtils.commonGlassmorphicContainer(
                                    padding: EdgeInsets.only(left: 30),
                                      child: _addToCartButtonView()))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Visibility(
                visible: state is LoadingState,
                child: const CircleLoadingIndicatorWidget(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _readMoreDescription(BuildContext context, String? text) {
    return ReadMoreText(
      _parseHtmlString("$text"),
      trimLines: 5,
      trimMode: TrimMode.Line,
      trimCollapsedText: '...Read More',
      trimExpandedText: "...Show Less",
      isExpandable: true,
      moreStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: AppConstants.fontFamilyPoppins,
          fontSize: 14,
          color: AppColors.colorPrimary),
      lessStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: AppConstants.fontFamilyPoppins,
          fontSize: 14,
          color: AppColors.colorPrimary),
      colorClickableText: AppColors.colorPrimary,
      style: TextStyle(
          fontFamily: AppConstants.fontFamilyPoppins,
          fontSize: fontSizeSmall,
          fontWeight: FontWeight.w500,
          color: AppColors.colorLightGrey),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = HtmlParser.parseHTML(htmlString);
    return document.text ?? '';
  }

  Widget _imageCarouselSliderView(BuildContext context) {
    return (_productCubit.productDetailsResponseProductInfo?.productImages ??
                [])
            .isEmpty
        ? InkWell(
            onTap: () {
              AutoRouter.of(context).push(ProductPreviewRoute(
                  productInfo: _productCubit.productDetailsResponseProductInfo));
            },
            child: AppUtils.commonGlassmorphicContainer(

              margin: EdgeInsets.symmetric(horizontal: 16),
              height:  MediaQuery.of(context).size.height *0.35,
              child:
                  (_productCubit.productDetailsResponseProductInfo?.image ?? '')
                      .imageBase64(fit: BoxFit.contain),
            ),
          )
        : AppUtils.commonGlassmorphicContainer(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height *0.35,
            blur: 100,
            child: FlutterCarousel(
              options: FlutterCarouselOptions(
                height:  MediaQuery.of(context).size.height *0.35,
                controller: _productCubit.carouselController,
                showIndicator: true,
                floatingIndicator: false,
                viewportFraction: 1,
                slideIndicator: CircularSlideIndicator(
                  slideIndicatorOptions: SlideIndicatorOptions(
                    indicatorRadius: 4,
                    itemSpacing: 14,
                    enableAnimation: true,
                    // enableHalo: true,

                    padding: EdgeInsets.all(10),
                    currentIndicatorColor: AppColors.colorPrimary,
                    indicatorBackgroundColor:
                        AppColors.colorLightGrey.withOpacity(0.5),
                  ),
                ),
              ),
              items: (_productCubit
                          .productDetailsResponseProductInfo?.productImages ??
                      [])
                  .map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        AutoRouter.of(context).push(ProductPreviewRoute(
                          productInfo:
                              _productCubit.productDetailsResponseProductInfo,
                        ));
                      },
                      child: i.imageBase64(
                        height: 250,
                        width: double.infinity,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
  }

  Widget _productNameView() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (_productCubit.productDetailsResponseProductInfo?.productName ??
                      'N/A')
                  .textWidget(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeLarge,
                color: AppColors.colorWhite,

              ),
              5.toSizedBoxHeight,
              (_productCubit.productDetailsResponseProductInfo
                          ?.productCategoryName ??
                      'N/A')
                  .textWidget(
                color: AppColors.colorLightGrey,
                fontSize: fontSizeSmall,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          _productItemCountView(),
        ],
      ),
    );
  }

  Widget _productItemCountView() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                if ((_productCubit.productDetailsResponseProductInfo?.qty ??
                        1) >
                    1) {
                  _productCubit.updateProductQty(
                      (_productCubit.productDetailsResponseProductInfo?.qty ??
                              1) -
                          1);
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
            InkWell(
              onTap: () {
                _productCubit.qtyEditController.text =
                    '${_productCubit.productDetailsResponseProductInfo?.qty ?? 1}';
                showAlertDialog(
                  context: context,
                  title: titleUpdateQuantity,
                  isTitleCenter: true,
                  widget: UpdateQuantityDialogWidget(
                    qtyTextEditingController: _productCubit.qtyEditController,
                    positiveCallBack: (val) {
                      _productCubit.updateProductQty(int.parse(val));
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 10.0),
                margin: const EdgeInsets.symmetric(horizontal: 0),
                child:
                    ('${_productCubit.productDetailsResponseProductInfo?.qty ?? 1}')
                        .textWidget(
                  fontSize: fontSizeMedium,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: AppColors.colorWhite,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _productCubit.updateProductQty(
                    (_productCubit.productDetailsResponseProductInfo?.qty ??
                            1) +
                        1);
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
      ),
    );
  }

  Widget _colorListView() {
    return Visibility(
      visible: _productCubit.colorVariantList.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labelView("Color",),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: ListView.builder(
                itemCount: _productCubit.colorVariantList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  String colorName = _productCubit.colorVariantList[index].name ?? '';
                  // Color productColor = ProductColor.getColor(colorName: colorName);
                  Color productColor = HexColor.fromHex(
                      _productCubit.colorVariantList[index].name ??
                          defaultColorCode);
                  print("ProductColor$productColor");
                  print("ProductColor$colorName");

                  return GestureDetector(
                    onTap: () {
                      _productCubit.refreshScreenOnColorChange(
                        widget.productId,
                        _productCubit.colorVariantList[index],
                      );
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(3),

                      decoration: AppUtils.commonGradientBoxDecoration(
                        borderWidth: 0,
                        // shape: BoxShape.circle,
                        borderRadius: 180,
                        gradient1:  (_productCubit.selectedColorVariant?.id ==
                            _productCubit.colorVariantList[index].id)? AppColors.gradient1 : AppColors.colorTransparent,
                        gradient2: (_productCubit.selectedColorVariant?.id ==
                            _productCubit.colorVariantList[index].id)? AppColors.gradient2 : AppColors.colorTransparent,


                      ),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: productColor,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _sizeListView() {
    return Visibility(
      visible: _productCubit.stepVariantList.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labelView("Steps"),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 45,
            child: ListView.builder(
                itemCount: _productCubit.stepVariantList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        _productCubit.refreshScreenOnSizeChange(
                          widget.productId,
                          _productCubit.stepVariantList[index],
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: AppUtils.commonGradientBoxDecoration(
                          borderRadius: 14,
                          gradient1: (_productCubit.selectedSizeVariant?.id ==
                                  _productCubit.stepVariantList[index].id)
                              ? AppColors.gradient1
                              : AppColors.colorTransparent,
                          gradient2: (_productCubit.selectedSizeVariant?.id ==
                                  _productCubit.stepVariantList[index].id)
                              ? AppColors.gradient2
                              : AppColors.colorTransparent,
                          border: (_productCubit.selectedSizeVariant?.id ==
                                  _productCubit.stepVariantList[index].id)
                              ? AppColors.colorTransparent
                              : AppColors.colorLightGrey,
                        ),
                        child: '${_productCubit.stepVariantList[index].name}'
                            .textWidget(
                                color: AppColors.colorWhite,
                                fontSize: fontSizeSmall,
                                fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _materialTypeListView() {
    return Visibility(
      visible: _productCubit.materialVariantList.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labelView("Material"),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 45,
            width: double.infinity,
            child: ListView.builder(
                itemCount: _productCubit.materialVariantList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        _productCubit.refreshScreenOnMaterialChange(
                          widget.productId,
                          _productCubit.materialVariantList[index],
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: (_productCubit.selectedMaterialVariant?.id ==
                                    _productCubit.materialVariantList[index].id)
                                ? AppColors.colorPrimary
                                : AppColors.colorTransparent,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              width: 1.2,
                              color:
                                  (_productCubit.selectedMaterialVariant?.id ==
                                          _productCubit
                                              .materialVariantList[index].id)
                                      ? AppColors.colorTransparent
                                      : AppColors.colorLightGrey,
                            )),
                        child: (_productCubit.materialVariantList[index].name ??
                                '')
                            .textWidget(
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorWhite,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _addToCartButtonView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                '$currencySymbol${_productCubit
                    .productDetailsResponseProductInfo?.price?.toInt() ?? '0.0'}'
                    .textWidget(
                        color: AppColors.colorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        latterSpacing: 1),
                SizedBox(
                  width: 14,
                ),
                'Excluding of all taxes'.textWidget(
                    color: AppColors.colorLightGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    latterSpacing: 0)
              ],
            )),
        16.toSizedBoxWidth,
        GestureDetector(
          onTap: () {
            if (_productCubit
                    .productDetailsResponseProductInfo?.isExistInPrefList ??
                false) {
              _productCubit.removeProductFromCartPreference();
            } else {
              _productCubit.saveProductInPreferenceCartList();
            }
          },
          child: Container(
            decoration: AppUtils.commonGradientBoxDecoration(borderRadius: 20),
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 30),
            child: Center(
              child: Icon(
                (_productCubit.productDetailsResponseProductInfo
                            ?.isExistInPrefList ??
                        false)
                    ? Icons.shopping_cart_outlined
                    : Icons.shopping_cart_checkout_rounded,
                color: AppColors.colorWhite,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _labelView(String? label) {
    return "$label".textWidget(
        color: AppColors.colorWhite,
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w700,
        );
  }
}
