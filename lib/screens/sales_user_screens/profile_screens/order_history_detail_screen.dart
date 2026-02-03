// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
// import 'package:sales_app/models/admin_models/get_oder_details_by_id_model.dart';
// import 'package:sales_app/features/cart/presentation/pages/cart_screen.dart';
// import 'package:sales_app/features/product/presentation/pages/product_detail_screen.dart';
//
// class OrderHistoryDetailScreen extends StatefulWidget {
//   int? salesOrderId;
//   String? orderDate;
//   String? orderStatus;
//
//   OrderHistoryDetailScreen(
//       {Key? key, this.orderDate, this.orderStatus, this.salesOrderId})
//       : super(key: key);
//
//   @override
//   State<OrderHistoryDetailScreen> createState() =>
//       _OrderHistoryDetailScreenState();
// }
//
// class _OrderHistoryDetailScreenState extends State<OrderHistoryDetailScreen> {
//   // List<CartModel> cartModelList = [];
//   GetOrderDetailsByIdModel? getOrderDetailsByIdModel;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       appBar: appBarRow(),
//       body: Padding(
//         padding: AppUtils.edgeInsetsOnly(left: 20, right: 20, top: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               AppUtils.commonTextWidget(
//                   text: "Order Summary",
//                   letterSpacing: 1,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   textColor: AppColors.colorText),
//               AppUtils.commonSizedBox(height: 15),
//               AppUtils.commonContainer(
//                 width: double.infinity,
//                 decoration: AppUtils.commonBoxDecoration(
//                   border: Border.all(color: AppColors.colorText),
//                   borderRadius: AppUtils.borderRadiusAll(raduis: 24),
//                 ),
//                 padding: AppUtils.edgeInsetsAll(allPadding: 8),
//                 child: ListView.builder(
//                   itemCount: 10,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   padding: EdgeInsets.zero,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         AppUtils.commonInkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ProductDetailScreen(productId: 0,),
//                                 ));
//                           },
//                           child: AppUtils.commonContainer(
//                               decoration: AppUtils.commonBoxDecoration(
//                                 borderRadius:
//                                     AppUtils.borderRadiusAll(raduis: 15),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(10),
//                                 child: IntrinsicHeight(
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Column(
//                                         children: [
//                                           AppUtils.commonContainer(
//                                               // child: AppUtils.imageWidget(
//                                               //     image: cartModelList[index]
//                                               //             .image ??
//                                               //         '',
//                                               //     ctx: context),
//                                               child: CachedNetworkImage(
//                                                 // height: 100,
//                                                 // width: 100,
//                                                 imageUrl: '',
//                                                 imageBuilder:
//                                                     (context, imageProvider) =>
//                                                         Container(
//                                                   decoration: BoxDecoration(
//                                                     image: DecorationImage(
//                                                         image: imageProvider,
//                                                         fit: BoxFit.cover),
//                                                   ),
//                                                 ),
//                                                 placeholder: (context, url) =>
//                                                     Center(
//                                                         child:
//                                                             CircularProgressIndicator(
//                                                   color: AppColors.colorPrimary,
//                                                   strokeWidth: 1.5,
//                                                 )),
//                                                 errorWidget: (context, url,
//                                                         error) =>
//                                                     Icon(Icons.image_rounded,
//                                                         size: 40,
//                                                         color: AppColors
//                                                             .colorPrimary),
//                                               ),
//                                               height: 80,
//                                               width: 70,
//                                               padding: AppUtils.edgeInsetsOnly(
//                                                   top: 10,
//                                                   right: 10,
//                                                   left: 10,
//                                                   bottom: 10),
//                                               decoration:
//                                                   AppUtils.commonBoxDecoration(
//                                                       boxShadow: [
//                                                     BoxShadow(
//                                                       color: AppColors
//                                                           .colorSecondary
//                                                           .withOpacity(0.1),
//                                                       spreadRadius: 1,
//                                                       blurRadius: 5,
//                                                       offset: Offset(0,
//                                                           4), // This is the bottom shadow offset
//                                                     ),
//                                                   ],
//                                                       color:
//                                                           AppColors.colorWhite,
//                                                       borderRadius: AppUtils
//                                                           .borderRadiusAll(
//                                                               raduis: 12))),
//                                         ],
//                                       ),
//                                       AppUtils.commonSizedBox(width: 15),
//                                       Expanded(
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.max,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             AppUtils.commonTextWidget(
//                                                 text: '',
//                                                 fontSize: 14,
//                                                 height: 1,
//                                                 letterSpacing: 0.5,
//                                                 textColor: AppColors.colorText,
//                                                 fontWeight: FontWeight.w700),
//                                             AppUtils.commonTextWidget(
//                                                 margin: AppUtils.edgeInsetsOnly(
//                                                     top: 5),
//                                                 text: '',
//                                                 fontSize: 12,
//                                                 letterSpacing: 0.5,
//                                                 height: 0,
//                                                 textColor:
//                                                     AppColors.colorPrimary,
//                                                 fontWeight: FontWeight.w700),
//                                             Row(
//                                               children: [
//                                                 AppUtils.commonTextWidget(
//                                                     text: "Size : ",
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.5,
//                                                     textColor:
//                                                         AppColors.colorText,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                                 AppUtils.commonTextWidget(
//                                                     text: '',
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.5,
//                                                     textColor: AppColors
//                                                         .colorSecondary,
//                                                     fontWeight:
//                                                         FontWeight.w700),
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 AppUtils.commonTextWidget(
//                                                     text: "Material : ",
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.5,
//                                                     textColor:
//                                                         AppColors.colorText,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                                 AppUtils.commonTextWidget(
//                                                     text: '',
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.5,
//                                                     textColor: AppColors
//                                                         .colorSecondary,
//                                                     fontWeight:
//                                                         FontWeight.w700),
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 AppUtils.commonTextWidget(
//                                                     text: "Price : ",
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.5,
//                                                     textColor:
//                                                         AppColors.colorText,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                                 AppUtils.commonTextWidget(
//                                                     text: '',
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.5,
//                                                     textColor: AppColors
//                                                         .colorSecondary,
//                                                     fontWeight:
//                                                         FontWeight.w700),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           AppUtils.commonContainer(
//                                             // height: 35,
//                                             // width: 100,
//                                             decoration:
//                                                 AppUtils.commonBoxDecoration(
//                                               // color: AppColors.colorPrimary,
//                                               borderRadius:
//                                                   AppUtils.borderRadiusAll(
//                                                       raduis: 10),
//                                             ),
//                                             child: Row(
//                                               children: [
//                                                 AppUtils.commonTextWidget(
//                                                     margin:
//                                                         AppUtils.edgeInsetsOnly(
//                                                             left: 10),
//                                                     text: "x ",
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.5,
//                                                     textColor:
//                                                         AppColors.colorPrimary,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                                 AppUtils.commonTextWidget(
//                                                     margin:
//                                                         AppUtils.edgeInsetsOnly(
//                                                             right: 10),
//                                                     text: '',
//                                                     fontSize: 18,
//                                                     letterSpacing: 0.5,
//                                                     textColor:
//                                                         AppColors.colorPrimary,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               AppUtils.commonSizedBox(height: 15),
//               AppUtils.commonTextWidget(
//                   text: "Order Details",
//                   letterSpacing: 1,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   textColor: AppColors.colorText),
//               AppUtils.commonSizedBox(height: 10),
//               AppUtils.commonDiver(color: AppColors.colorPrimary),
//               AppUtils.commonSizedBox(height: 10),
//               AppUtils.commonTextWidget(
//                   text: "Order Number",
//                   letterSpacing: 0.5,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   textColor: AppColors.colorPrimary),
//               AppUtils.commonTextWidget(
//                   text: "#${widget.salesOrderId}",
//                   letterSpacing: 0.5,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   textColor: AppColors.colorText),
//               AppUtils.commonSizedBox(height: 10),
//               AppUtils.commonTextWidget(
//                   text: "Order Date",
//                   letterSpacing: 0.5,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   textColor: AppColors.colorPrimary),
//               AppUtils.commonTextWidget(
//                   text: AppUtils.getDate(
//                       date: widget.orderDate ?? '', format: "dd-MM-yyyy"),
//                   letterSpacing: 0.5,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   textColor: AppColors.colorText),
//               AppUtils.commonSizedBox(height: 10),
//               AppUtils.commonTextWidget(
//                   text: "Order Status",
//                   letterSpacing: 0.5,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   textColor: AppColors.colorPrimary),
//               AppUtils.commonTextWidget(
//                   text: widget.orderStatus ?? '',
//                   letterSpacing: 0.5,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   textColor: AppUtils.getStatusColor(widget.orderStatus ?? '')),
//               AppUtils.commonSizedBox(height: 30),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: [
//               //     AppUtils.commonElevatedBtn(
//               //         height: 45,
//               //         text: "Support",
//               //         textColor: AppColors.colorWhite,
//               //         bgColor: AppColors.colorPrimary,
//               //         onPressed: () {},
//               //         topMargin: 0,
//               //         bottomMargin: 0,
//               //         rightMargin: 0,
//               //         leftMargin: 0),
//               //     AppUtils.commonElevatedBtn(
//               //         height: 45,
//               //         text: "Re-Order",
//               //         textColor: AppColors.colorWhite,
//               //         bgColor: AppColors.colorPrimary,
//               //         onPressed: () {},
//               //         topMargin: 0,
//               //         bottomMargin: 0,
//               //         rightMargin: 0,
//               //         leftMargin: 0),
//               //   ],
//               // ),
//               // AppUtils.commonSizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
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
//                   text: "Order Details",
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
