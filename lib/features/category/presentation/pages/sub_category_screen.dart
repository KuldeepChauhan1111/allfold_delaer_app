import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/app_size_constants.dart';
import 'package:sales_app/core/routes/app_router.gr.dart';
import 'package:sales_app/core/utils/app_extensions.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/app_bar_widget.dart';
import 'package:sales_app/core/widgets/card_widget.dart';
import 'package:sales_app/features/category/data/models/get_categories_response.dart';
import 'package:sales_app/features/category/presentation/blocs/categories_cubit.dart';

@RoutePage()
class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen(
      {super.key, required this.categoriesCubit, this.categoryItem});

  final CategoriesCubit categoriesCubit;
  final Categories? categoryItem;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _bodyView();
  }

  Widget _bodyView() {
    return AppScaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, appBarSize),
        child: AppBarWidget(
          title: widget.categoryItem?.category ?? '',
          isBackVisible: true,
        ),
      ),
      body: Column(
        children: [
          10.toSizedBoxHeight,
          Expanded(
            child: (widget.categoryItem?.subCategories == 0)
                ? AppUtils.noDataWidget()
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: widget.categoriesCubit.categoryList.length,
                    itemBuilder: (context, index) {
                      return _listItem(
                          index, widget.categoriesCubit.categoryList[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _listItem(int index, Categories item) {
    if ((item.parentCategoryInfo ?? []).isNotEmpty &&
        item.parentCategoryInfo?[0].parentCategoryId ==
            widget.categoryItem?.categoryId) {
      return CardWidget(
          paddingHorizontal: 12,
          paddingVertical: 3,
          child: InkWell(
            onTap: () {
              AutoRouter.of(context).push(ProductListRoute(
                categoryId: item.categoryId,
                categoryName: item.category,
              ));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 4),
              child: Row(
                children: [
                  4.toSizedBoxWidth,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (item.category ?? 'N/A').textWidget(
                        fontWeight: FontWeight.bold,
                        fontFamily: AppConstants.fontFamilyTeko,
                        fontSize: fontSizeLarge,
                      ),
                      5.toSizedBoxHeight,
                      '${item.parentCategoryInfo?[0].productsCount ?? 0} Products'
                          .textWidget(
                        fontFamily: AppConstants.fontFamilyPoppins,
                        fontSize: fontSizeSmall,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  )),
                  (item.image ?? '').imageBase64(height: 95, width: 90)
                ],
              ),
            ),
          ));
    } else {
      return Container();
    }
  }
}
