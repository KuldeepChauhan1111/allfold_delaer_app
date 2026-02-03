class FilterModel{
  String? filterName;
  List<FilterValueData>? filterValues;
  FilterModel(this.filterName,this.filterValues);
}
class FilterValueData{
  String? filterValueName;
  bool? filterValueIsChecked;
  FilterValueData(this.filterValueIsChecked,this.filterValueName);
}