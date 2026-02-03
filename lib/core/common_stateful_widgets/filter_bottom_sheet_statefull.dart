import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/models/filterModel.dart';

class FilterBottomSheetStateful extends StatefulWidget {
  const FilterBottomSheetStateful({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheetStateful> createState() =>
      _FilterBottomSheetStatefulState();
}

class _FilterBottomSheetStatefulState extends State<FilterBottomSheetStateful> {

  List<FilterModel>? listFilterModel;

  @override
  void initState() {
    super.initState();

    listFilterModel?.add(FilterModel("Color", [FilterValueData(false, "Black"),FilterValueData(false, "White"),FilterValueData(false, "Red")]));
    listFilterModel?.add(FilterModel("Size", [FilterValueData(false, "S"),FilterValueData(false, "M"),FilterValueData(false, "L")]));
    listFilterModel?.add(FilterModel("Material", [FilterValueData(false, "Bronze"),FilterValueData(false, "Titanium"),FilterValueData(false, "Stainless Steal")]));

  }

  @override
  Widget build(BuildContext context) {
    return AppUtils.commonContainer(
      decoration: AppUtils.commonBoxDecoration(
          color: AppColors.colorDarkGrey,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppUtils.commonSizedBox(height: 20),
          Padding(
            padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppUtils.commonTextWidget(
                    text: 'FILTER BY',
                    letterSpacing: 1,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    textColor: AppColors.colorPrimary,
                    fontFamily: AppConstants.fontFamilyPoppins),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: AppUtils.commonTextWidget(
                        text: 'Clear all',
                        letterSpacing: 0.5,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        textColor: AppColors.colorLightGrey,
                        fontFamily: AppConstants.fontFamilyPoppins))
              ],
            ),
          ),
          AppUtils.commonSizedBox(height: 10),
          AppUtils.commonDiver(),
          Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    ListView.builder(
                      itemCount: listFilterModel?.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                      return Column(
                       children: [
                         AppUtils.commonTextWidget(
                             text: 'FILTER BY',
                             letterSpacing: 1,
                             fontSize: 14,
                             fontWeight: FontWeight.w900,
                             textColor: AppColors.colorPrimary,
                             fontFamily: AppConstants.fontFamilyPoppins),
                         AppUtils.commonDiver(),
                       ],
                      );
                    },),
                  ],
                ),
              ],
            ),
          ),
          AppUtils.commonSizedBox(height: 20),
        ],
      ),
    );
  }
}
