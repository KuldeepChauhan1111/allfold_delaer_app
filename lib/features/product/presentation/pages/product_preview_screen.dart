import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/features/product/data/models/product_details_response.dart'
    as details_res;
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';

@RoutePage()
class ProductPreviewScreen extends StatefulWidget {
  const ProductPreviewScreen({
    super.key,
    this.productInfo,
  });

  final details_res.ProductInfo? productInfo;

  @override
  State<ProductPreviewScreen> createState() => _ProductPreviewScreenState();
}

class _ProductPreviewScreenState extends State<ProductPreviewScreen> {
  bool showMenu = true;
  bool showBottomSheet = false;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('logcat :: product info => ${widget.productInfo}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showBottomSheet = false;
          showMenu = false;
        });
      },
      child: AppScaffold(

          body: AppUtils.commonContainer(
              child: Stack(
        children: [
          _imageCarouselSliderView(context),
          _closeIconView(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              _descriptionView(),
            ],
          ),
        ],
      ))),
    );
  }

  Widget _closeIconView() {
    print("-----------Data${widget.productInfo?.selectedColor?.name}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.toSizedBoxHeight,
        Padding(
          padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppUtils.fourDotWidget(onTap: () {
                setState(() {
                  showMenu = !showMenu;
                });
              }),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: AppColors.colorLightGrey,
                  size: 26,
                ),
              ),
            ],
          ),
        ),
        AppUtils.commonSizedBox(height: 30),
        Visibility(
          visible: showMenu,
          child: Padding(
            padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
            child: Column(
              children: [
                _commonViewSideOption(
                    title: '',
                    value: '',
                    boxColor: ProductColor.hexToColor(
                        widget.productInfo?.selectedColor?.htmlColor ?? "")),
                16.toSizedBoxHeight,
                _commonViewSideOption(
                    title: 'Size',
                    value: (widget.productInfo?.selectedSize?.name ?? 'N/A')),
                16.toSizedBoxHeight,
                _commonViewSideOption(
                    title: 'Material',
                    value:
                        (widget.productInfo?.selectedMaterial?.name ?? 'N/A')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _commonViewSideOption(
      {required String title, required String value, Color? boxColor}) {
    return Container(
      width: 85,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: boxColor ?? AppColors.colorWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title.textWidget(
              textAlign: TextAlign.center,
              color: AppColors.colorText,
              fontWeight: FontWeight.bold),
          value.textWidget(
              color: AppColors.colorText, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _imageCarouselSliderView(BuildContext context) {
    print("details${widget.productInfo?.image}");

    return (widget.productInfo?.productImages ?? []).isEmpty
        ? "${widget.productInfo?.image}".imageBase64(
            height: MediaQuery.sizeOf(context).height / 1.4,
            width: double.infinity,
          )
        : FlutterCarousel(
            options: FlutterCarouselOptions(

              height: MediaQuery.sizeOf(context).height / 1.2,
              showIndicator: true,
              floatingIndicator: false,
              viewportFraction: 1,
              slideIndicator: CircularSlideIndicator(
                  slideIndicatorOptions: SlideIndicatorOptions(
                      currentIndicatorColor: AppColors.colorPrimary,
                      indicatorBackgroundColor:
                          AppColors.colorLightGrey.withOpacity(0.5))),
            ),
            items: (widget.productInfo?.productImages ?? []).map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return i.imageBase64(
                    height: MediaQuery.sizeOf(context).height / 1.4,
                    width: double.infinity,
                  );
                  // return ''.toNetWorkImage(
                  //   height: MediaQuery.sizeOf(context).height / 1.4,
                  //   width: double.infinity,
                  // );
                },
              );
            }).toList(),
          );
  }

  Widget _descriptionView() {
    String description = (widget.productInfo?.variantDescription ?? '').isNotEmpty
            ? (widget.productInfo?.variantDescription ?? '')
            : 'N/A';

    return GestureDetector(
      onTap: () {
        setState(() {
          showBottomSheet = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: showBottomSheet ? 230 : 55,
        decoration: AppUtils.commonBoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppUtils.commonSizedBox(height: 10),
              InkWell(
                  onTap: () {
                    setState(() {
                      showBottomSheet = !showBottomSheet;
                    });
                  },
                  child: Icon(
                    !showBottomSheet
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 40,
                  )),
              AppUtils.commonSizedBox(height: 10),
              Visibility(
                visible: showBottomSheet,
                child: Padding(
                  padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppUtils.commonTextWidget(
                              text: "Description",
                              textColor: AppColors.colorMainBlack,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ],
                      ),
                      AppUtils.commonSizedBox(height: 10),
                      (description.isNotEmpty ? description : 'N/A')
                          .htmlTextView(
                        color: AppColors.colorDarkGrey,
                      ),
                      // AppUtils.commonTextWidget(
                      //     text: description,
                      //     textColor: AppColors.colorDarkGrey,
                      //     letterSpacing: 1,
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500),
                      AppUtils.commonSizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
