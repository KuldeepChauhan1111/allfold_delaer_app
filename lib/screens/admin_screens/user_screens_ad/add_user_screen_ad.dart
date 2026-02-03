// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sales_app/core/common/common_box_text_field.dart';
// import 'package:sales_app/core/common_stateful_widgets/common_dropdown.dart';
// import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
// import 'package:sales_app/core/constants/app_colors.dart';
// import 'package:sales_app/core/utils/app_utils.dart';
// import 'package:sales_app/models/admin_models/add_user_model.dart';
// import 'package:sales_app/models/admin_models/get_user_by_id_model.dart';
// import 'package:sales_app/models/common_model/common_response_model.dart';
// import 'package:sales_app/models/general_models/get_all_city_model.dart';
// import 'package:sales_app/models/general_models/get_all_country_model.dart';
// import 'package:sales_app/models/general_models/get_all_state_model.dart';
//
// class AddUserScreenAD extends StatefulWidget {
//   // String? imageUrl;
//   bool? isEdit;
//   int? userId;
//
//   AddUserScreenAD({Key? key, this.isEdit, this.userId}) : super(key: key);
//
//   @override
//   State<AddUserScreenAD> createState() => _AddUserScreenADState();
// }
//
// class _AddUserScreenADState extends State<AddUserScreenAD> {
//   File? _image;
//   var imageFull;
//   GetAllCountryModel? getAllCountryModel;
//   GetAllStateModel? getAllStateModel;
//   GetAllCityModel? getAllCityModel;
//   AddUserModel? addUserModel;
//   CommonResponseModel? commonResponseModel;
//   GetUserByIdModel? getUserByIdModel;
//   CommonResponseModel? bbxzdfb;
//
//   String? selectedCountry;
//   String? selectedState;
//   String? selectedCity;
//   String? imageUrl;
//
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//
//   Future getImage() async {
//     if (Platform.isIOS) {
//       var status1 = await Permission.photos.request();
//       if (status1.isDenied || status1.isPermanentlyDenied) {
//         print(status1.isPermanentlyDenied);
//         print(status1.isDenied);
//         openAppSettings();
//       } else {
//         print(status1.isPermanentlyDenied);
//         print(status1.isDenied);
//         imageFull = await ImagePicker.platform
//             .getImageFromSource(source: ImageSource.gallery);
//         if (imageFull?.path != null) {
//           setState(() {
//             _image = File(imageFull?.path ?? '');
//           });
//         }
//       }
//     } else {
//       var status = await Permission.storage.request();
//       var statusNew = await Permission.photos.request();
//       if (status.isGranted || statusNew.isGranted) {
//         imageFull = await ImagePicker.platform
//             .getImageFromSource(source: ImageSource.gallery);
//         if (imageFull?.path != null) {
//           setState(() {
//             _image = File(imageFull?.path ?? '');
//           });
//         }
//       } else {
//         openAppSettings();
//       }
//     }
//   }
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
//           appBar: appBarRow(),
//           body: Stack(
//             children: [
//               Padding(
//                 padding: AppUtils.edgeInsetsOnly(
//                     left: 20, right: 20, top: 0, bottom: 0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       AppUtils.commonSizedBox(height: 30),
//                       imageWidget(),
//                       AppUtils.commonSizedBox(height: 30),
//                       CommonBoxTextField(
//                         controller: fullNameController,
//                         labelText: "Full name",
//                       ),
//                       AppUtils.commonSizedBox(height: 20),
//                       CommonBoxTextField(
//                         controller: emailController,
//                         labelText: "Email Address",
//                       ),
//                       AppUtils.commonSizedBox(height: 20),
//                       CommonBoxTextField(
//                           controller: phoneController,
//                           textInputType: TextInputType.phone,
//                           labelText: "Phone Number"),
//                       AppUtils.commonSizedBox(height: 20),
//                       CommonBoxTextField(
//                           controller: addressController,
//                           maxLines: 3,
//                           topContentPadding: 5,
//                           bottomContentPadding: 5,
//                           labelText: "Address"),
//                       AppUtils.commonSizedBox(height: 20),
//                       CommonDropdown(
//                           hintText: "Country",
//                           items: getAllCountryModel?.data
//                               ?.map((e) => e.countryName ?? "")
//                               .toList(),
//                           selectedValue: selectedCountry,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedCountry = value;
//                             });
//                           }),
//                       AppUtils.commonSizedBox(height: 20),
//                       CommonDropdown(
//                           hintText: "State",
//                           items: getAllStateModel?.data
//                               ?.map((e) => e.stateName ?? "")
//                               .toList(),
//                           selectedValue: selectedState,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedState = value;
//                             });
//                           }),
//                       AppUtils.commonSizedBox(height: 20),
//                       CommonDropdown(
//                           hintText: "City",
//                           items: getAllCityModel?.data
//                               ?.map((e) => e.cityname ?? "")
//                               .toList(),
//                           selectedValue: selectedCity,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedCity = value;
//                             });
//                           }),
//                       AppUtils.commonSizedBox(height: 30),
//                       AppUtils.commonElevatedBtn(
//                           text: widget.isEdit ?? false
//                               ? "UPDATE USER"
//                               : "ADD USER",
//                           bgColor: AppColors.colorPrimary,
//                           textColor: AppColors.colorWhite,
//                           width: double.infinity,
//                           fontWeight: FontWeight.bold,
//                           onPressed: () {},
//                           height: 45,
//                           leftMargin: 0,
//                           rightMargin: 0,
//                           bottomMargin: 0,
//                           topMargin: 0),
//                       AppUtils.commonSizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
//
//   Widget imageWidget() {
//     return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Column(
//         children: [
//           AppUtils.commonContainer(
//             decoration: AppUtils.commonBoxDecoration(
//                 border: Border.all(color: AppColors.colorText, width: 1),
//                 borderRadius: AppUtils.borderRadiusAll(raduis: 12),
//                 color: AppColors.colorText),
//             child: _image == null
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: CachedNetworkImage(
//                       height: 100,
//                       width: 100,
//                       imageUrl: imageUrl ?? '',
//                       imageBuilder: (context, imageProvider) => Container(
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: imageProvider, fit: BoxFit.cover),
//                         ),
//                       ),
//                       placeholder: (context, url) => Center(
//                           child: CircularProgressIndicator(
//                         color: AppColors.colorPrimary,
//                         strokeWidth: 1.5,
//                       )),
//                       errorWidget: (context, url, error) => Icon(Icons.person,
//                           size: 40, color: AppColors.colorWhite),
//                     ),
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.file(
//                       File(
//                         _image?.path ?? '',
//                       ),
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//           ),
//           TextButton(
//             style:
//                 TextButton.styleFrom(foregroundColor: AppColors.colorPrimary),
//             onPressed: () {
//               getImage();
//             },
//             child: AppUtils.commonTextWidget(
//                 text: _image != null || (widget.isEdit ?? false)
//                     ? "Edit Image"
//                     : "Add Image",
//                 letterSpacing: 0.5,
//                 textColor: AppColors.colorPrimary,
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       )
//     ]);
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
//                   text: widget.isEdit ?? false ? "Edit User" : "Add User",
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
// }
