import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/common/common_box_text_field.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/utils/image_path.dart';
import 'package:sales_app/core/widgets/app_bar_widget.dart';
import 'package:sales_app/models/common_model/common_response_model.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  CommonResponseModel? commonResponseModel;

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
                        AppUtils.commonTextWidget(
                            text: "Let's get you a new password",
                            textColor: AppColors.colorPrimary),
                        AppUtils.commonSizedBox(height: 20),

                        AppUtils.commonSizedBox(
                            height: 175, child: Image.asset(icChangePassword)),
                        // AppUtils.commonSizedBox(height: 10),
                      ],
                    ),
                    AppUtils.commonSizedBox(height: 20),
                    AppUtils.commonTextWidget(
                        text:
                            "Please enter your email address. We will send you an email with a new password.",
                        textAlign: TextAlign.center,
                        textColor: AppColors.colorSecondary,
                        letterSpacing: 1),
                    AppUtils.commonSizedBox(height: 30),
                    CommonBoxTextField(
                      controller: emailController,
                      labelText: "Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    // AppUtils.commonSizedBox(height: 20),
                    AppUtils.commonElevatedBtn(
                        onPressed: () {
                        },
                        width: double.infinity,
                        bgColor: AppColors.colorPrimary,
                        text: "Send",
                        height: 45,
                        topMargin: 30,
                        bottomMargin: 10,
                        rightMargin: 0,
                        leftMargin: 0,
                        textColor: AppColors.colorWhite),
                  ],
                ),
              ),
            ),
          ],
        ),
        // appBar: appBar(),
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, appBarSize),
          child: AppBarWidget(
            title: titleForgotPassword,
            isBackVisible: true,
            isCartVisible: false,
          ),
        ),
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
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: AppColors.colorSecondary,
                  ),
                )),
          ),
          AppUtils.commonSizedBox(width: 15),
          AppUtils.commonTextWidget(
              text: "Forgot Password",
              textColor: AppColors.colorPrimary,
              fontSize: 20,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}
