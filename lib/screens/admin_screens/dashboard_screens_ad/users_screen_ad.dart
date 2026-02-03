// import 'dart:async';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
// import 'package:sales_app/models/admin_models/get_sales_man_list_model.dart';
// import 'package:sales_app/models/common_model/common_response_model.dart';
// import 'package:sales_app/screens/admin_screens/user_screens_ad/add_user_screen_ad.dart';
//
// class UsersScreenAD extends StatefulWidget {
//   const UsersScreenAD({Key? key}) : super(key: key);
//
//   @override
//   State<UsersScreenAD> createState() => _UsersScreenADState();
// }
//
// class _UsersScreenADState extends State<UsersScreenAD> {
//   GetSalesManListModel? getSalesManListModel;
//   CommonResponseModel? commonResponseModel;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Widget floatingActionButton() {
//     return AppUtils.commonInkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddUserScreenAD(),
//             )).then((value) {});
//       },
//       borderRadius: BorderRadius.circular(12),
//       child: AppUtils.commonContainer(
//         padding: AppUtils.edgeInsetsAll(allPadding: 8),
//         decoration: AppUtils.commonBoxDecoration(
//           color: AppColors.colorPrimary,
//           borderRadius: AppUtils.borderRadiusAll(raduis: 12),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.add, color: AppColors.colorWhite),
//             AppUtils.commonSizedBox(width: 5),
//             AppUtils.commonTextWidget(
//                 text: "Add User",
//                 textColor: AppColors.colorWhite,
//                 fontWeight: FontWeight.bold),
//             AppUtils.commonSizedBox(width: 5),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: AppColors.colorTransparent,
//           // floatingActionButton: floatingActionButton(postMdl),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 ListView.builder(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: AppUtils.edgeInsetsOnly(left: 10, right: 10),
//                       child: Column(
//                         children: [
//                           AppUtils.commonSizedBox(height: 10),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => AddUserScreenAD(
//                                         isEdit: true, userId: 0),
//                                   )).then((value) {});
//                             },
//                             child: Slidable(
//                               key: UniqueKey(),
//                               endActionPane: ActionPane(
//                                 extentRatio: 0.20,
//                                 dragDismissible: false,
//                                 // openThreshold: 0.1,
//                                 // closeThreshold: 0.1,
//                                 motion: ScrollMotion(),
//                                 dismissible: DismissiblePane(
//                                     dismissalDuration:
//                                         Duration(milliseconds: 1000),
//                                     dismissThreshold: 0.1,
//                                     // confirmDismiss: () async {
//                                     //   print("innnnnn");
//                                     //   setState(() {
//                                     //     postMdl.getSalesManListModel?.data?.removeAt(index);
//                                     //   });
//                                     //   return true;
//                                     // },
//                                     onDismissed: () {}),
//                                 children: [
//                                   SlidableAction(
//                                     // An action can be bigger than the others.
//                                     // flex: 2,
//                                     onPressed: (context) {
//                                       AppUtils.showCustomTwoBtnDialog(
//                                         ctx: context,
//                                         dialogBtnTextRight: "Yes",
//                                         dialogBtnTextLeft: "No",
//                                         dialogMessage:
//                                             "Are you sure you want to delete the user?",
//                                         dialogTitle: "Alert",
//                                         dialogBtnRightFnc: () {},
//                                       );
//                                       // setState(() {
//                                       //   postMdl.getSalesManListModel?.data?.removeAt(index);
//                                       // });
//                                     },
//                                     borderRadius: BorderRadius.circular(12),
//                                     backgroundColor: Colors.red,
//                                     foregroundColor: AppColors.colorWhite,
//                                     icon: Icons.delete_outline,
//                                     // label: 'Delete',
//                                   ),
//                                 ],
//                               ),
//                               child: AppUtils.commonContainer(
//                                 width: double.infinity,
//                                 decoration: AppUtils.commonBoxDecoration(
//                                   color: AppColors.colorWhite,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: AppColors.colorSecondary
//                                           .withOpacity(0.1),
//                                       spreadRadius: 1,
//                                       blurRadius: 5,
//                                       offset: Offset(0, 4),
//                                     ),
//                                   ],
//                                   borderRadius:
//                                       AppUtils.borderRadiusAll(raduis: 12),
//                                 ),
//                                 child: Padding(
//                                   padding:
//                                       AppUtils.edgeInsetsAll(allPadding: 8),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         padding: AppUtils.edgeInsetsAll(
//                                             allPadding: 2),
//                                         decoration:
//                                             AppUtils.commonBoxDecoration(
//                                                 border: Border.all(
//                                                     color:
//                                                         AppColors.colorPrimary,
//                                                     width: 1.5),
//                                                 shape: BoxShape.circle),
//                                         child: ClipOval(
//                                           child: CachedNetworkImage(
//                                             height: 70,
//                                             width: 70,
//                                             imageUrl: '',
//                                             imageBuilder:
//                                                 (context, imageProvider) =>
//                                                     Container(
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                     image: imageProvider,
//                                                     fit: BoxFit.cover),
//                                               ),
//                                             ),
//                                             placeholder: (context, url) =>
//                                                 const Center(
//                                                     child:
//                                                         CircularProgressIndicator(
//                                               color: AppColors.colorPrimary,
//                                               strokeWidth: 1.5,
//                                             )),
//                                             errorWidget: (context, url,
//                                                     error) =>
//                                                 const Icon(Icons.person,
//                                                     size: 40,
//                                                     color:
//                                                         AppColors.colorPrimary),
//                                           ),
//                                         ),
//                                       ),
//                                       AppUtils.commonSizedBox(width: 10),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           AppUtils.commonTextWidget(
//                                               text: '',
//                                               letterSpacing: 0.5,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               textColor:
//                                                   AppColors.colorPrimary),
//                                           AppUtils.commonSizedBox(height: 5),
//                                           AppUtils.commonTextWidget(
//                                               text: '',
//                                               letterSpacing: 0.5,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold,
//                                               textColor: AppColors.colorText),
//                                           AppUtils.commonSizedBox(height: 5),
//                                           AppUtils.commonTextWidget(
//                                               text: '',
//                                               letterSpacing: 0.5,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.bold,
//                                               textColor: AppColors.colorText),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           AppUtils.commonSizedBox(height: 10),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//                 AppUtils.commonSizedBox(height: 80),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
// }
