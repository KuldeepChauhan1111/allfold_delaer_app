// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
// import 'package:sales_app/models/common_model/common_response_model.dart';
// import 'package:sales_app/models/general_models/search_model.dart';
// import 'package:sales_app/features/product/presentation/pages/product_detail_screen.dart';
//
// class SearchListingScreen extends StatefulWidget {
//   final String? query;
//
//   const SearchListingScreen({super.key, this.query});
//
//   @override
//   State<SearchListingScreen> createState() => _SearchListingScreenState();
// }
//
// class _SearchListingScreenState extends State<SearchListingScreen> {
//   ValueNotifier<bool> _isVisible = ValueNotifier(true);
//   var _hideBottomNavController;
//   final ScrollController scrollController = ScrollController();
//
//   SearchModel? searchModel;
//   CommonResponseModel? commonResponseModel;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
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
//     return AppScaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(kToolbarHeight),
//           child: ValueListenableBuilder<bool>(
//               valueListenable: _isVisible,
//               builder: (context, value, child) {
//                 return AnimatedContainer(
//                   height: value ? 86 : 0.0,
//                   duration: Duration(milliseconds: 500),
//                   child: appBarRow(),
//                 );
//               }),
//         ),
//         body: SingleChildScrollView(
//           controller: _hideBottomNavController,
//           child: Column(
//             children: [
//               Padding(
//                 padding: AppUtils.edgeInsetsOnly(
//                     left: 20, right: 20, top: 20, bottom: 20),
//                 child: GridView.builder(
//                   padding: EdgeInsets.zero,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: 0,
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 15,
//                       mainAxisSpacing: 0,
//                       childAspectRatio: 0.68),
//                   itemBuilder: (context, index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         AppUtils.commonInkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         ProductDetailScreen(productId: 0,)));
//                           },
//                           child: AppUtils.commonContainer(
//                             constraints:
//                                 BoxConstraints(maxHeight: 180, minHeight: 150),
//                             decoration: AppUtils.commonBoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: AppColors.colorSecondary
//                                         .withOpacity(0.1),
//                                     spreadRadius: 1,
//                                     blurRadius: 5,
//                                     offset: Offset(0,
//                                         4), // This is the bottom shadow offset
//                                   ),
//                                 ],
//                                 borderRadius:
//                                     AppUtils.borderRadiusAll(raduis: 12),
//                                 color: AppColors.colorWhite),
//                             child: ClipRRect(
//                               borderRadius:
//                                   AppUtils.borderRadiusAll(raduis: 12),
//                               child: Stack(
//                                 children: [
//                                   CachedNetworkImage(
//                                     fit: BoxFit.fill,
//                                     // height: 65,
//                                     width: double.infinity,
//                                     imageUrl: '',
//                                     imageBuilder: (context, imageProvider) =>
//                                         Container(
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                             image: imageProvider,
//                                             fit: BoxFit.fill),
//                                       ),
//                                     ),
//                                     placeholder: (context, url) => Center(
//                                         child: CircularProgressIndicator(
//                                       color: AppColors.colorPrimary,
//                                       strokeWidth: 1.5,
//                                     )),
//                                     errorWidget: (context, url, error) =>
//                                         Center(
//                                       child: Icon(Icons.image_rounded,
//                                           size: 40,
//                                           color: AppColors.colorPrimary),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: AppUtils.edgeInsetsOnly(
//                                         right: 10, top: 10),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         AppUtils.commonInkWell(
//                                           onTap: () {},
//                                           child: Container(
//                                             padding: AppUtils.edgeInsetsAll(
//                                                 allPadding: 7),
//                                             decoration:
//                                                 AppUtils.commonBoxDecoration(
//                                                     border: Border.all(
//                                                         color: AppColors
//                                                             .colorSecondary,
//                                                         width: 0.2),
//                                                     color: AppColors.colorBg,
//                                                     borderRadius: AppUtils
//                                                         .borderRadiusAll(
//                                                             raduis: 12)),
//                                             child: false
//                                                 ? Icon(Icons.favorite,
//                                                     color:
//                                                         AppColors.colorPrimary,
//                                                     size: 20)
//                                                 : Icon(
//                                                     Icons
//                                                         .favorite_border_outlined,
//                                                     color: AppColors.colorText,
//                                                     size: 20),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         AppUtils.commonTextWidget(
//                             margin: AppUtils.edgeInsetsOnly(
//                                 right: 5, left: 5, top: 10),
//                             text: '',
//                             fontSize: 12,
//                             letterSpacing: 0.5,
//                             textColor: AppColors.colorText,
//                             fontWeight: FontWeight.w700),
//                         // Padding(
//                         //   padding: AppUtils.edgeInsetsOnly(
//                         //       right: 5, left: 5, top: 2),
//                         //   child: RatingBarIndicator(
//                         //       rating: 2.5,
//                         //       itemCount: 5,
//                         //       itemSize: 12,
//                         //       unratedColor: AppColors.colorLightGrey,
//                         //       itemBuilder: (context, _) => const Icon(
//                         //             Icons.star,
//                         //             color: AppColors.colorPrimary,
//                         //           )),
//                         // ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ));
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
//                   text: "Search Results",
//                   textColor: AppColors.colorPrimary,
//                   fontSize: 16,
//                   letterSpacing: 0.5,
//                   fontWeight: FontWeight.w700),
//             ],
//           ),
//           Row(
//             children: [
//               IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.search,
//                     color: AppColors.colorPrimary,
//                   )),
//               // IconButton(
//               //     onPressed: () {
//               //       Navigator.push(
//               //           context,
//               //           MaterialPageRoute(
//               //             builder: (context) => CartScreen(),
//               //           ));
//               //     },
//               //     icon: Icon(Icons.shopping_bag_outlined,
//               //         color: AppColors.colorPrimary)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
