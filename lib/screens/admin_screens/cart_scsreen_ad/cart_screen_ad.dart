
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_app/core/common_stateful_widgets/app_scaffold.dart';
import 'package:sales_app/core/constants/app_colors.dart';
import 'package:sales_app/core/utils/app_utils.dart';
import 'package:sales_app/core/widgets/custom_text_form_field.dart';

class CartScreenAD extends StatefulWidget {
  const CartScreenAD({super.key});

  @override
  State<CartScreenAD> createState() => _CartScreenADSate();
}

class _CartScreenADSate extends State<CartScreenAD> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppScaffold(
        body: Scaffold(
          backgroundColor: AppColors.colorTransparent,
          appBar: appBar(),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: AppUtils.commonContainer(
                        margin: AppUtils.edgeInsetsOnly(top: 10),
                        child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Visibility(
                              visible: true,
                              child: Column(
                                children: [
                                  AppUtils.commonSizedBox(height: 10),
                                  Slidable(
                                      key: ValueKey(0),
                                      endActionPane: ActionPane(
                                        extentRatio: 0.20,
                                        dragDismissible: false,
                                        motion: ScrollMotion(),
                                        dismissible: DismissiblePane(
                                            dismissalDuration:
                                                Duration(milliseconds: 1000),
                                            dismissThreshold: 0.1,
                                            onDismissed: () {}),
                                        children: [
                                          SlidableAction(
                                            // An action can be bigger than the others.
                                            // flex: 2,
                                            onPressed: (context) {
                                              AppUtils.showCustomTwoBtnDialog(
                                                ctx: context,
                                                dialogBtnTextRight: "Yes",
                                                dialogBtnTextLeft: "No",
                                                dialogMessage:
                                                    "Are you sure you want to delete this item?",
                                                dialogTitle: "Alert",
                                                dialogBtnRightFnc: () {},
                                              );
                                            },
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            backgroundColor: Colors.red,
                                            foregroundColor:
                                                AppColors.colorWhite,
                                            icon: Icons.delete_outline,
                                            // label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: AppUtils.commonContainer(
                                          margin: AppUtils.edgeInsetsOnly(
                                              bottom: 0, left: 15, right: 15),
                                          decoration:
                                              AppUtils.commonBoxDecoration(
                                            borderRadius:
                                                AppUtils.borderRadiusAll(
                                                    raduis: 15),
                                            // border: Border.all(
                                            //     color: AppColors.colorWhite.withOpacity(0.2)),
                                            // color: AppColors.colorLightGrey,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Column(
                                                    children: [
                                                      AppUtils.commonContainer(
                                                          // child: AppUtils.imageWidget(
                                                          //     image:
                                                          //     cartModelList[index]
                                                          //         .image ??
                                                          //         '',
                                                          //     ctx: context),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: '',
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                color: AppColors
                                                                    .colorPrimary,
                                                                strokeWidth:
                                                                    1.5,
                                                              )),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(
                                                                      Icons
                                                                          .image,
                                                                      size: 40,
                                                                      color: AppColors
                                                                          .colorPrimary),
                                                            ),
                                                          ),
                                                          height: 80,
                                                          width: 70,
                                                          // padding: AppUtils.edgeInsetsOnly(
                                                          //   top: 10,
                                                          //   right: 10,
                                                          //   left: 10,
                                                          //   bottom: 10,
                                                          // ),
                                                          decoration: AppUtils.commonBoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: AppColors
                                                                      .colorSecondary
                                                                      .withOpacity(
                                                                          0.1),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 5,
                                                                  offset: Offset(
                                                                      0,
                                                                      4), // This is the bottom shadow offset
                                                                ),
                                                              ],
                                                              color: AppColors
                                                                  .colorWhite,
                                                              borderRadius: AppUtils
                                                                  .borderRadiusAll(
                                                                      raduis:
                                                                          12))),
                                                    ],
                                                  ),
                                                  AppUtils.commonSizedBox(
                                                      width: 15),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AppUtils.commonTextWidget(
                                                            text: '',
                                                            fontSize: 14,
                                                            height: 1,
                                                            letterSpacing: 0.5,
                                                            textColor: AppColors
                                                                .colorText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                        AppUtils.commonTextWidget(
                                                            margin: AppUtils
                                                                .edgeInsetsOnly(
                                                                    top: 5),
                                                            text: '',
                                                            fontSize: 12,
                                                            letterSpacing: 0.5,
                                                            height: 0,
                                                            textColor: AppColors
                                                                .colorPrimary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                        Row(
                                                          children: [
                                                            AppUtils.commonTextWidget(
                                                                text: "Size : ",
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0.5,
                                                                textColor:
                                                                    AppColors
                                                                        .colorText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            AppUtils.commonTextWidget(
                                                                text: '',
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0.5,
                                                                textColor: AppColors
                                                                    .colorSecondary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))),
                                  AppUtils.commonSizedBox(height: 10)
                                ],
                              ),
                            );
                          },
                        )),
                  ),
                  Visibility(
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColors.colorTransparent,
                      surfaceTintColor: AppColors.colorLightGrey,
                      shadowColor: AppColors.colorTransparent,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: AppUtils.edgeInsetsOnly(
                                left: 20, right: 20, top: 10),
                            child: Row(
                              children: [
                                AppUtils.commonTextWidget(
                                    text: "Total Amount", letterSpacing: 1),
                                AppUtils.commonSizedBox(width: 10),
                                AppUtils.commonTextWidget(
                                    text: '0',
                                    letterSpacing: 1,
                                    textColor: AppColors.colorPrimary),
                              ],
                            ),
                          ),
                          AppUtils.commonElevatedBtn(
                              borderRadiusAll: 15,
                              width: double.infinity,
                              height: 50,
                              text: "CHECKOUT",
                              fontSize: 16,
                              bgColor: AppColors.colorPrimary,
                              textColor: AppColors.colorWhite,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              onPressed: () {},
                              leftMargin: 10,
                              rightMargin: 10,
                              topMargin: 20,
                              bottomMargin: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(4.0),
      //   child: Container(
      //     color: AppColors.colorWhite,
      //     height: 1.0,
      //   ),
      // ),
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
              text: "Cart",
              textColor: AppColors.colorPrimary,
              fontSize: 20,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700),
        ],
      ),
    );
  }

  openEditDialog(BuildContext ctx, int indx) {
    showDialog(
      context: context,
      builder: (context) {
        String? otherValue;
        return AlertDialog(
          contentPadding: AppUtils.edgeInsetsAll(allPadding: 8),
          backgroundColor: AppColors.colorBg,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppUtils.commonTextWidget(
                  text: "Edit Quantity",
                  textColor: AppColors.colorSecondary,
                  letterSpacing: 1),
            ],
          ),
          content: Container(
              margin: AppUtils.edgeInsetsOnly(top: 20),
              // height: 100,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppUtils.commonSizedBox(
                      // width: 70,
                      child: CustomTextFormField(
                    maxLines: 1,
                    hintText: "Qty",
                    inputType: TextInputType.number,
                    hintColor: AppColors.colorText,
                    controller: TextEditingController(text: ''),
                    onChanged: (value) {
                      setState(() {
                        otherValue = value;
                      });
                    },
                  )),
                  AppUtils.commonSizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: AppUtils.commonTextWidget(
                              text: "Submit",
                              letterSpacing: 1,
                              textColor: AppColors.colorPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}
