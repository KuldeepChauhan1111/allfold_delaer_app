import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/image_path.dart';
import 'package:sales_app/core/widgets/app_bar_widget2.dart';
import 'package:sales_app/core/widgets/circle_loading_indicator_widget.dart';
import 'package:sales_app/features/category/data/models/get_categories_response.dart';
import 'package:sales_app/features/category/dependency/category_get_it.dart';
import 'package:sales_app/features/category/presentation/blocs/categories_cubit.dart';
import 'package:sales_app/features/category/presentation/blocs/categories_state.dart';
import 'package:sales_app/features/product/dependency/product_get_it.dart';
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';
import 'package:sales_app/features/product/presentation/blocs/product_state.dart'
    as prod_state;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoriesCubit _categoriesCubit;
  late ProductCubit _productCubit;

  late BuildContext mContext;

  @override
  void initState() {
    super.initState();
    _categoriesCubit = categoryGetIt.get<CategoriesCubit>();
    _productCubit = productGetIt.get<ProductCubit>();
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return _bodyView();
  }

  Widget _bodyView() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesCubit>(create: (context) {
          _categoriesCubit.apiCallGetCategories(mContext);
          return _categoriesCubit;
        }),
        BlocProvider<ProductCubit>(create: (context) {
          _productCubit.getCartItemCount();
          return _productCubit;
        }),
      ],
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          return AppScaffold(
            bg: icBg3,
            bgHeight: MediaQuery.of(context).size.height * 2,
            isBgAsset: false,
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, appBarSize),
              child: BlocBuilder<ProductCubit, prod_state.ProductState>(
                builder: (context, state) {
                  return AppBarWidget2(
                    centerTitle: false,
                    isBackVisible: false,
                    title: titleCategories,
                  );
                },
              ),
            ),
            body: (state is LoadingState)
                ? const CircleLoadingIndicatorWidget()
                : Column(
                    children: [
                      12.toSizedBoxHeight,
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: _categoriesCubit.categoryList.length,
                          itemBuilder: (context, index) {
                            // print("$_categoriesCubit.c")
                            return _listItem2(
                                index, _categoriesCubit.categoryList[index]);
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _listItem(int index, Categories item) {
    if ((item.parentCategoryInfo ?? []).isNotEmpty) return Container();
    return GestureDetector(
        onTap: () {
          if ((item.subCategories ?? 0) == 0) {
            AutoRouter.of(mContext)
                .push(ProductListRoute(
              categoryId: item.categoryId,
              categoryName: item.category,
            ))
                .then((val) {
              if (kDebugMode) {
                print('logcat :: refresh category');
              }

              _productCubit.getCartItemCount();
            });
          } else {
            AutoRouter.of(mContext)
                .push(SubCategoryRoute(
              categoriesCubit: _categoriesCubit,
              categoryItem: item,
            ))
                .then((val) {
              if (kDebugMode) {
                print('logcat :: refresh category else');
              }
              _productCubit.getCartItemCount();
            });
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          width: double.infinity,
          child: RepaintBoundary(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: ClipPath(
                clipper: index % 2 != 0
                    ? DiagonalBottomRightClipper()
                    : DiagonalTopLeftClipper(),
                child: BackdropFilter(
                  enabled: true,
                  blendMode: BlendMode.src,
                  filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorLightGrey.withOpacity(0.08),
                          spreadRadius: 12,
                          blurStyle: BlurStyle.solid,
                          blurRadius: 30,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: AppColors.colorTransparent,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.categoryCardColor,
                          AppColors.categoryCardColor2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(26),
                      // border: Border.all(color: AppColors.colorLightGrey,width: 0.2)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: (item.image ?? '').imageBase64(
                              height: 160, width: 350, fit: BoxFit.cover),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            (item.category ?? 'N/A').textWidget(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppConstants.fontFamilyPoppins,
                              fontSize: 26,
                              color: AppColors.colorLightGrey,
                            ),
                            5.toSizedBoxHeight,
                            '${item.productsCount ?? 0} Products'.textWidget(
                                fontFamily: AppConstants.fontFamilyPoppins,
                                fontSize: fontSizeSmall,
                                fontWeight: FontWeight.bold,
                                color: AppColors.colorLightGrey),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
    // return AppUtils.commonInkWell(
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) =>
    //               ProductListScreen(categoryId: 0, categoryName: ''),
    //         ));
    //   },
    //   child: AppUtils.commonContainer(
    //     child: Padding(
    //       padding: AppUtils.edgeInsetsOnly(left: 20, right: 0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               AppUtils.commonTextWidget(
    //                   text: 'asdasdas',
    //                   fontSize: 18,
    //                   fontFamily: AppConstants.fontFamilyTeko,
    //                   textColor: AppColors.colorSecondary,
    //                   fontWeight: FontWeight.w600,
    //                   letterSpacing: 1),
    //               AppUtils.commonTextWidget(
    //                   text: '',
    //                   fontSize: 11,
    //                   fontFamily: AppConstants.fontFamilyPoppins,
    //                   textColor: AppColors.colorPrimary,
    //                   fontWeight: FontWeight.w600,
    //                   letterSpacing: 0.5),
    //             ],
    //           ),
    //           AppUtils.commonContainer(
    //             padding: AppUtils.edgeInsetsOnly(
    //                 left: 20, top: 25, bottom: 25, right: 0),
    //             height: 80,
    //             width: 180,
    //             child: CachedNetworkImage(
    //               imageUrl: '',
    //               imageBuilder: (context, imageProvider) => Container(
    //                 decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                       image: imageProvider, fit: BoxFit.scaleDown),
    //                 ),
    //               ),
    //               placeholder: (context, url) => Center(
    //                   child: CircularProgressIndicator(
    //                 color: AppColors.colorPrimary,
    //                 strokeWidth: 1.5,
    //               )),
    //               errorWidget: (context, url, error) => Icon(
    //                   Icons.image_rounded,
    //                   size: 40,
    //                   color: AppColors.colorPrimary),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _listItem2(int index, Categories item) {
    if ((item.parentCategoryInfo ?? []).isNotEmpty) return Container();
    return GestureDetector(
      onTap: index % 2 == 0
          ? () {} :() {
        if ((item.subCategories ?? 0) == 0) {
          AutoRouter.of(mContext)
              .push(ProductListRoute(
            categoryId: item.categoryId,
            categoryName: item.category,
          ))
              .then((val) {
            if (kDebugMode) {
              print('logcat :: refresh category');
            }

            _productCubit.getCartItemCount();
          });
        } else {
          AutoRouter.of(mContext)
              .push(SubCategoryRoute(
            categoriesCubit: _categoriesCubit,
            categoryItem: item,
          ))
              .then((val) {
            if (kDebugMode) {
              print('logcat :: refresh category else');
            }
            _productCubit.getCartItemCount();
          });
        }
      },
      child: AnimatedGradientBorder(
        borderRadius: BorderRadius.circular(24),
        gradientColors: [
          AppColors.gradient1,
          AppColors.gradient2,
          AppColors.colorTransparent,
          AppColors.colorTransparent,
          AppColors.colorTransparent,
          AppColors.colorTransparent,
          AppColors.gradient1,
          AppColors.gradient2,
        ],
        // stretchAlongAxis: true,
        glowSize: 5,
        stretchAxis: Axis.vertical,

        borderSize: 0.5,
          animationProgress: 0.42,

        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.colorBg,
              borderRadius: BorderRadius.circular(24),
              ),
          // width: 120,
          // height: 160,
          child: Container(
            // height: 200,
            // width: 200,
            decoration: BoxDecoration(
              color: AppColors.colorBg,
              borderRadius: BorderRadius.circular(24),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Glowing circle effect at the top-right
                  Positioned(
                    top: -180,
                    right: -180,
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          tileMode: TileMode.mirror,
                          colors: [
                            AppColors.colorPrimary.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          radius: 0.6,

                        ),
                      ),
                    ),
                  ),

                  // Main content
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: index % 2 == 0
                              ? Image.asset(clothStand,fit: BoxFit.cover,height: 180,):(item.image ?? '').imageBase64(
                              height: 160, width: 350, fit: BoxFit.cover),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            (item.category ?? 'N/A').textWidget(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppConstants.fontFamilyPoppins,
                              fontSize: 26,
                              color: AppColors.colorLightGrey,
                            ),
                            5.toSizedBoxHeight,
                            ((item
                      .productsCount == 0 || item.productsCount == null) ? "Coming Soon": "${item.productsCount ?? 0} Products").textWidget(
                                fontFamily: AppConstants.fontFamilyPoppins,
                                fontSize: fontSizeSmall,
                                fontWeight: FontWeight.bold,
                                color: AppColors.colorLightGrey),
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
    // return AppUtils.commonInkWell(
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) =>
    //               ProductListScreen(categoryId: 0, categoryName: ''),
    //         ));
    //   },
    //   child: AppUtils.commonContainer(
    //     child: Padding(
    //       padding: AppUtils.edgeInsetsOnly(left: 20, right: 0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               AppUtils.commonTextWidget(
    //                   text: 'asdasdas',
    //                   fontSize: 18,
    //                   fontFamily: AppConstants.fontFamilyTeko,
    //                   textColor: AppColors.colorSecondary,
    //                   fontWeight: FontWeight.w600,
    //                   letterSpacing: 1),
    //               AppUtils.commonTextWidget(
    //                   text: '',
    //                   fontSize: 11,
    //                   fontFamily: AppConstants.fontFamilyPoppins,
    //                   textColor: AppColors.colorPrimary,
    //                   fontWeight: FontWeight.w600,
    //                   letterSpacing: 0.5),
    //             ],
    //           ),
    //           AppUtils.commonContainer(
    //             padding: AppUtils.edgeInsetsOnly(
    //                 left: 20, top: 25, bottom: 25, right: 0),
    //             height: 80,
    //             width: 180,
    //             child: CachedNetworkImage(
    //               imageUrl: '',
    //               imageBuilder: (context, imageProvider) => Container(
    //                 decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                       image: imageProvider, fit: BoxFit.scaleDown),
    //                 ),
    //               ),
    //               placeholder: (context, url) => Center(
    //                   child: CircularProgressIndicator(
    //                 color: AppColors.colorPrimary,
    //                 strokeWidth: 1.5,
    //               )),
    //               errorWidget: (context, url, error) => Icon(
    //                   Icons.image_rounded,
    //                   size: 40,
    //                   color: AppColors.colorPrimary),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class DiagonalBottomRightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 26.0;
    final path = Path();

    // Start from top-left with radius
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    // Top-right with radius
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Right side down to above bottom-right
    path.lineTo(size.width, size.height - 30 - radius);
    path.quadraticBezierTo(
        size.width, size.height - 30, size.width - radius, size.height - 30);

    // Diagonal line to bottom-left (upward slope)
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // Left side up
    path.lineTo(0, radius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DiagonalBottomLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 26.0;
    final path = Path();

    // Start from top-right with radius
    path.moveTo(size.width, radius);
    path.quadraticBezierTo(size.width, 0, size.width - radius, 0);

    // Top-left with radius
    path.lineTo(radius, 0);
    path.quadraticBezierTo(0, 0, 0, radius);

    // Left side down to above bottom-left
    path.lineTo(0, size.height - 30 - radius);
    path.quadraticBezierTo(0, size.height - 30, radius, size.height - 30);

    // Diagonal line to bottom-right (upward slope from left)
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - radius);

    // Right side up
    path.lineTo(size.width, radius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DiagonalTopLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 26.0;
    final path = Path();

    // Start from bottom-right with radius
    path.moveTo(size.width, size.height - radius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - radius, size.height);

    // Bottom-left with radius
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // Left side up to below top-left
    path.lineTo(0, 30 + radius);
    path.quadraticBezierTo(0, 30, radius, 30);

    // Diagonal line to top-right (downward slope from left)
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Right side down
    path.lineTo(size.width, size.height - radius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
