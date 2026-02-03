import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/common_stateful_widgets/change_password_screen_ad.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/utils/preference_helper.dart';
import 'package:sales_app/core/widgets/app_bar_widget.dart';
import 'package:sales_app/core/widgets/app_bar_widget2.dart';
import 'package:sales_app/features/authentication/presentation/pages/login_screen.dart';
import 'package:sales_app/models/admin_models/get_user_by_id_model.dart';
import 'package:sales_app/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:sales_app/screens/sales_user_screens/profile_screens/order_history_screen.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetUserByIdModel? getUserByIdModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, appBarSize),
        child: AppBarWidget2(
          centerTitle: false,
          title: "PROFILE",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppUtils.commonSizedBox(height: 20),
            userImageWidget(),
            AppUtils.commonSizedBox(height: 20),
            AppUtils.commonTextWidget(
              text: '',
              letterSpacing: 0.5,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: AppConstants.fontFamilyPoppins,
            ),
            AppUtils.commonSizedBox(height: 5),
            AppUtils.commonTextWidget(
              text: '',
              letterSpacing: 0.5,
              textColor: AppColors.colorSecondary,
              fontSize: 12,
              fontFamily: AppConstants.fontFamilyPoppins,
            ),
            AppUtils.commonSizedBox(height: 20),
            AppUtils.commonDiver(
                color: AppColors.colorPrimary, endIndent: 20, indent: 20),
            AppUtils.commonSizedBox(height: 20),
            commonRow(
                preIcon: Icons.person,
                text: "Edit Profile",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneralEditProfileScreen(),
                      )).then((value) {});
                }).toVisibility(false),
            // commonRow(
            //     preIcon: Icons.history,
            //     text: "Orders History",
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const OrderHistoryScreen(),
            //           ));
            //     }),
            commonRow(
                preIcon: Icons.lock_outline_rounded,
                text: "Change Password",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CommonChangePasswordScreen(),
                      ));
                }).toVisibility(false),
            // commonRow(
            //     preIcon: Icons.calendar_month,
            //     text: "Create Request",
            //     onTap: () {}),
            // commonRow(
            //     preIcon: Icons.privacy_tip_outlined,
            //     text: "Privacy Policy",
            //     onTap: () {}),
            commonRow(
                preIcon: Icons.logout,
                text: "Log Out",
                onTap: () {
                  AppUtils.showCustomTwoBtnDialog(
                      ctx: context,
                      dialogBtnTextRight: "Yes",
                      dialogBtnTextLeft: "No",
                      rightPop: false,
                      dialogBtnRightFnc: () {
                        globalGetIt<IPreference>().clearPreference();
                        AutoRouter.of(context).replaceAll([const LogInRoute()]);
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const LogInScreen(),
                        //     ),
                        //     (route) => false);
                      },
                      dialogTitle: "Logout",
                      dialogMessage: "Are you sure you want to log out? You will need to log in again to access your account.");
                }),
          ],
        ),
      ),
    );
  }

  Widget commonRow(
      {String? text, IconData? preIcon, required VoidCallback onTap}) {
    return Column(
      children: [
        AppUtils.commonInkWell(
          onTap: onTap,
          child: AppUtils.commonContainer(
            child: Padding(
              padding: AppUtils.edgeInsetsOnly(left: 20, right: 20),
              child: Row(
                children: [
                  AppUtils.commonContainer(
                      padding: AppUtils.edgeInsetsAll(allPadding: 8),
                      decoration: AppUtils.commonBoxDecoration(
                          border: Border.all(
                              width: 0.2, color: AppColors.colorSecondary),
                          color: AppColors.colorWhite,
                          shape: BoxShape.circle),
                      child: Center(
                          child: Icon(preIcon,
                              color: AppColors.colorPrimary, size: 22))),
                  AppUtils.commonSizedBox(width: 20),
                  Expanded(
                      child: AppUtils.commonTextWidget(
                          text: text ?? '',
                          textColor: AppColors.colorWhite,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold)),
                  AppUtils.commonSizedBox(width: 10),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: AppColors.colorPrimary, size: 16),
                ],
              ),
            ),
          ),
        ),
        AppUtils.commonSizedBox(height: 20),
      ],
    );
  }

  Widget userImageWidget() {
    return Stack(
      children: [
        AppUtils.commonContainer(
          padding: AppUtils.edgeInsetsAll(allPadding: 3),
          decoration: AppUtils.commonBoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.colorPrimary, width: 2),
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              height: 100,
              width: 100,
              imageUrl: '',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                color: AppColors.colorPrimary,
                strokeWidth: 1.5,
              )),
              errorWidget: (context, url, error) => const Icon(Icons.person,
                  size: 40, color: AppColors.colorPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
