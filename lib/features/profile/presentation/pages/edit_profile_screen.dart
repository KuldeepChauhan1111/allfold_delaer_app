import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sales_app/core/common/common_box_text_field.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/common_stateful_widgets/common_dropdown.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/models/admin_models/get_user_by_id_model.dart';
import 'package:sales_app/models/common_model/common_response_model.dart';
import 'package:sales_app/models/general_models/get_all_city_model.dart';
import 'package:sales_app/models/general_models/get_all_country_model.dart';
import 'package:sales_app/models/general_models/get_all_state_model.dart';

class GeneralEditProfileScreen extends StatefulWidget {
  final GetUserByIdModel? getUserByIdModel;

  const GeneralEditProfileScreen({super.key, this.getUserByIdModel});

  @override
  State<GeneralEditProfileScreen> createState() =>
      _GeneralEditProfileScreenState();
}

class _GeneralEditProfileScreenState extends State<GeneralEditProfileScreen> {
  File? _image;
  var imageFull;
  GetAllCountryModel? getAllCountryModel;
  GetAllStateModel? getAllStateModel;
  GetAllCityModel? getAllCityModel;
  CommonResponseModel? commonResponseModel;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCountry =
        widget.getUserByIdModel?.data?.map((e) => e.countryName).first;
    selectedState =
        widget.getUserByIdModel?.data?.map((e) => e.stateName).first;
    selectedCity = widget.getUserByIdModel?.data?.map((e) => e.cityName).first;
    fullNameController.text =
        widget.getUserByIdModel?.data?.first.userName ?? '';
    emailController.text = widget.getUserByIdModel?.data?.first.email ?? '';
    phoneController.text =
        widget.getUserByIdModel?.data?.first.phoneNumber ?? '';
    addressController.text = widget.getUserByIdModel?.data?.first.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppScaffold(
          appBar: appBarRow(),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    AppUtils.commonSizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppUtils.commonContainer(
                          padding: AppUtils.edgeInsetsAll(allPadding: 3),
                          decoration: AppUtils.commonBoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.colorPrimary, width: 2),
                          ),
                          child: _image != null
                              ? CircleAvatar(
                                  backgroundColor: AppColors.colorTransparent,
                                  radius: 50,
                                  child: ClipOval(
                                    child: Image.file(
                                      File(
                                        _image?.path ?? '',
                                      ),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : ClipOval(
                                  child: CachedNetworkImage(
                                    height: 100,
                                    width: 100,
                                    imageUrl: widget.getUserByIdModel?.data
                                            ?.first.profilePic ??
                                        '',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.colorPrimary,
                                      strokeWidth: 1.5,
                                    )),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.person,
                                            size: 40,
                                            color: AppColors.colorPrimary),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          getImage();
                        },
                        child: AppUtils.commonTextWidget(
                            text: "Change Photo",
                            letterSpacing: 0.5,
                            textColor: AppColors.colorPrimary)),
                    AppUtils.commonSizedBox(height: 20),
                    Padding(
                      padding: AppUtils.edgeInsetsOnly(left: 10, right: 10),
                      child: Column(
                        children: [
                          CommonBoxTextField(
                              labelText: "Full Name",
                              controller: fullNameController,
                              hintTextColor: AppColors.colorText),
                          AppUtils.commonSizedBox(height: 20),
                          CommonBoxTextField(
                              controller: emailController,
                              labelText: "Email Address",
                              hintTextColor: AppColors.colorText),
                          AppUtils.commonSizedBox(height: 20),
                          CommonBoxTextField(
                              controller: phoneController,
                              labelText: "Phone Number",
                              hintTextColor: AppColors.colorText),
                          AppUtils.commonSizedBox(height: 20),
                          CommonBoxTextField(
                              controller: addressController,
                              labelText: "Address",
                              hintTextColor: AppColors.colorText,
                              maxLines: 3),
                          AppUtils.commonSizedBox(height: 20),
                          CommonDropdown(
                              hintText: "Country",
                              items: getAllCountryModel?.data
                                  ?.map((e) => e.countryName ?? "")
                                  .toList(),
                              selectedValue: selectedCountry,
                              onChanged: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              }),
                          AppUtils.commonSizedBox(height: 20),
                          CommonDropdown(
                              hintText: "State",
                              items: getAllStateModel?.data
                                  ?.map((e) => e.stateName ?? "")
                                  .toList(),
                              selectedValue: selectedState,
                              onChanged: (value) {
                                setState(() {
                                  selectedState = value;
                                });
                              }),
                          AppUtils.commonSizedBox(height: 20),
                          CommonDropdown(
                              hintText: "City",
                              items: getAllCityModel?.data
                                  ?.map((e) => e.cityname ?? "")
                                  .toList(),
                              selectedValue: selectedCity,
                              onChanged: (value) {
                                setState(() {
                                  selectedCity = value;
                                });
                              }),
                        ],
                      ),
                    ),
                    AppUtils.commonElevatedBtn(
                        text: "Update Profile",
                        bgColor: AppColors.colorPrimary,
                        textColor: AppColors.colorWhite,
                        width: double.infinity,
                        height: 45,
                        bottomMargin: 30,
                        topMargin: 20,
                        leftMargin: 10,
                        rightMargin: 10,
                        onPressed: () {}),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  PreferredSizeWidget appBarRow() {
    return AppBar(
      backgroundColor: AppColors.colorTransparent,
      surfaceTintColor: AppColors.colorTransparent,
      shadowColor: AppColors.colorTransparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppUtils.commonInkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.pop(context);
                },
                child: AppUtils.commonContainer(
                    padding: AppUtils.edgeInsetsOnly(
                        top: 15, bottom: 15, left: 12, right: 12),
                    decoration: AppUtils.commonBoxDecoration(
                        borderRadius: AppUtils.borderRadiusAll(raduis: 18),
                        border: Border.all(color: AppColors.colorPrimary)),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: AppColors.colorSecondary,
                      ),
                    )),
              ),
              AppUtils.commonSizedBox(width: 15),
              AppUtils.commonTextWidget(
                  text: "Edit Profile",
                  textColor: AppColors.colorPrimary,
                  fontSize: 16,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w700),
            ],
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    if (Platform.isIOS) {
      var status1 = await Permission.photos.request();
      if (status1.isDenied || status1.isPermanentlyDenied) {
        print(status1.isPermanentlyDenied);
        print(status1.isDenied);
        openAppSettings();
      } else {
        print(status1.isPermanentlyDenied);
        print(status1.isDenied);
        imageFull = await ImagePicker.platform
            .getImageFromSource(source: ImageSource.gallery);
        if (imageFull?.path != null) {
          setState(() {
            _image = File(imageFull?.path ?? '');
          });
        }
      }
    } else {
      var status = await Permission.storage.request();
      var statusNew = await Permission.photos.request();
      if (status.isGranted || statusNew.isGranted) {
        imageFull = await ImagePicker.platform
            .getImageFromSource(source: ImageSource.gallery);
        if (imageFull?.path != null) {
          setState(() {
            _image = File(imageFull?.path ?? '');
          });
        }
      } else {
        openAppSettings();
      }
    }
  }
}
