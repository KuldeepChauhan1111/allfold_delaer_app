import 'package:flutter/material.dart';
import 'package:sales_app/core/common/common_box_text_field.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/utils/image_path.dart';

class CommonChangePasswordScreen extends StatefulWidget {
  const CommonChangePasswordScreen({super.key});

  @override
  State<CommonChangePasswordScreen> createState() =>
      _CommonChangePasswordScreenState();
}

class _CommonChangePasswordScreenState
    extends State<CommonChangePasswordScreen> {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController conNewPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppScaffold(
        body: Stack(
          children: [
            Padding(
              padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppUtils.commonSizedBox(height: 30),
                    Column(
                      children: [
                        AppUtils.commonSizedBox(
                            height: 175, child: Image.asset(icChangePassword)),
                        AppUtils.commonSizedBox(height: 10),
                        AppUtils.commonTextWidget(
                            text: "Let's get you a new password",
                            textColor: AppColors.colorPrimary),
                      ],
                    ),
                    AppUtils.commonSizedBox(height: 50),
                    CommonBoxTextField(
                      controller: oldPassController,
                      labelText: "Old Password",
                    ),
                    AppUtils.commonSizedBox(height: 20),
                    CommonBoxTextField(
                      controller: newPassController,
                      labelText: "New Password",
                    ),
                    AppUtils.commonSizedBox(height: 20),
                    CommonBoxTextField(
                        controller: conNewPassController,
                        labelText: "Confirm New Password"),
                    AppUtils.commonElevatedBtn(
                        onPressed: () {},
                        width: double.infinity,
                        bgColor: AppColors.colorPrimary,
                        text: "SUBMIT",
                        height: 45,
                        topMargin: 30,
                        bottomMargin: 20,
                        rightMargin: 0,
                        leftMargin: 0,
                        textColor: AppColors.colorWhite)
                  ],
                ),
              ),
            ),
          ],
        ),
        appBar: appBar(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: AppColors.colorTransparent,
      elevation: 5,
      toolbarHeight: 60,
      surfaceTintColor: AppColors.colorTransparent,
      automaticallyImplyLeading: false,
      title: Row(
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
              text: "Change Password",
              textColor: AppColors.colorPrimary,
              fontSize: 20,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}
