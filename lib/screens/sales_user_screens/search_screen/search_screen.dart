// import 'package:flutter/material.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
//
// typedef OnSearchChanged = Future<List<String>> Function(String);
//
// class SearchScreen extends SearchDelegate<String> {
//   ///[onSearchChanged] gets the [query] as an argument. Then this callback
//   ///should process [query] then return an [List<String>] as suggestions.
//   ///Since its returns a [Future] you get suggestions from server too.
//   final OnSearchChanged onSearchChanged;
//
//   ///This [_oldFilters] used to store the previous suggestions. While waiting
//   ///for [onSearchChanged] to completed, [_oldFilters] are displayed.
//   List<String> _oldFilters = const [];
//
//   SearchScreen(
//       {required String searchFieldLabel, required this.onSearchChanged})
//       : super(searchFieldLabel: searchFieldLabel);
//
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         padding: AppUtils.edgeInsetsOnly(right: 10),
//         icon: const Icon(Icons.clear, size: 22),
//         onPressed: () => query = "",
//       ),
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return Padding(
//       padding: AppUtils.edgeInsetsOnly(left: 10),
//       child: AppUtils.commonInkWell(
//         borderRadius: BorderRadius.circular(20),
//         onTap: () {
//           Navigator.pop(context);
//           },
//         child: AppUtils.commonContainer(
//             padding: AppUtils.edgeInsetsOnly(
//                 top: 15, bottom: 15, left: 12, right: 12),
//             decoration: AppUtils.commonBoxDecoration(
//                 borderRadius: AppUtils.borderRadiusAll(raduis: 18),
//                 border: Border.all(color: AppColors.colorPrimary)),
//             child: const Center(
//               child: Icon(
//                 Icons.arrow_back_ios_new_rounded,
//                 size: 16,
//                 color: AppColors.colorSecondary,
//               ),
//             )),
//       ),
//     );
//   }
//
//   @override
//   void showResults(BuildContext context) {
//     close(context, query);
//   }
//
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     return ThemeData(
//       canvasColor: AppColors.colorBg,
//       textSelectionTheme:
//           const TextSelectionThemeData(cursorColor: AppColors.colorPrimary),
//       hintColor: AppColors.colorText,
//       textTheme: const TextTheme(
//         titleLarge: TextStyle(
//           color: AppColors.colorSecondary, // <-- TextFormField input color
//         ),
//       ),
//       inputDecorationTheme: const InputDecorationTheme(
//         enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: AppColors.colorTransparent)),
//         focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: AppColors.colorTransparent)),
//       ),
//       appBarTheme: const AppBarTheme(
//           toolbarHeight: 50,
//           shadowColor: AppColors.colorTransparent,
//           actionsIconTheme: IconThemeData(color: AppColors.colorSecondary),
//           color: AppColors.colorBg),
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder<List<String>>(
//       future: onSearchChanged(query),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) _oldFilters = snapshot.data ?? [];
//         return ListView.builder(
//           itemCount: _oldFilters.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: const Icon(
//                 Icons.restore,
//                 color: AppColors.colorText,
//               ),
//               title: AppUtils.commonTextWidget(
//                 textColor: AppColors.colorSecondary,
//                   text: _oldFilters[index], letterSpacing: 1),
//               onTap: () => close(context, _oldFilters[index]),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }
// }
//
// //   @override
// //   State<SearchScreen> createState() => _SearchScreenState();
// // }
//
// // class _SearchScreenState extends State<SearchScreen> {
// //   // String? searchFieldValue;
// //   // TextEditingController searchController = TextEditingController();
// //
// //
// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return GestureDetector(
// //   //     onTap: () {
// //   //       FocusScope.of(context).unfocus();
// //   //     },
// //   //     child: AppScaffold(
// //   //         body: Column(
// //   //       children: [
// //   //         Padding(
// //   //           padding: AppUtils.edgeInsetsOnly(left: 10, right: 10, top: 30),
// //   //           child: Row(
// //   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   //             children: [
// //   //               AppUtils.commonInkWell(
// //   //                 borderRadius: BorderRadius.circular(20),
// //   //                 onTap: () {
// //   //                   Navigator.pop(context);
// //   //                 },
// //   //                 child: AppUtils.commonContainer(
// //   //                     margin: AppUtils.edgeInsetsOnly(
// //   //                         left: 5, top: 5, bottom: 5, right: 5),
// //   //                     padding: AppUtils.edgeInsetsOnly(
// //   //                         top: 15, bottom: 15, left: 12, right: 12),
// //   //                     decoration: AppUtils.commonBoxDecoration(
// //   //                         borderRadius: AppUtils.borderRadiusAll(raduis: 18),
// //   //                         border: Border.all(color: AppColors.colorPrimary)),
// //   //                     child: const Center(
// //   //                       child: Icon(
// //   //                         Icons.arrow_back_ios_new_rounded,
// //   //                         size: 18,
// //   //                         color: AppColors.colorWhite,
// //   //                       ),
// //   //                     )),
// //   //               ),
// //   //               Expanded(
// //   //                   child: CommonTextField(
// //   //                 hintText: "Search",
// //   //                 hintTextColor: AppColors.colorWhite,
// //   //                 inputTextColor: AppColors.colorWhite,
// //   //                 enabledBorderColor: AppColors.colorTransparent,
// //   //                 controller: searchController,
// //   //                 focusedBorderColor: AppColors.colorTransparent,
// //   //                 onChanged: (String value) {
// //   //                   setState(() {
// //   //                     searchFieldValue = value;
// //   //                   });
// //   //                 },
// //   //               )),
// //   //               searchFieldValue == null || searchFieldValue == ""
// //   //                   ? AppUtils.commonSizedBox()
// //   //                   : IconButton(
// //   //                       onPressed: () {
// //   //                         setState(() {
// //   //                           searchController.clear();
// //   //                           searchFieldValue = null;
// //   //                         });
// //   //                       },
// //   //                       icon: const Icon(
// //   //                         Icons.highlight_remove_rounded,
// //   //                         color: AppColors.colorLightGrey,
// //   //                       ))
// //   //             ],
// //   //           ),
// //   //         ),
// //   //         Expanded(
// //   //           child: AppUtils.commonContainer(
// //   //             color: Colors.yellowAccent,
// //   //             margin: AppUtils.edgeInsetsOnly(top: 10,left: 20,right: 20),
// //   //             child: GridView.builder(
// //   //               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
// //   //                 maxCrossAxisExtent: 2, // Set this to null for undefined width items
// //   //                 crossAxisSpacing: 10.0,
// //   //                 mainAxisSpacing: 10.0,
// //   //               ),
// //   //               itemBuilder: (BuildContext context, int index) {
// //   //                 // Replace this with your widget that has undefined width
// //   //                 return Container(
// //   //                   color: Colors.blue,
// //   //                   child: Center(
// //   //                     child: Text('Item $index'),
// //   //                   ),
// //   //                 );
// //   //               },
// //   //             ),
// //   //           ),
// //   //         ),
// //   //       ],
// //   //     )),
// //   //   );
// //   // }
// // }
