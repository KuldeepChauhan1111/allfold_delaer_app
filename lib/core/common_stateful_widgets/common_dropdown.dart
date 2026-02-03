import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/utils/app_utils.dart';

class CommonDropdown extends StatefulWidget {
  final String? hintText;
  final String? selectedValue;
  final Function? onChanged;
  final List<String>? items;
  const CommonDropdown({Key? key, this.selectedValue, this.onChanged, this.items, this.hintText}) : super(key: key);

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: AppColors.colorBg,
      focusColor: AppColors.colorSecondary,
      hint: AppUtils.commonTextWidget(
          letterSpacing: 0.5,
          text: widget.hintText ?? ''),
      isExpanded: true,
      value: widget.selectedValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 0,bottom: 0,left: 10,right: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.colorSecondary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.colorSecondary,
          ),
        ),
      ),
      items: widget.items?.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value){
        if(widget.onChanged != null){
          widget.onChanged!(value);
        }
      },
    );
  }
}
