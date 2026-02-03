// import 'dart:async';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
// import 'package:sales_app/core/widgets/custom_text_form_field.dart';
// import 'package:sales_app/models/admin_models/get_oder_details_by_id_model.dart';
// import 'package:sales_app/models/common_model/cart_modelAD.dart';
// import 'package:sales_app/models/common_model/common_response_model.dart';
//
// class OrderHistoryDetailScreenAD extends StatefulWidget {
//   bool? isPast;
//   int? salesOrderId;
//   int? orderId;
//   String? orderDate;
//   String? orderStatus;
//
//   OrderHistoryDetailScreenAD(
//       {Key? key,
//       this.isPast,
//       this.salesOrderId,
//       this.orderDate,
//       this.orderStatus,
//       this.orderId})
//       : super(key: key);
//
//   @override
//   State<OrderHistoryDetailScreenAD> createState() =>
//       _OrderHistoryDetailScreenADState();
// }
//
// class _OrderHistoryDetailScreenADState
//     extends State<OrderHistoryDetailScreenAD> {
//   CommonResponseModel? commonResponseModel;
//
//   String? dropDownValue;
//   String totalAmount = "";
//
//   CartModelAD cartModeList = CartModelAD();
//   Timer? timer;
//
//   GetOrderDetailsByIdModel? getOrderDetailsByIdModel;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: AppScaffold(
//         appBar: appBarRow(),
//         body: Stack(
//           children: [
//             Padding(
//               padding: AppUtils.edgeInsetsOnly(left: 20, right: 20, top: 20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     AppUtils.commonTextWidget(
//                         text: "Order Summary",
//                         letterSpacing: 1,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.colorText),
//                     AppUtils.commonSizedBox(height: 15),
//                     AppUtils.commonContainer(
//                       width: double.infinity,
//                       decoration: AppUtils.commonBoxDecoration(
//                         border: Border.all(color: AppColors.colorText),
//                         borderRadius: AppUtils.borderRadiusAll(raduis: 24),
//                       ),
//                       padding: AppUtils.edgeInsetsAll(allPadding: 8),
//                       child: ListView.builder(
//                         itemCount: getOrderDetailsByIdModel?.data?.length,
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         padding: EdgeInsets.zero,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               AppUtils.commonContainer(
//                                   decoration: AppUtils.commonBoxDecoration(
//                                     borderRadius:
//                                         AppUtils.borderRadiusAll(raduis: 15),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: IntrinsicHeight(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.stretch,
//                                         children: [
//                                           Column(
//                                             children: [
//                                               AppUtils.commonContainer(
//                                                   // child: AppUtils.imageWidget(
//                                                   //     image:
//                                                   //         getOrderDetailsByIdModel
//                                                   //                 ?.data?[index]
//                                                   //                 .imagePath ??
//                                                   //             '',
//                                                   //     ctx: context),
//                                                   child: CachedNetworkImage(
//                                                     height: 100,
//                                                     width: 100,
//                                                     imageUrl:
//                                                         getOrderDetailsByIdModel
//                                                                 ?.data?[index]
//                                                                 .imagePath ??
//                                                             '',
//                                                     imageBuilder: (context,
//                                                             imageProvider) =>
//                                                         Container(
//                                                       decoration: BoxDecoration(
//                                                         image: DecorationImage(
//                                                             image:
//                                                                 imageProvider,
//                                                             fit: BoxFit.cover),
//                                                       ),
//                                                     ),
//                                                     placeholder: (context,
//                                                             url) =>
//                                                         Center(
//                                                             child:
//                                                                 CircularProgressIndicator(
//                                                       color: AppColors
//                                                           .colorPrimary,
//                                                       strokeWidth: 1.5,
//                                                     )),
//                                                     errorWidget: (context, url,
//                                                             error) =>
//                                                         Icon(
//                                                             Icons.image_rounded,
//                                                             size: 40,
//                                                             color: AppColors
//                                                                 .colorPrimary),
//                                                   ),
//                                                   height: 80,
//                                                   width: 70,
//                                                   padding:
//                                                       AppUtils.edgeInsetsOnly(
//                                                           top: 10,
//                                                           right: 10,
//                                                           left: 10,
//                                                           bottom: 10),
//                                                   decoration: AppUtils
//                                                       .commonBoxDecoration(
//                                                           boxShadow: [
//                                                         BoxShadow(
//                                                           color: AppColors
//                                                               .colorSecondary
//                                                               .withOpacity(0.1),
//                                                           spreadRadius: 1,
//                                                           blurRadius: 5,
//                                                           offset: Offset(0,
//                                                               4), // This is the bottom shadow offset
//                                                         ),
//                                                       ],
//                                                           color: AppColors
//                                                               .colorWhite,
//                                                           borderRadius: AppUtils
//                                                               .borderRadiusAll(
//                                                                   raduis: 12))),
//                                             ],
//                                           ),
//                                           AppUtils.commonSizedBox(width: 15),
//                                           Expanded(
//                                             child: Column(
//                                               mainAxisSize: MainAxisSize.max,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 AppUtils.commonTextWidget(
//                                                     text:
//                                                         getOrderDetailsByIdModel
//                                                                 ?.data?[index]
//                                                                 .productName ??
//                                                             '',
//                                                     fontSize: 14,
//                                                     height: 1,
//                                                     letterSpacing: 0.5,
//                                                     textColor:
//                                                         AppColors.colorText,
//                                                     fontWeight:
//                                                         FontWeight.w700),
//                                                 AppUtils.commonTextWidget(
//                                                     margin:
//                                                         AppUtils.edgeInsetsOnly(
//                                                             top: 5),
//                                                     text:
//                                                         getOrderDetailsByIdModel
//                                                                 ?.data?[index]
//                                                                 .categoryName ??
//                                                             '',
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.5,
//                                                     height: 0,
//                                                     textColor:
//                                                         AppColors.colorPrimary,
//                                                     fontWeight:
//                                                         FontWeight.w700),
//                                                 Row(
//                                                   children: [
//                                                     AppUtils.commonTextWidget(
//                                                         text: "Size : ",
//                                                         fontSize: 12,
//                                                         letterSpacing: 0.5,
//                                                         textColor:
//                                                             AppColors.colorText,
//                                                         fontWeight:
//                                                             FontWeight.w500),
//                                                     Flexible(
//                                                       child: AppUtils.commonTextWidget(
//                                                           text:
//                                                               getOrderDetailsByIdModel
//                                                                       ?.data?[
//                                                                           index]
//                                                                       .size ??
//                                                                   '',
//                                                           fontSize: 12,
//                                                           letterSpacing: 0.5,
//                                                           textColor: AppColors
//                                                               .colorSecondary,
//                                                           fontWeight:
//                                                               FontWeight.w700),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 // Row(
//                                                 //   children: [
//                                                 //     AppUtils.commonTextWidget(
//                                                 //         text: "Color : ",
//                                                 //         fontSize: 12,
//                                                 //         letterSpacing: 0.5,
//                                                 //         textColor:
//                                                 //             AppColors.colorText,
//                                                 //         fontWeight:
//                                                 //             FontWeight.w500),
//                                                 //     AppUtils.commonTextWidget(
//                                                 //         text: "Black",
//                                                 //         fontSize: 12,
//                                                 //         letterSpacing: 0.5,
//                                                 //         textColor: AppColors
//                                                 //             .colorSecondary,
//                                                 //         fontWeight:
//                                                 //             FontWeight.w700),
//                                                 //   ],
//                                                 // ),
//                                                 Row(
//                                                   children: [
//                                                     AppUtils.commonTextWidget(
//                                                         text: "Material : ",
//                                                         fontSize: 12,
//                                                         letterSpacing: 0.5,
//                                                         textColor:
//                                                             AppColors.colorText,
//                                                         fontWeight:
//                                                             FontWeight.w500),
//                                                     Flexible(
//                                                       child: AppUtils.commonTextWidget(
//                                                           text: getOrderDetailsByIdModel
//                                                                   ?.data?[index]
//                                                                   .materialName ??
//                                                               '',
//                                                           fontSize: 12,
//                                                           letterSpacing: 0.5,
//                                                           textColor: AppColors
//                                                               .colorSecondary,
//                                                           fontWeight:
//                                                               FontWeight.w700),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     AppUtils.commonTextWidget(
//                                                         text: "Price : ",
//                                                         fontSize: 12,
//                                                         letterSpacing: 0.5,
//                                                         textColor:
//                                                             AppColors.colorText,
//                                                         fontWeight:
//                                                             FontWeight.w500),
//                                                     AppUtils.commonTextWidget(
//                                                         text: getOrderDetailsByIdModel
//                                                                 ?.data?[index]
//                                                                 .price
//                                                                 .toString() ??
//                                                             '',
//                                                         fontSize: 12,
//                                                         letterSpacing: 0.5,
//                                                         textColor: AppColors
//                                                             .colorSecondary,
//                                                         fontWeight:
//                                                             FontWeight.w700),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           AppUtils.commonSizedBox(width: 5),
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               AppUtils.commonContainer(
//                                                 // height: 35,
//                                                 // width: 100,
//                                                 decoration: AppUtils
//                                                     .commonBoxDecoration(
//                                                   // color: AppColors.colorPrimary,
//                                                   borderRadius:
//                                                       AppUtils.borderRadiusAll(
//                                                           raduis: 10),
//                                                 ),
//                                                 child: Row(
//                                                   children: [
//                                                     widget.isPast ?? false
//                                                         ? AppUtils.commonTextWidget(
//                                                             margin: AppUtils
//                                                                 .edgeInsetsOnly(
//                                                                     right: 10),
//                                                             text: "X",
//                                                             fontSize: 18,
//                                                             letterSpacing: 0.5,
//                                                             textColor: AppColors
//                                                                 .colorPrimary,
//                                                             fontWeight:
//                                                                 FontWeight.bold)
//                                                         : Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .center,
//                                                             children: [
//                                                               AppUtils
//                                                                   .commonContainer(
//                                                                       // height: 35,
//                                                                       // width: 100,
//                                                                       decoration:
//                                                                           AppUtils
//                                                                               .commonBoxDecoration(
//                                                                         // color: AppColors.colorPrimary,
//                                                                         borderRadius:
//                                                                             AppUtils.borderRadiusAll(raduis: 10),
//                                                                       ),
//                                                                       child:
//                                                                           Row(
//                                                                         crossAxisAlignment:
//                                                                             CrossAxisAlignment.center,
//                                                                         children: [
//                                                                           GestureDetector(
//                                                                             onLongPress: () =>
//                                                                                 setState(() {}),
//                                                                             onLongPressEnd: (_) =>
//                                                                                 setState(() {
//                                                                               timer?.cancel();
//                                                                             }),
//                                                                             onTap:
//                                                                                 () {},
//                                                                             child: AppUtils.commonContainer(
//                                                                                 padding: EdgeInsets.all(6),
//                                                                                 decoration: AppUtils.commonBoxDecoration(border: Border.all(color: AppColors.colorSecondary), borderRadius: AppUtils.borderRadiusAll(raduis: 5), color: AppColors.colorTransparent),
//                                                                                 child: Center(
//                                                                                   child: Icon(
//                                                                                     Icons.remove,
//                                                                                     size: 14,
//                                                                                     color: AppColors.colorSecondary,
//                                                                                   ),
//                                                                                 )),
//                                                                           ),
//                                                                           GestureDetector(
//                                                                             onTap:
//                                                                                 () {
//                                                                               openEditDialog(context, index);
//                                                                             },
//                                                                             child: AppUtils.commonTextWidget(
//                                                                                 margin: AppUtils.edgeInsetsOnly(left: 10, right: 10),
//                                                                                 text: '',
//                                                                                 fontSize: 14,
//                                                                                 letterSpacing: 0.5,
//                                                                                 textColor: AppColors.colorPrimary,
//                                                                                 fontWeight: FontWeight.w500),
//                                                                           ),
//                                                                           GestureDetector(
//                                                                             onLongPress: () =>
//                                                                                 setState(() {}),
//                                                                             onLongPressEnd: (_) =>
//                                                                                 setState(() {
//                                                                               timer?.cancel();
//                                                                             }),
//                                                                             onTap:
//                                                                                 () {},
//                                                                             child: Container(
//                                                                                 padding: EdgeInsets.all(6),
//                                                                                 decoration: AppUtils.commonBoxDecoration(border: Border.all(color: AppColors.colorSecondary), borderRadius: AppUtils.borderRadiusAll(raduis: 5), color: AppColors.colorTransparent),
//                                                                                 child: Center(
//                                                                                   child: Icon(
//                                                                                     Icons.add,
//                                                                                     size: 14,
//                                                                                     color: AppColors.colorSecondary,
//                                                                                   ),
//                                                                                 )),
//                                                                           ),
//                                                                         ],
//                                                                       )),
//                                                             ],
//                                                           )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                     AppUtils.commonSizedBox(height: 15),
//                     AppUtils.commonTextWidget(
//                         text: "Order Details",
//                         letterSpacing: 1,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.colorText),
//                     AppUtils.commonSizedBox(height: 10),
//                     AppUtils.commonDiver(color: AppColors.colorPrimary),
//                     AppUtils.commonSizedBox(height: 10),
//                     AppUtils.commonTextWidget(
//                         text: "Total Amount",
//                         letterSpacing: 0.5,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.colorPrimary),
//                     AppUtils.commonTextWidget(
//                         text: totalAmount,
//                         letterSpacing: 0.5,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.colorText),
//                     AppUtils.commonSizedBox(height: 10),
//                     AppUtils.commonTextWidget(
//                         text: "Order Number",
//                         letterSpacing: 0.5,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.colorPrimary),
//                     AppUtils.commonTextWidget(
//                         text: widget.orderId.toString() ?? '',
//                         letterSpacing: 0.5,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.colorText),
//                     AppUtils.commonSizedBox(height: 10),
//                     AppUtils.commonTextWidget(
//                         text: "Order Date",
//                         letterSpacing: 0.5,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.colorPrimary),
//                     AppUtils.commonTextWidget(
//                         text: AppUtils.getDate(
//                             date: widget.orderDate ?? '', format: "dd-MM-yyyy"),
//                         letterSpacing: 0.5,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.colorText),
//                     AppUtils.commonSizedBox(height: 10),
//                     AppUtils.commonTextWidget(
//                         text: "Order Status",
//                         letterSpacing: 0.5,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.colorPrimary),
//                     AppUtils.commonTextWidget(
//                         text: widget.orderStatus ?? '',
//                         letterSpacing: 0.5,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         textColor:
//                             AppUtils.getStatusColor(widget.orderStatus ?? '')),
//                     AppUtils.commonSizedBox(
//                         height: widget.isPast ?? false ? 0 : 30),
//                     // height: widget.isPast ?? false ? 30 : 0),
//                     Visibility(
//                       visible: !(widget.isPast ?? false),
//                       // visible: true,
//                       child: AppUtils.commonElevatedBtn(
//                           padding: AppUtils.edgeInsetsOnly(top: 20, bottom: 20),
//                           borderRadiusAll: 20,
//                           // width: double.infinity,
//                           // height: 60,
//                           width: double.infinity,
//                           text: "Add to Cart   >>>",
//                           fontSize: 12,
//                           bgColor: AppColors.colorPrimary,
//                           textColor: AppColors.colorWhite,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 0.5,
//                           onPressed: () {},
//                           leftMargin: 0,
//                           rightMargin: 0,
//                           topMargin: 0,
//                           bottomMargin: 0),
//                     ),
//                     AppUtils.commonSizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ),
//           ],
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
//         ],
//       ),
//     );
//   }
//
//   openEditDialog(BuildContext ctx, int indx) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         String? otherValue;
//         return AlertDialog(
//           contentPadding: AppUtils.edgeInsetsAll(allPadding: 8),
//           backgroundColor: AppColors.colorBg,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AppUtils.commonTextWidget(
//                   text: "Edit Quantity",
//                   textColor: AppColors.colorSecondary,
//                   letterSpacing: 1),
//             ],
//           ),
//           content: Container(
//               margin: AppUtils.edgeInsetsOnly(top: 20),
//               // height: 100,
//               width: double.infinity,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AppUtils.commonSizedBox(
//                       // width: 70,
//                       child: CustomTextFormField(
//                     maxLines: 1,
//                     hintText: "Qty",
//                     inputType: TextInputType.number,
//                     hintColor: AppColors.colorText,
//                     controller: TextEditingController(
//                         text: getOrderDetailsByIdModel?.data?[indx].quantity
//                             .toString()),
//                     onChanged: (value) {
//                       setState(() {
//                         otherValue = value;
//                       });
//                     },
//                   )),
//                   AppUtils.commonSizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                           onPressed: () {
//                             setState(() {});
//                             Navigator.pop(context);
//                           },
//                           child: AppUtils.commonTextWidget(
//                               text: "Submit",
//                               letterSpacing: 1,
//                               textColor: AppColors.colorPrimary,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16)),
//                     ],
//                   )
//                 ],
//               )),
//         );
//       },
//     );
//   }
// }
