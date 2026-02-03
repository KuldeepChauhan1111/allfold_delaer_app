import 'package:flutter/material.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/constants/app_strings_constants.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/app_bar_widget.dart';
import 'package:sales_app/core/widgets/app_bar_widget2.dart';
import 'package:sales_app/features/orders/presentation/pages/tabs/tab_in_process_widget.dart';
import 'package:sales_app/features/orders/presentation/pages/tabs/tab_past_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, appBarSize),
        child: AppBarWidget2(
          centerTitle: false,
          title: titleOrders,
        ),
      ),
      body: Column(
        children: [
          5.toSizedBoxHeight,
          _tabBar(),
          5.toSizedBoxHeight,
          Expanded(child: _tabView()),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return AppUtils.commonContainer(
      height: 45,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: AppUtils.commonBoxDecoration(
        // color: AppColors.colorBg,
        borderRadius: AppUtils.borderRadiusAll(raduis: 5),
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 2),
      ),
      child: TabBar(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        indicatorWeight: 0,
        dividerHeight: 0,

        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        // padding: EdgeInsets.zero,
        // indicatorPadding: EdgeInsets.zero,
        indicatorColor: AppColors.colorPrimary,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.fill,
        // labelPadding: EdgeInsets.zero,
        indicator: AppUtils.commonGradientBoxDecoration(borderRadius: 5),

        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tabs: [
          Container(
            // margin: const EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.only(top: 7, bottom: 7, right: 14, left: 14),
            // decoration: ,
            child: 'Active'.textWidget(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeNormal,
                color: AppColors.colorLightGrey),
          ),
          Container(
            // margin: const EdgeInsets.only(bottom: 5),

            padding: EdgeInsets.only(top: 7, bottom: 7, right: 14, left: 14),
            // decoration: BoxDecoration(),
            child: 'Completed'.textWidget(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeNormal,
                textAlign: TextAlign.center,
                color: AppColors.colorLightGrey),
          )
        ],
      ),
    );
  }

  Widget _tabView() {
    return TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          TabInProcessWidget(),
          // TabUpcomingWidget(),
          TabPastWidget(),
        ]);
  }
}
