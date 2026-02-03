import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/utils/image_path.dart';
import 'package:sales_app/core/widgets/app_bar_widget.dart';
import 'package:sales_app/core/widgets/app_bar_widget2.dart';
import 'package:sales_app/core/widgets/circle_loading_indicator_widget.dart';
import 'package:sales_app/core/widgets/common_button_widget.dart';
import 'package:sales_app/features/favorites/data/models/get_favorite_list_response.dart';
import 'package:sales_app/features/favorites/dependency/favorite_get_it.dart';
import 'package:sales_app/features/favorites/presentation/blocs/favorite_cubit.dart';
import 'package:sales_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:sales_app/features/product/dependency/product_get_it.dart';
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';
import 'package:sales_app/features/product/presentation/blocs/product_state.dart'
    as prod_state;

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late ProductCubit _productCubit;
  late FavoriteCubit _favoriteCubit;

  List<String> favList = ['Hunter', 'Aristo', 'Legendary'];
  List<String> stepsList = ['3', '4', '5'];
  List<String> colorList = ['Grey', 'Gold', 'Silver'];
  List<String> materialList = ['Aluminium', 'Mild Steel', 'Stainless Steel'];
  List<String> imageList = [fav1, fav2, fav3];

  @override
  void initState() {
    super.initState();
    _productCubit = productGetIt.get<ProductCubit>();
    _favoriteCubit = favoriteGetIt.get<FavoriteCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(create: (context) {
          _productCubit.getCartItemCount();
          return _productCubit;
        }),
        BlocProvider<FavoriteCubit>(create: (context) {
          _favoriteCubit.apiCallGetFavoriteList();
          return _favoriteCubit;
        }),
      ],
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          return BlocBuilder<ProductCubit, prod_state.ProductState>(
            builder: (context, stateProd) {
              return AppScaffold(
                appBar: PreferredSize(
                  preferredSize: const Size(double.infinity, appBarSize),
                  child:AppBarWidget2(
                    centerTitle: false,
                    title: titleFavorite,
                  ),
                ),
                body: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: _favoriteCubit.favoriteProductList.isEmpty
                              ? AppUtils.noDataWidget(msg: msgNoDataFavorite)
                              : ListView.builder(
                                  // itemCount: favList.length,
                                  itemCount:
                                      _favoriteCubit.favoriteProductList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return _listItem(
                                        index,
                                        _favoriteCubit
                                            .favoriteProductList[index]);
                                  },
                                ),
                        ),
                      ],
                    ),
                    Visibility(
                        visible: state is LoadingState ||
                            stateProd is prod_state.LoadingState,
                        child: const CircleLoadingIndicatorWidget())
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _listItem(int index, Products? item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.colorLightGrey,
      ),

      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Slidable(
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
                onPressed: (context) {
                  AppUtils.showCustomTwoBtnDialog(
                    ctx: context,
                    dialogBtnTextRight: lblYes,
                    dialogBtnTextLeft: lblNo,
                    dialogMessage: msgRemoveProductFromFavorite,
                    dialogTitle: lblAlert,
                    dialogBtnRightFnc: () {
                      _productCubit.apiCallFavoriteUnFavorite(item?.productVariantId, 0,
                          callBack: () {
                        _favoriteCubit.removeItemFromFavoriteList(index);
                      });
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
                // label: 'Delete',
              ),
            ],
          ),
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            child: InkWell(
              onTap: () {
                AutoRouter.of(context)
                    .push(ProductDetailRoute(productId: item?.productId ?? 0))
                    .then((val) {
                  _productCubit.getCartItemCount();
                  _favoriteCubit.apiCallGetFavoriteList();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      AppUtils.commonSizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (item?.productName ?? '').textWidget(
                              fontSize: fontSizeMedium,
                              fontWeight: FontWeight.w600,
                              color: AppColors.colorWhite,
                            ),
                            2.toSizedBoxHeight,
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    '$lblPrice : '.richTextView(
                                        color: AppColors.colorLightGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizeSmall,
                                        textSpanList: [
                                          const WidgetSpan(
                                              child: SizedBox(width: 4)),
                                          TextSpan(
                                              text: (item?.price ?? 0).toString(),
                                              style: const TextStyle(
                                                color: AppColors.colorWhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: fontSizeSmall,
                                              ))
                                        ]),
                                    2.toSizedBoxHeight,
                                    '$lblMaterial : '.richTextView(
                                        color: AppColors.colorLightGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizeSmall,
                                        textSpanList: [
                                          const WidgetSpan(
                                              child: SizedBox(width: 4)),
                                          TextSpan(
                                              text: item?.productVariant?.material
                                                      ?.name ??
                                                  'N/A',
                                              style: const TextStyle(
                                                color: AppColors.colorWhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: fontSizeSmall,
                                              ))
                                        ]),
                                    2.toSizedBoxHeight,
                                    '$lblColor : '.richTextView(

                                        color: AppColors.colorLightGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizeSmall,
                                        textSpanList: [
                                          const WidgetSpan(
                                              child: SizedBox(width: 4)),
                                          TextSpan(
                                              text: item?.productVariant?.color
                                                      ?.name ??
                                                  'N/A',
                                              style: const TextStyle(
                                                color: AppColors.colorWhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: fontSizeSmall,
                                              ))
                                        ]),
                                  ],
                                )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CommonButtonWidget(
                                      buttonText: lblAddToCart,
                                      verticalPadding: 6,
                                      borderRadius: 5,
                                      fontSize: 12,
                                      onPressed: () {
                                        AutoRouter.of(context).push(
                                            ProductDetailRoute(productId: item?.productId ?? 0));
                                      },
                                    ),
                                    15.toSizedBoxHeight,
                                    AppUtils.commonTextWidget(
                                      text: '< $lblSwipeToRemove',
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      textColor: AppColors.colorPrimary,
                                    )
                                  ],
                                )
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
          )),
    );
  }
}
