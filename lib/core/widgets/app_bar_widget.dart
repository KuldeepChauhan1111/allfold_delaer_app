import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:sales_app/features/product/dependency/product_get_it.dart';
import 'package:sales_app/features/product/presentation/blocs/product_cubit.dart';
import 'package:sales_app/features/product/presentation/blocs/product_state.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    super.key,
    this.title,
    this.onBackPressed,
    this.onPressedSearch,
    this.onPressedCart,
    this.onPressedFav,
    this.isFavColor,
    this.isBackVisible = false,
    this.isSearchVisible = false,
    this.isCartVisible = true,
    this.isFavVisible = false,
    this.textAlign
  });

  final String? title;
  final Function? onBackPressed;
  final Function? onPressedSearch;
  final Function? onPressedCart;
  final Function? onPressedFav;
  final bool isBackVisible;
  final bool isSearchVisible;
  final bool isCartVisible;
  final bool isFavVisible;
  final Color? isFavColor;
  final TextAlign? textAlign;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorTransparent,
      surfaceTintColor: AppColors.colorTransparent,
      shadowColor: AppColors.colorTransparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          16.toSizedBoxWidth,
          _backArrow(context),
          AppUtils.commonSizedBox(width: widget.isBackVisible ? 15 : 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: (widget.title ?? '').textWidget(
                color: AppColors.colorPrimary,
                fontWeight: FontWeight.bold,
                fontFamily: AppConstants.fontFamilyTeko,
                latterSpacing: 1,
                fontSize: 26,
               textAlign: widget.textAlign
              ),
            ),
          ),
          _searchIcon(),
          10.toSizedBoxWidth,
          widget.isFavVisible ? _favIcon(context) : _cartIcon(context),
          10.toSizedBoxWidth,
        ],
      ),
    );
  }

  Widget _backArrow(BuildContext context) {
    return Visibility(
      visible: widget.isBackVisible,
      child: InkWell(
        onTap: () {
          if (widget.onBackPressed != null) {
            widget.onBackPressed!();
          } else {
            Navigator.pop(context, true);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.colorLightGrey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.colorLightGrey, width: 1.5)),
          child: AppUtils.commonContainer(
              padding: AppUtils.edgeInsetsOnly(
                  top: 12, bottom: 12, left: 10, right: 10),
              // decoration: AppUtils.commonBoxDecoration(
              //     borderRadius: AppUtils.borderRadiusAll(raduis: 15),
              //     border: Border.all(color: AppColors.colorPrimary)),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppColors.colorBg,
              )),
        ),
      ),
    );
  }

  Widget _searchIcon() {
    return Visibility(
        visible: widget.isSearchVisible,
        child: InkWell(
          onTap: () {
            if (widget.onPressedSearch != null) {
              widget.onPressedSearch!();
            }
          },
          child: const Icon(
            Icons.search,
            color: AppColors.colorWhite,
            size: 34,
          ),
        ));
  }

  Widget _cartIcon(BuildContext context) {
    return Visibility(
        visible: widget.isCartVisible,
        child: InkWell(
          onTap: () {
            if (widget.onPressedCart != null) {
              widget.onPressedCart!();
            } else {
              AutoRouter.of(context).push(const CartRoute()).then((val) {
                setState(() {});
              });
            }
          },
          child: SizedBox(
            height: 40,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 3.0, top: 3),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.colorWhite,
                    size: 30,
                  ),
                ),
                Positioned(right: 0, top: 0, child: _countView()),
              ],
            ),
          ),
        ));
  }

  Widget _favIcon(BuildContext context) {
    return Visibility(
        visible: widget.isFavVisible,
        child: InkWell(
          onTap: () {
            if (widget.onPressedFav != null) {
              widget.onPressedFav!();
            } /*else {
              // AutoRouter.of(context).push(const CartRoute()).then((val) {
              //   setState(() {});
              // });
            }*/
          },
          child: SizedBox(
            height: 30,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.only(right: 3, top: 3),
                  child: Icon(
                    Icons.favorite,
                    color: widget.isFavColor ??  AppColors.colorLightGrey,
                    size: 26,
                  ),
                ),
                // Positioned(right: 0, top: 0, child: _countView()),
              ],
            ),
          ),
        ));
  }

  Widget _countView() {
    return BlocProvider(
      create: (context) {
        return productGetIt<ProductCubit>()..getCartItemCount();
      },
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (kDebugMode) {
            print('logcat :: product state in app bar = $state');
            print('logcat :: product state in app bar count = $cartItemCount');
          }
          return Visibility(
            visible: cartItemCount > 0,
            // visible: false,
            child: Container(
              height: 17,
              width: 17,
              decoration: BoxDecoration(
                color: AppColors.colorPrimary.withOpacity(0.95),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: '$cartItemCount'.textWidget(
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
