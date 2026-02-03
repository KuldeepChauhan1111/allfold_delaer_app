import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/app_bar_widget2.dart';
import 'package:sales_app/core/widgets/card_widget.dart';
import 'package:sales_app/core/widgets/circle_loading_indicator_widget.dart';
import 'package:sales_app/features/product/data/models/get_product_by_categories_response.dart';
import 'package:sales_app/features/product/dependency/product_get_it.dart';
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';
import 'package:sales_app/features/product/presentation/blocs/product_state.dart';

@RoutePage()
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final int? categoryId;
  final String? categoryName;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = productGetIt.get<ProductCubit>();
    _productCubit.apiCallGetProductByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _productCubit,
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return AppScaffold(
              isBgAsset: false,
              // bg: icBg2,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: AppBarWidget2(
                      isBackVisible: true,
                      title: widget.categoryName?.toUpperCase(),
                    )),
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      10.toSizedBoxHeight,
                      Expanded(
                        child: (_productCubit.productList.isEmpty)
                            ? AppUtils.noDataWidget()
                            : GridView.builder(
                          physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                                itemCount: _productCubit.productList.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 270
                                ),
                                itemBuilder: (context, index) {
                                  return _listItem(
                                    index: index,
                                    item: _productCubit.productList[index],
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: state is LoadingState,
                      child: const CircleLoadingIndicatorWidget()),
                ],
              ));
        },
      ),
    );
  }

  // Widget _listItem({required int index, ProductInfo? item}) {
  //   return Container(
  //     width: double.infinity,
  //     margin: EdgeInsets.only(
  //         left: (index % 2 == 0) ? 12 : 2,
  //         right: (index % 2 != 0) ? 12 : 2,
  //         top: 4,
  //         bottom: 4),
  //     child: InkWell(
  //       borderRadius: BorderRadius.circular(12),
  //       onTap: () {
  //         AutoRouter.of(context)
  //             .push(ProductDetailRoute(productId: item?.productId ?? 0))
  //             .then((val) {
  //           if (val != null) {
  //             if (kDebugMode) {
  //               print('logcat :: back to product listing screen');
  //             }
  //             _productCubit.getCartItemCount();
  //           }
  //         });
  //       },
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             height: 250,
  //             width: double.infinity,
  //             child: CardWidget(
  //               cardDefaultMargin: 2,
  //                 cardBgColor: AppColors.colorWhite,
  //                 marginHorizontal: 0,
  //                 cardRadius: 12,
  //                 child: Stack(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 4),
  //                       // child: (item?.image ?? '').toNetWorkImage(
  //                       //     fit: BoxFit.contain,
  //                       //     width: double.infinity,
  //                       //     borderRadius: 8,
  //                       //     height: 240),
  //                       child: (item?.image ?? '').imageBase64(
  //                         height: 240,
  //                         width: double.infinity,
  //                       ),
  //                     ),
  //                     // Positioned(
  //                     //     right: 0,
  //                     //     top: 0,
  //                     //     child: InkWell(
  //                     //       onTap: () {
  //                     //         int isFav = item?.favourite ?? 0;
  //                     //         int updateFav = (isFav == 0) ? 1 : 0;
  //                     //         _productCubit.apiCallFavoriteUnFavorite(
  //                     //             item?.productId, updateFav);
  //                     //       },
  //                     //       child: Padding(
  //                     //         padding: const EdgeInsets.all(10.0),
  //                     //         child: Icon(Icons.favorite_outlined,
  //                     //             color: ((item?.favourite ?? 0) == 1)
  //                     //                 ? AppColors.colorPrimary
  //                     //                 : AppColors.colorGrey),
  //                     //       ),
  //                     //     )),
  //                   ],
  //                 )),
  //           ),
  //           8.toSizedBoxHeight,
  //           Padding(
  //             padding: const EdgeInsets.only(left: 12.0, right: 4),
  //             child: (item?.productName ?? 'N/A').textWidget(
  //                 fontSize: fontSizeNormal + 1,
  //                 fontWeight: FontWeight.bold,
  //                 color: AppColors.colorWhite,
  //                 maxLine: 1,
  //                 overflow: TextOverflow.ellipsis),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _listItem({required int index, ProductInfo? item}) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        AutoRouter.of(context)
            .push(ProductDetailRoute(productId: item?.productId ?? 0))
            .then((val) {
          if (val != null) {
            _productCubit.getCartItemCount();
          }
        });
      },
      child: Stack(
        children: [
          Container(
            // height: 500,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: AppColors.colorBg,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorPrimary.withOpacity(0.25),
                  offset: const Offset(0, 1.5),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.max, // Allow dynamic height
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: (item?.image ?? '').imageBase64(
                      height: 170,
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                (item?.productName ?? 'N/A').textWidget(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppConstants.fontFamilyPoppins,
                  fontSize: 14,
                  color: AppColors.colorLightGrey,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: 145,
              height: 145,
              child: CustomPaint(painter: GlowingArcPainter()),
            ),
          ),
        ],
      ),
    );
  }


// Widget _listItem3({required int index, ProductInfo? item}) {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 0),
//
//     margin: EdgeInsets.only(
//         left: (index % 2 == 0) ? 12 : 2,
//         right: (index % 2 != 0) ? 12 : 2,
//         top: 4,
//         bottom: 4),
//     child: Stack(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(24),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.white.withOpacity(0.1)
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Container(
//
//                   // height: 240,
//                   padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
//                   decoration: BoxDecoration(
//                     color: AppColors.colorBg,
//                     borderRadius: BorderRadius.circular(24),
//                     border: Border.all(color: Colors.white.withOpacity(0.08)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.colorPrimary.withOpacity(0.25),
//                         blurRadius: 0,
//                         spreadRadius: 0.0,
//                         offset: const Offset(0, 1.5),
//                       ),
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.6),
//                         blurRadius: 30,
//                         offset: const Offset(0, 12),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 12),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Container(
//                           child: (item?.image ?? '').imageBase64(
//                               height: 200, fit: BoxFit.contain),
//                         ),),
//
//                       SizedBox(height: 0),
//                       (item?.productName ?? 'N/A').textWidget(
//                           fontWeight: FontWeight.bold,
//                           fontFamily: AppConstants.fontFamilyPoppins,
//                           fontSize: 16,
//                           color: AppColors.colorLightGrey,
//                           overflow: TextOverflow.ellipsis
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 0,
//           right: 0,
//           child: SizedBox(
//             width: 145,
//             height: 145,
//             child: CustomPaint(painter: GlowingArcPainter()),
//           ),
//         ),
//       ],
//     ),
//   );
// }
}

class GlowingArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 1.0;
    final padding = strokeWidth / 2;

    final rect = Rect.fromLTWH(
      padding,
      padding,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));
    final borderPath = Path()..addRRect(rrect);

    final pathMetrics = borderPath.computeMetrics().first;
    final totalLength = pathMetrics.length;

    final start = totalLength * 0.3;
    final end = totalLength * 0.65;

    final glowingArc = pathMetrics.extractPath(start, end);

    // Outer glow layer - soft and diffused
    final outerGlowPaint = Paint()
      ..color = AppColors.colorPrimary.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawPath(glowingArc, outerGlowPaint);

    // Mid glow layer
    final midGlowPaint = Paint()
      ..color = AppColors.colorPrimary.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawPath(glowingArc, midGlowPaint);

    // Inner bright stroke
    final innerPaint = Paint()
      ..color = AppColors.colorPrimary // Light core
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(glowingArc, innerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
