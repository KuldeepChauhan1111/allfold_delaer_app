import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/utils/image_path.dart';
import 'package:sales_app/core/widgets/common_button_widget.dart';
import 'package:sales_app/core/widgets/custom_text_form_field.dart';
import 'package:sales_app/features/authentication/dependency/auth_get_it.dart';
import 'package:sales_app/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:sales_app/features/authentication/presentation/blocs/authentication_state.dart';

@RoutePage()
class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late AuthenticationCubit _authenticationCubit;

  @override
  void initState() {
    _authenticationCubit = authGetIt.get<AuthenticationCubit>();
    /* TODO static remove */
    // _authenticationCubit.emailEditController.text = 'testdistributor@gmail.com';
    // _authenticationCubit.passwordEditController.text = 'Test@123';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationCubit,
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: AppScaffold(
                body: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: AppUtils.edgeInsetsOnly(
                            left: 20, right: 20, top: 0, bottom: 80),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppUtils.imageWidget(
                                image: icAppLogo,
                                ctx: context,
                                fit: BoxFit.cover,
                                height: 45,
                              ),
                              AppUtils.commonSizedBox(
                                  height: AppConstants.fifty),
                              20.toSizedBoxHeight,
                              AppUtils.commonTextWidget(
                                  text: lblSignIn,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  textColor: AppColors.colorPrimary,
                                  fontFamily: AppConstants.fontFamilyRoboto),
                              AppUtils.commonSizedBox(
                                  height: AppConstants.thirty),
                              CustomTextFormField(
                                controller:
                                    _authenticationCubit.emailEditController,
                                hintText: lblEmail,
                                inputType: TextInputType.emailAddress,
                                hintColor: AppColors.colorLightGrey,
                                textColor: AppColors.colorWhite,
                                inputAction: TextInputAction.next,
                              ),
                              AppUtils.commonSizedBox(
                                  height: AppConstants.twenty),
                              CustomTextFormField(
                                controller:
                                    _authenticationCubit.passwordEditController,
                                hintText: lblPassword,
                                isShowSuffixIcon: true,
                                isPassword: true,
                                hintColor: AppColors.colorLightGrey,
                                textColor: AppColors.colorWhite,
                                inputAction: TextInputAction.go,
                              ),
                              AppUtils.commonSizedBox(
                                  height: AppConstants.fifty),
                              CommonButtonWidget(
                                  buttonText: lblSignIn.toUpperCase(),
                                  isLoading: state is LoadingState,
                                  onPressed: () {
                                    AppUtils().hideKeyBoard();
                                    // AutoRouter.of(context)
                                    //     .replaceAll([const DashboardRoute()]);
                                    _authenticationCubit.apiCallLogin(context);
                                  }),
                              AppUtils.commonSizedBox(
                                  height: AppConstants.fifteen),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    AutoRouter.of(context)
                                        .push(const ForgotPasswordRoute());
                                  },
                                  child: AppUtils.commonTextWidget(
                                    text: forgotPassword,
                                    letterSpacing: 0.5,
                                    fontSize: fontSizeMedium,
                                    textColor: AppColors.colorLightGrey,
                                  ),
                                ),
                              ).toVisibility(false),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
