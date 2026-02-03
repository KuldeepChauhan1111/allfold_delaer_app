// import 'package:flutter/material.dart';
// import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/constants/app_constants.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
// import 'package:sales_app/screens/admin_screens/cart_scsreen_ad/cart_screen_ad.dart';
// import 'package:sales_app/screens/admin_screens/dashboard_screens_ad/oders_screens_ad.dart';
// import 'package:sales_app/screens/admin_screens/dashboard_screens_ad/profile_screen_ad.dart';
// import 'package:sales_app/screens/admin_screens/dashboard_screens_ad/users_screen_ad.dart';
//
// class DashboardScreenAD extends StatefulWidget {
//   const DashboardScreenAD({Key? key}) : super(key: key);
//
//   @override
//   State<DashboardScreenAD> createState() => _DashboardScreenADState();
// }
//
// class _DashboardScreenADState extends State<DashboardScreenAD> {
//   int pageIndex = 0;
//   final pages = [
//     // HomeScreenAD(),
//     OrdersScreenAD(),
//     UsersScreenAD(),
//     ProfileScreenAD(),
//   ];
//   final pageName = [
//     // "HOME",
//     "ORDERS",
//     "USERS",
//     "PROFILE",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       body: Scaffold(
//         // floatingActionButton: Visibility(
//         //     visible: pageIndex == 2,
//         //     child: floatingActionButton()),
//         backgroundColor: AppColors.colorTransparent,
//         // drawer: drawer(),
//         // appBar: appBar(),
//         body: Column(
//           children: [
//             Padding(
//               padding: AppUtils.edgeInsetsOnly(left: 20, right: 10, top: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding:AppUtils.edgeInsetsOnly(top: 10,bottom: 10),
//                     child: AppUtils.commonTextWidget(
//                         text: pageName[pageIndex],
//                         textAlign: TextAlign.center,
//                         fontSize: AppConstants.twentyFive,
//                         fontWeight: FontWeight.w700,
//                         letterSpacing: 1,
//                         textColor: AppColors.colorPrimary,
//                         fontFamily: AppConstants.fontFamilyTeko),
//                   ),
//                   IconButton(onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreenAD(),));
//                   }, icon: Icon(Icons.shopping_bag_outlined,color: AppColors.colorPrimary,))
//                 ],
//               ),
//             ),
//             Expanded(child: pages[pageIndex]),
//           ],
//         ),
//         bottomNavigationBar: buildMyNavBar(context),
//       ),
//     );
//   }
//
//   // Widget floatingActionButton(){
//   //   return AppUtils.commonInkWell(
//   //     onTap: (){
//   //       Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserScreenAD(),));
//   //     },
//   //     borderRadius: BorderRadius.circular(12),
//   //     child: AppUtils.commonContainer(
//   //       padding: AppUtils.edgeInsetsAll(allPadding: 8),
//   //       decoration: AppUtils.commonBoxDecoration(
//   //         color: AppColors.colorPrimary,
//   //         borderRadius: AppUtils.borderRadiusAll(raduis: 12),
//   //       ),
//   //       child: Row(
//   //         mainAxisSize: MainAxisSize.min,
//   //         children: [
//   //         Icon(Icons.add,color: AppColors.colorWhite),
//   //         AppUtils.commonSizedBox(width: 5),
//   //         AppUtils.commonTextWidget(text: "Add User",textColor: AppColors.colorWhite,fontWeight: FontWeight.bold),
//   //           AppUtils.commonSizedBox(width: 5),
//   //
//   //         ],),
//   //     ),
//   //   );
//   // }
//
//   Widget buildMyNavBar(BuildContext context) {
//     return Container(
//       height: 60,
//       decoration: AppUtils.commonBoxDecoration(
//         // border: Border.all(color: AppColors.colorPrimary,width: 1.5),
//         color: AppColors.colorBg,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           // commonNavIcon(
//           //     onPressed: () {
//           //       setState(() {
//           //         pageIndex = 0;
//           //       });
//           //     },
//           //     givePageIndex: 0,
//           //     iconSelected: Icons.home_filled,
//           //     iconUnselected: Icons.home_outlined),
//           commonNavIcon(
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 0;
//                 });
//               },
//               givePageIndex: 0,
//               iconSelected: Icons.reorder_rounded,
//               iconUnselected: Icons.reorder_rounded),
//           commonNavIcon(
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 1;
//                 });
//               },
//               givePageIndex: 1,
//               iconSelected: Icons.supervised_user_circle_sharp,
//               iconUnselected: Icons.supervised_user_circle_sharp),
//           commonNavIcon(
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 2;
//                 });
//               },
//               givePageIndex: 2,
//               iconSelected: Icons.person,
//               iconUnselected: Icons.person_outline),
//         ],
//       ),
//     );
//   }
//
//   Widget commonNavIcon(
//       {VoidCallback? onPressed,
//       int? givePageIndex,
//       IconData? iconSelected,
//       IconData? iconUnselected}) {
//     return IconButton(
//       enableFeedback: false,
//       onPressed: onPressed,
//       icon: givePageIndex == pageIndex
//           ? Icon(
//               iconSelected,
//               color: AppColors.colorPrimary,
//               size: 25,
//             )
//           : Icon(
//               iconUnselected,
//               color: AppColors.colorSecondary,
//               size: 25,
//             ),
//     );
//   }
// }
