import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/image_path.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final BottomSheet? bottomSheet;
  final bool? isBgAsset;
  final String? bg;
  final double? bgHeight;
  final Color? bgColor;

  const AppScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
    this.bgHeight,
    this.isBgAsset,
    this.bg,
    this.bottomSheet,
    this.bgColor
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    final bool isBgAsset = widget.isBgAsset == true && widget.bg != null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) {
        if (didPop) return;
        Navigator.pop(context, true);
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height:  MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            if (isBgAsset)
              widget.bg!.imageAssetWidget(
                height: widget.bgHeight ?? MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                boxFit: BoxFit.cover,
              ),
            Scaffold(
              bottomSheet: widget.bottomSheet,
              backgroundColor: !isBgAsset ?  widget.bgColor?? AppColors.colorBg    : null,
              bottomNavigationBar: widget.bottomNavigationBar,
              appBar: widget.appBar,
              body: SafeArea(child: widget.body),
            ),
          ],
        ),
      ),
    );
  }
}
