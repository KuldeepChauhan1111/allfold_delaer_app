import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/utils/app_utils.dart';

class SortBottomSheetStateful extends StatefulWidget {
  final Function selectedSort;
  final SortEnums? selectedSortValue;

  const SortBottomSheetStateful(
      {Key? key, required this.selectedSort, this.selectedSortValue})
      : super(key: key);

  @override
  State<SortBottomSheetStateful> createState() =>
      _SortBottomSheetStatefulState();
}

enum SortEnums { a, b, c, d }

class _SortBottomSheetStatefulState extends State<SortBottomSheetStateful> {
  SortEnums _sort = SortEnums.a;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sort = widget.selectedSortValue ?? SortEnums.a;
  }

  @override
  Widget build(BuildContext context) {
    return AppUtils.commonContainer(
      decoration: AppUtils.commonBoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppUtils.commonSizedBox(height: 20),
          AppUtils.commonTextWidget(
              margin: AppUtils.edgeInsetsOnly(left: 20),
              text: 'SORT BY',
              letterSpacing: 1,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              textColor: AppColors.colorPrimary,
              fontFamily: AppConstants.fontFamilyPoppins),
          AppUtils.commonSizedBox(height: 10),
          AppUtils.commonDiver(color: AppColors.colorText),
          Padding(
            padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: AppUtils.commonTextWidget(
                  text: 'Newest First',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700),
              trailing: Radio(
                value: SortEnums.a,
                activeColor: AppColors.colorPrimary,
                groupValue: _sort,
                onChanged: (value) {
                  setState(() {
                    _sort = value ?? SortEnums.a;
                    print("sort : $_sort");
                    widget.selectedSort(_sort,context);
                    // Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: AppUtils.commonTextWidget(
                  text: 'Popularity',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700),
              trailing: Radio(
                value: SortEnums.b,
                activeColor: AppColors.colorPrimary,
                groupValue: _sort,
                onChanged: (value) {
                  setState(() {
                    _sort = value ?? SortEnums.a;
                    print("sort : $_sort");
                    widget.selectedSort(_sort,context);
                    // Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: AppUtils.commonTextWidget(
                  text: 'Rating - High To Low',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700),
              trailing: Radio(
                value: SortEnums.c,
                activeColor: AppColors.colorPrimary,
                groupValue: _sort,
                onChanged: (value) {
                  setState(() {
                    _sort = value ?? SortEnums.a;
                    print("sort : $_sort");
                    widget.selectedSort(_sort,context);
                    // Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: AppUtils.commonTextWidget(
                  text: 'Rating - Low To High',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700),
              trailing: Radio(
                activeColor: AppColors.colorPrimary,
                value: SortEnums.d,
                groupValue: _sort,
                onChanged: (value) {
                  setState(() {
                    _sort = value ?? SortEnums.a;
                    print("sort : $_sort");
                    widget.selectedSort(_sort,context);
                    // Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
          AppUtils.commonSizedBox(height: 20),
        ],
      ),
    );
  }
}
