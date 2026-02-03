import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/dependency/global_get_it.dart';
import 'package:sales_app/core/routes/app_router.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/storage/i_preference.dart';
import 'package:sales_app/core/storage/preference_keys.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/utils/image_path.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = AppUtils.getMediaHeight(context);
    final width = AppUtils.getMediaWidth(context);

    return AppScaffold(
        body: Center(
      child: icAppLogo.imageAssetWidget(
        height: 350,
        width: MediaQuery.sizeOf(context).width * 0.7,
      ),
    ));
  }

  _navigateScreen(BuildContext context) async {
    String token = await globalGetIt<IPreference>().getPreferenceValue(
        preferenceKey: PreferenceKey.token, defaultValue: '');
    Future.delayed(const Duration(seconds: 2), () {
          if (token.isNotEmpty) {
            AutoRouter.of(context).replaceAll([const DashboardRoute()]);
            // AutoRouter.of(context).pushAndPopUntil(const DashboardRoute(),
            //     predicate: (route) => false);
          } else {
            // AutoRouter.of(context).replaceAll([const DashboardRoute()]);
            AutoRouter.of(context).replaceAll([const LogInRoute()]);
          }

    });
  }
}
