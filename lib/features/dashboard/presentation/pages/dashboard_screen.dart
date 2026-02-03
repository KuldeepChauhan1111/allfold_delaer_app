import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/features/cart/presentation/pages/cart_screen.dart';
import 'package:sales_app/features/category/presentation/pages/category_screen.dart';
import 'package:sales_app/features/favorites/presentation/pages/favorite_screen.dart';
import 'package:sales_app/features/orders/presentation/pages/order_screen.dart';

import 'package:sales_app/features/profile/presentation/pages/profile_screen.dart';

int cartItemCount = 0;

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  final PageController _pageController = PageController(initialPage: 0);

  final _pages = [
    const CategoryScreen(),
    const OrderScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
  final _pageName = [
    'CATEGORIES',
    'ORDERS',
    'FAVORITES',
    'PROFILE',
  ];

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottomNavigationBar: _buildNavBar(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: _pages,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },

              ),
            ),
          ],
        ));
  }

  Widget _buildNavBar() {
    return AnimatedNotchBottomBar(
      showShadow: true,
      textOverflow: TextOverflow.visible,
      showTopRadius: true,
      circleMargin: 10,
      kBottomRadius: 10,
      // durationInMilliSeconds: 1000,
      notchBottomBarController: _controller,
      color: AppColors.colorWhite,
      showLabel: true,
      blurOpacity: 0.5,

      showBlurBottomBar: false,
      itemLabelStyle: TextStyle(
          fontFamily: AppConstants.fontFamilyPoppins,
          fontWeight: FontWeight.w800,
          fontSize: 12,
          color: AppColors.colorBg),

      notchGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.gradient1, AppColors.gradient2],
      ),
      notchColor: AppColors.colorPrimary,
      textAlign: TextAlign.center,
      kIconSize: 20,
      // Improved icon size for better visibility
      bottomBarItems: [
        BottomBarItem(
          itemLabel: "Home",
          inActiveItem: Icon(Icons.home_outlined, color: AppColors.colorBg),
          activeItem: Icon(Icons.home_rounded, color: AppColors.colorWhite),
        ),
        BottomBarItem(
          itemLabel: "Order",
          inActiveItem: Icon(Icons.note_outlined, color: AppColors.colorBg),
          activeItem: Icon(Icons.note, color: AppColors.colorWhite),
        ),
        BottomBarItem(
          itemLabel: "Favorites",
          inActiveItem:
              Icon(Icons.favorite_border_outlined, color: AppColors.colorBg),
          activeItem: Icon(Icons.favorite, color: AppColors.colorWhite),
        ),
        BottomBarItem(
          itemLabel: "Profile",
          inActiveItem: Icon(Icons.person_outline, color: AppColors.colorBg),
          activeItem: Icon(Icons.person, color: AppColors.colorWhite),
        ),
      ],
      onTap: (index) {
        _pageController.jumpToPage(index);
        setState(() => pageIndex = index);
      },
    );
  }

  // Widget _header() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: AppUtils.commonTextWidget(
  //           text: _pageName[pageIndex],
  //           fontSize: 20,
  //           fontWeight: FontWeight.w700,
  //           letterSpacing: 1,
  //           textColor: AppColors.colorPrimary,
  //         ),
  //       ),
  //       Row(
  //         children: [
  //           IconButton(
  //               onPressed: () {},
  //               icon: const Icon(
  //                 Icons.search,
  //                 color: AppColors.colorPrimary,
  //               )),
  //           IconButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => const CartScreen(),
  //                     ));
  //               },
  //               icon: const Icon(Icons.shopping_bag_outlined,
  //                   color: AppColors.colorPrimary)),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: AppUtils.commonBoxDecoration(
        // border: Border.all(color: AppColors.colorPrimary,width: 1.5),
        color: AppColors.colorLightGrey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          commonNavIcon(
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              givePageIndex: 0,
              iconSelected: Icons.home_rounded,
              iconUnselected: Icons.home_outlined),
          commonNavIcon(
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              givePageIndex: 1,
              iconSelected: Icons.category,
              iconUnselected: Icons.category_outlined),
          commonNavIcon(
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              givePageIndex: 2,
              iconSelected: Icons.favorite,
              iconUnselected: Icons.favorite_border_outlined),
          commonNavIcon(
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              givePageIndex: 3,
              iconSelected: Icons.person,
              iconUnselected: Icons.person_outline),
        ],
      ),
    );
  }

  Widget commonNavIcon(
      {VoidCallback? onPressed,
      int? givePageIndex,
      IconData? iconSelected,
      IconData? iconUnselected}) {
    return IconButton(
      enableFeedback: false,
      onPressed: onPressed,
      icon: pageIndex == givePageIndex
          ? Icon(
              iconSelected,
              color: AppColors.colorPrimary,
              size: 25,
            )
          : Icon(
              iconUnselected,
              color: AppColors.colorSecondary,
              size: 25,
            ),
    );
  }
}
