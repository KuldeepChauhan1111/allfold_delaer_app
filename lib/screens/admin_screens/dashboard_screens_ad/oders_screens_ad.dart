// import 'package:flutter/material.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
// import 'package:sales_app/models/admin_models/get_all_orders_model.dart';
// import 'package:sales_app/screens/admin_screens/oder_screens_ad/order_detail_screen_ad.dart';
//
// class OrdersScreenAD extends StatefulWidget {
//   const OrdersScreenAD({Key? key}) : super(key: key);
//
//   @override
//   State<OrdersScreenAD> createState() => _OrdersScreenADState();
// }
//
// class _OrdersScreenADState extends State<OrdersScreenAD>
//     with TickerProviderStateMixin {
//   TabController? _tabController;
//
//   GetAllOrdersModel? getAllOrdersModel;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController?.addListener(() {});
//   }
//
//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         TabBar.secondary(
//           dividerColor: AppColors.colorText,
//           labelColor: AppColors.colorPrimary,
//           labelStyle: const TextStyle(
//               fontWeight: FontWeight.bold, color: AppColors.colorPrimary),
//           unselectedLabelStyle: const TextStyle(
//               fontWeight: FontWeight.w500, color: AppColors.colorText),
//           indicatorColor: AppColors.colorPrimary,
//           unselectedLabelColor: AppColors.colorText,
//           controller: _tabController,
//           tabs: const <Widget>[
//             Tab(text: 'Current'),
//             Tab(text: 'Past'),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: _tabController,
//             children: <Widget>[
//               tabOneWidget(),
//               tabTwoWidget(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   tabOneWidget() {
//     return ListView.builder(
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       itemCount: 0,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: AppUtils.edgeInsetsOnly(left: 10, right: 10),
//           child: Column(
//             children: [
//               AppUtils.commonSizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => OrderHistoryDetailScreenAD(
//                             isPast: false,
//                             orderDate: '',
//                             orderId: 0,
//                             orderStatus: '',
//                             salesOrderId: 0),
//                       )).then((value) {});
//                 },
//                 child: AppUtils.commonContainer(
//                   width: double.infinity,
//                   decoration: AppUtils.commonBoxDecoration(
//                     color: AppColors.colorWhite,
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.colorSecondary.withOpacity(0.1),
//                         spreadRadius: 1,
//                         blurRadius: 5,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                     borderRadius: AppUtils.borderRadiusAll(raduis: 12),
//                   ),
//                   child: Padding(
//                     padding: AppUtils.edgeInsetsAll(allPadding: 8),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 AppUtils.commonTextWidget(
//                                     text: "#",
//                                     letterSpacing: 0.5,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     textColor: AppColors.colorPrimary),
//                                 AppUtils.commonSizedBox(width: 5),
//                                 AppUtils.commonTextWidget(
//                                     text: "by",
//                                     letterSpacing: 0.5,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     textColor: AppColors.colorText),
//                               ],
//                             ),
//                             AppUtils.commonSizedBox(width: 5),
//                             AppUtils.commonTextWidget(
//                                 text: AppUtils.getDate(
//                                     date: '10-10-2010', format: "dd-MM-yyyy"),
//                                 letterSpacing: 0.5,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 textColor: AppColors.colorPrimary),
//                           ],
//                         ),
//                         AppUtils.commonSizedBox(height: 5),
//                         AppUtils.commonTextWidget(
//                             text: '',
//                             letterSpacing: 0.5,
//                             fontSize: 16,
//                             textColor: AppColors.colorText),
//                         AppUtils.commonSizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 AppUtils.commonTextWidget(
//                                     text: "Total Item :",
//                                     letterSpacing: 0.5,
//                                     fontSize: 16,
//                                     textColor: AppColors.colorText),
//                                 AppUtils.commonSizedBox(width: 5),
//                                 AppUtils.commonTextWidget(
//                                     text: '',
//                                     letterSpacing: 0.5,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     textColor: AppColors.colorText),
//                               ],
//                             ),
//                             AppUtils.commonSizedBox(width: 5),
//                             AppUtils.commonContainer(
//                               padding: AppUtils.edgeInsetsAll(allPadding: 8),
//                               decoration: AppUtils.commonBoxDecoration(
//                                   color: AppColors.colorBg,
//                                   borderRadius:
//                                       AppUtils.borderRadiusAll(raduis: 12)),
//                               child: AppUtils.commonTextWidget(
//                                   text: '',
//                                   letterSpacing: 0.5,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   textColor: AppUtils.getStatusColor('')),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               AppUtils.commonSizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   tabTwoWidget() {
//     return ListView.builder(
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       itemCount: 0,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: AppUtils.edgeInsetsOnly(left: 10, right: 10),
//           child: Column(
//             children: [
//               AppUtils.commonSizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => OrderHistoryDetailScreenAD(
//                             isPast: false,
//                             orderDate: '',
//                             orderId: 0,
//                             orderStatus: '',
//                             salesOrderId: 0),
//                       )).then((value) {});
//                 },
//                 child: AppUtils.commonContainer(
//                   width: double.infinity,
//                   decoration: AppUtils.commonBoxDecoration(
//                     color: AppColors.colorWhite,
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.colorSecondary.withOpacity(0.1),
//                         spreadRadius: 1,
//                         blurRadius: 5,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                     borderRadius: AppUtils.borderRadiusAll(raduis: 12),
//                   ),
//                   child: Padding(
//                     padding: AppUtils.edgeInsetsAll(allPadding: 8),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 AppUtils.commonTextWidget(
//                                     text: "#",
//                                     letterSpacing: 0.5,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     textColor: AppColors.colorPrimary),
//                                 AppUtils.commonSizedBox(width: 5),
//                                 AppUtils.commonTextWidget(
//                                     text: "by",
//                                     letterSpacing: 0.5,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     textColor: AppColors.colorText),
//                               ],
//                             ),
//                             AppUtils.commonSizedBox(width: 5),
//                             AppUtils.commonTextWidget(
//                                 text: AppUtils.getDate(
//                                     date: '10-10-2010', format: "dd-MM-yyyy"),
//                                 letterSpacing: 0.5,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 textColor: AppColors.colorPrimary),
//                           ],
//                         ),
//                         AppUtils.commonSizedBox(height: 5),
//                         AppUtils.commonTextWidget(
//                             text: '',
//                             letterSpacing: 0.5,
//                             fontSize: 16,
//                             textColor: AppColors.colorText),
//                         AppUtils.commonSizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 AppUtils.commonTextWidget(
//                                     text: "Total Item :",
//                                     letterSpacing: 0.5,
//                                     fontSize: 16,
//                                     textColor: AppColors.colorText),
//                                 AppUtils.commonSizedBox(width: 5),
//                                 AppUtils.commonTextWidget(
//                                     text: '',
//                                     letterSpacing: 0.5,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     textColor: AppColors.colorText),
//                               ],
//                             ),
//                             AppUtils.commonSizedBox(width: 5),
//                             AppUtils.commonContainer(
//                               padding: AppUtils.edgeInsetsAll(allPadding: 8),
//                               decoration: AppUtils.commonBoxDecoration(
//                                   color: AppColors.colorBg,
//                                   borderRadius:
//                                       AppUtils.borderRadiusAll(raduis: 12)),
//                               child: AppUtils.commonTextWidget(
//                                   text: '',
//                                   letterSpacing: 0.5,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   textColor: AppUtils.getStatusColor('')),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               AppUtils.commonSizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
