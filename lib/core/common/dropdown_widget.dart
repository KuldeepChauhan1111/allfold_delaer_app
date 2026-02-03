//
// import 'package:flutter/material.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
//
//
// class DropdownWidget extends StatefulWidget {
//   final Function(String? selectedValue) onItemSelected;
//   String? defaultValue;
//   String? hint;
//   String? otherValue;
//   List<String> values;
//   bool? isBoxShadow;
//   double? top;
//   double? height;
//   double? selectedValFontSize;
//   double? leftValidationPadding;
//   double? dropDownListFirstElementFontSize;
//   double? dropDownListFontSize;
//   double? selectedItemFontSize;
//   bool isError;
//   String? errorMessage;
//   EdgeInsetsGeometry? dropdownPadding;
//
//   DropdownWidget({
//     Key? key,
//     required this.defaultValue,
//     required this.values,
//     this.hint,
//     this.otherValue,
//     required this.onItemSelected,
//     this.isBoxShadow,
//     this.height,
//     this.dropDownListFirstElementFontSize,
//     this.dropDownListFontSize,
//     this.leftValidationPadding,
//     this.top,
//     this.selectedItemFontSize,
//     this.selectedValFontSize,
//     this.dropdownPadding,
//     this.isError = false,
//     this.errorMessage = "",
//   }) : super(key: key);
//
//   @override
//   DropdownWidgetState createState() => DropdownWidgetState();
// }
//
// class DropdownWidgetState extends State<DropdownWidget> {
//   String? dropdownValue;
//   Alignment alignment = Alignment.center;
//   Color colorText = AppColors.colorText;
//   bool isClick = false;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.defaultValue != null) {
//       if (widget.values.contains(widget.defaultValue)) {
//         dropdownValue = widget.defaultValue;
//       } else {
//         dropdownValue = 'Other';
//         widget.otherValue = widget.defaultValue;
//       }
//     } else {
//       dropdownValue = widget.defaultValue;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: AppUtils.edgeInsetsOnly(
//             top: widget.top,
//           ),
//           height: widget.height,
//           decoration: widget.isBoxShadow ?? false
//               ? AppUtils.commonBoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             border: Border.all(color: AppColors.colorSecondary),
//           )
//               : const BoxDecoration(),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton2(
//               // dropdownPadding: widget.dropdownPadding,
//               // dropdownMaxHeight: 230,
//               barrierColor: AppColors.colorSecondary,
//               isDense: false,
//               // dropdownOverButton: true,
//               isExpanded: false,
//               // itemHeight: 35,
//               // dropdownFullScreen: false,
//               // buttonHeight: 50,
//               hint: AppUtils.commonTextWidget(
//                 letterSpacing: 0,
//                 margin: AppUtils.edgeInsetsOnly(
//                   left: 5,
//                 ),
//                 text: widget.hint ?? "",
//                 fontSize: widget.selectedValFontSize ?? 14,
//                 textColor: AppColors.colorText,
//               ),
//               value: dropdownValue,
//               items: _addDividersAfterItems(
//                   widget.values,
//                   dropdownValue ?? widget.defaultValue ?? '',
//                   widget.hint ?? "",
//                   widget.otherValue ?? "",
//                   widget.dropDownListFirstElementFontSize,
//                   widget.dropDownListFontSize),
//               selectedItemBuilder: (context) {
//                 return widget.values
//                     .map(
//                       (diagnosisName) => Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       AppUtils.commonTextWidget(
//                         margin: AppUtils.edgeInsetsOnly(
//                           left: 5,
//                         ),
//                         text: diagnosisName == "Other"
//                             ? widget.otherValue ?? ""
//                             : diagnosisName,
//                         textColor: widget.hint == widget.otherValue
//                             ? AppColors.colorSecondary
//                             : AppColors.colorText,
//                         letterSpacing: 0,
//                         fontSize: widget.selectedItemFontSize ?? 14,
//                       ),
//                     ],
//                   ),
//                 )
//                     .toList();
//               },
//               onChanged: (newDropdownValue) {
//                 setState(() {
//                   alignment = Alignment.center;
//                   dropdownValue = newDropdownValue?.toString();
//                   widget.onItemSelected(dropdownValue);
//                 });
//               },
//               // icon: Icon(Icons.arrow_drop_down_outlined),
//               // iconSize: 18,
//               // buttonWidth: MediaQuery.of(context).size.width,
//               // buttonPadding: AppUtils.edgeInsetsOnly(
//               //   left: 14,
//               //   right: 14,
//               // ),
//               // dropdownDecoration: AppUtils.commonBoxDecoration(
//               //   borderRadius: BorderRadius.circular(24),
//               // ),
//               // buttonDecoration: AppUtils.commonBoxDecoration(
//               //   borderRadius: BorderRadius.circular(24),
//               // ),
//               // offset: Offset(
//               //   0,
//               //   -5,
//               // ),
//             ),
//           ),
//         ),
//         widget.isError
//             ? AppUtils.commonTextWidget(
//           margin: AppUtils.edgeInsetsOnly(left: 25),
//           text: widget.errorMessage ?? '',
//           textColor: Colors.redAccent,
//           fontSize: 13,
//           textAlign: TextAlign.left,
//         )
//             : const SizedBox(),
//       ],
//     );
//   }
// }
//
// List<DropdownMenuItem<String>> _addDividersAfterItems(
//     List<String> items,
//     String dropDownValue,
//     String hint,
//     String otherValue,
//     double? dropDownListFirstElementFontSize,
//     double? dropDownListFontSize) {
//   List<DropdownMenuItem<String>> _menuItems = [];
//   for (var item in items) {
//     _menuItems.add(
//       DropdownMenuItem<String>(
//         value: item,
//         enabled: item == items.first ? false : true,
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 alignment: Alignment.center,
//                 child: Container(
//                   margin: AppUtils.edgeInsetsOnly(
//                     left: 10,
//                     right: 10,
//                   ),
//                   alignment: Alignment.center,
//                   child: item == items.first
//                       ? AppUtils.commonTextWidget(
//                     text: item,
//                     fontSize: dropDownListFirstElementFontSize ??
//                         14,
//                   )
//                       : AppUtils.commonTextWidget(
//                     text: item,
//                     fontSize: 14,
//                     textColor: item == otherValue
//                         ? AppColors.colorPrimary
//                         : dropDownValue == item &&
//                         hint != otherValue &&
//                         item != 'Other'
//                         ? AppColors.colorPrimary
//                         : item == 'Other' &&
//                         dropDownValue == 'Other' &&
//                         hint != otherValue &&
//                         !items.contains(otherValue)
//                         ? AppColors.colorPrimary
//                         : AppColors.colorSecondary,
//                   ),
//                 ),
//               ),
//             ),
//             item == items.last
//                 ? Container()
//                 : AppUtils.commonDiver(
//               // height: AppConstants.height1,
//               // dividerColor: AppColors.colorDividerGray,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   return _menuItems;
// }
