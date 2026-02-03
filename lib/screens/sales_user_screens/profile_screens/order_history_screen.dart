// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
// import 'package:sales_app/models/sales_user_models/get_order_history_model.dart';
// import 'package:sales_app/features/cart/presentation/pages/cart_screen.dart';
// import 'package:sales_app/screens/sales_user_screens/profile_screens/order_history_detail_screen.dart';
//
// class OrderHistoryScreen extends StatefulWidget {
//   const OrderHistoryScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
// }
//
// class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
//   ValueNotifier<bool> _isVisible = ValueNotifier(true);
//   var _hideBottomNavController;
//   GetOrderHistoryModel? getOrderHistoryModel;
//
//   // final ScrollController scrollController = ScrollController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // productList = AppUtils.addProductIntoList();
//
//     // _isVisible = true;
//
//     _hideBottomNavController = ScrollController();
//     _hideBottomNavController.addListener(
//       () {
//         if (_hideBottomNavController.position.userScrollDirection ==
//             ScrollDirection.reverse) {
//           if (_isVisible.value)
//             // setState(() {
//             _isVisible.value = false;
//           // });
//         }
//         if (_hideBottomNavController.position.userScrollDirection ==
//             ScrollDirection.forward) {
//           if (!_isVisible.value)
//             // setState(() {
//             _isVisible.value = true;
//           // });
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: AppScaffold(
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(kToolbarHeight),
//             child: ValueListenableBuilder<bool>(
//                 valueListenable: _isVisible,
//                 builder: (context, value, child) {
//                   return AnimatedContainer(
//                     height: value ? 86 : 0.0,
//                     duration: Duration(milliseconds: 500),
//                     child: appBarRow(),
//                   );
//                 }),
//           ),
//           body: Column(
//             children: [
//               ValueListenableBuilder<bool>(
//                   valueListenable: _isVisible,
//                   builder: (context, value, child) {
//                     return AnimatedContainer(
//                       height: value ? 0 : 20,
//                       duration: Duration(microseconds: 2000),
//                     );
//                   }),
//               AppUtils.commonSizedBox(height: 20),
//               Expanded(
//                 child: SingleChildScrollView(
//                   controller: _hideBottomNavController,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: AppUtils.edgeInsetsOnly(
//                             left: 10, right: 10, bottom: 10),
//                         child: ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: 10,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 AppUtils.commonInkWell(
//                                   borderRadius: BorderRadius.circular(24),
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               OrderHistoryDetailScreen(
//                                                   salesOrderId: 0,
//                                                   orderDate: '10-10-2010',
//                                                   orderStatus: ''),
//                                         ));
//                                   },
//                                   child: AppUtils.commonContainer(
//                                     width: double.infinity,
//                                     decoration: AppUtils.commonBoxDecoration(
//                                       border: Border.all(
//                                           color: AppColors.colorSecondary),
//                                       borderRadius:
//                                           AppUtils.borderRadiusAll(raduis: 24),
//                                     ),
//                                     padding:
//                                         AppUtils.edgeInsetsAll(allPadding: 8),
//                                     child: Column(children: [
//                                       AppUtils.commonSizedBox(height: 15),
//                                       itemCommonRow(
//                                           text1: "Order ID", text2: ""),
//                                       AppUtils.commonSizedBox(height: 10),
//                                       itemCommonRow(
//                                           text1: "Total Items", text2: ''),
//                                       AppUtils.commonSizedBox(height: 10),
//                                       itemCommonRow(
//                                           text1: "Status",
//                                           text2: '',
//                                           text2Color: AppColors.colorPrimary),
//                                       AppUtils.commonSizedBox(height: 20),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           AppUtils.commonTextWidget(
//                                               // text:
//                                               //     "12 May 2023 at 12:30PM",
//                                               text: AppUtils.getDate(
//                                                   date: '10-10-2010',
//                                                   format: "dd-MM-yyyy"),
//                                               letterSpacing: 0.5,
//                                               textColor: AppColors.colorPrimary,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 14),
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         OrderHistoryDetailScreen(
//                                                             salesOrderId: 0,
//                                                             orderDate:
//                                                                 '10-10-2010',
//                                                             orderStatus: ''),
//                                                   ));
//                                             },
//                                             child: Row(
//                                               children: [
//                                                 AppUtils.commonTextWidget(
//                                                     text: "See Details",
//                                                     letterSpacing: 0.5,
//                                                     textColor: AppColors
//                                                         .colorSecondary,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 14),
//                                                 AppUtils.commonSizedBox(
//                                                     width: 5),
//                                                 Icon(
//                                                   Icons
//                                                       .arrow_forward_ios_rounded,
//                                                   color:
//                                                       AppColors.colorSecondary,
//                                                   size: 14,
//                                                 )
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ]),
//                                   ),
//                                 ),
//                                 AppUtils.commonSizedBox(height: 15),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
//
//   Widget itemCommonRow(
//       {String? text1,
//       String? text2,
//       Color? text1Color,
//       Color? text2Color,
//       double? text1Size,
//       FontWeight? text1FontWeight,
//       FontWeight? text2FontWeight,
//       double? text2Size}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         AppUtils.commonTextWidget(
//             text: text1 ?? "",
//             letterSpacing: 1,
//             textColor: text1Color ?? AppColors.colorSecondary,
//             fontWeight: text1FontWeight ?? FontWeight.bold,
//             fontSize: text1Size ?? 14),
//         AppUtils.commonTextWidget(
//             text: text2 ?? "",
//             letterSpacing: 1,
//             textColor: text2Color ?? AppColors.colorPrimary,
//             fontWeight: text2FontWeight ?? FontWeight.bold,
//             fontSize: text2Size ?? 15),
//       ],
//     );
//   }
//
//   var selectedSortValue;
//
//   selectedSort(value, BuildContext sheetCtx) {
//     Navigator.pop(sheetCtx);
//     setState(() {
//       selectedSortValue = value;
//     });
//   }
//
//   PreferredSizeWidget appBarRow() {
//     return AppBar(
//       backgroundColor: AppColors.colorTransparent,
//       surfaceTintColor: AppColors.colorTransparent,
//       shadowColor: AppColors.colorTransparent,
//       automaticallyImplyLeading: false,
//       elevation: 0,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               AppUtils.commonInkWell(
//                 borderRadius: BorderRadius.circular(20),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: AppUtils.commonContainer(
//                     padding: AppUtils.edgeInsetsOnly(
//                         top: 15, bottom: 15, left: 12, right: 12),
//                     decoration: AppUtils.commonBoxDecoration(
//                         borderRadius: AppUtils.borderRadiusAll(raduis: 18),
//                         border: Border.all(color: AppColors.colorPrimary)),
//                     child: Center(
//                       child: Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         size: 18,
//                         color: AppColors.colorSecondary,
//                       ),
//                     )),
//               ),
//               AppUtils.commonSizedBox(width: 15),
//               AppUtils.commonTextWidget(
//                   text: "Orders History",
//                   textColor: AppColors.colorPrimary,
//                   fontSize: 16,
//                   letterSpacing: 0.5,
//                   fontWeight: FontWeight.w700),
//             ],
//           ),
//           Row(
//             children: [
//               // IconButton(
//               //     onPressed: () {
//               //       _showSearch();
//               //     },
//               //     icon: Icon(
//               //       Icons.search,
//               //       color: AppColors.colorWhite,
//               //     )),
//               IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CartScreen(),
//                         ));
//                   },
//                   icon: Icon(Icons.shopping_bag_outlined,
//                       color: AppColors.colorPrimary)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
