import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:webazin/webazin/utilities.dart';

import 'package:webazin/utils/utils.dart';
import '../../trader/widgets/trade_custom_text_field_widget.dart';
import '../controllers/assets_controller.dart';
import 'assets_list_assets_widget.dart';
import 'assets_list_shimmer_assets_widget.dart';

class AssetsFooter extends GetView<AssetsController> {
  const AssetsFooter({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    // bool isShowHelper=Get.find<AuthService>().getShowHelper(AuthService.helperAsset);
    // final keyZero = GlobalKey();
    // final keyOne2 = GlobalKey();
    // WidgetsBinding.instance!.addPostFrameCallback(
    //       (_) => ShowCaseWidget.of(context)!.startShowCase([
    //     isShowHelper != true ? keyOne2 : keyZero,
    //   ]),
    // );

    return Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(36),
            topLeft: Radius.circular(36),
          ),
          color: Get.theme.scaffoldBackgroundColor,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 18,
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.only(left: !isPersian() ? 18 : 0, right: isPersian() ? 0 : 8),
                            width: 70,
                            child: Text(
                              controller.isAllAssets.value ? 'All'.tr : 'Available'.tr,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: FontFamily.vazirBold,
                                color: Get.theme.dividerColor,
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          return Switch(
                            onChanged: (value) => controller.setIsSwitched(value),
                            value: controller.isAllAssets.value,
                            activeColor: Colors.grey.shade600,
                            activeTrackColor: Colors.grey.shade200,
                            inactiveThumbColor: Colors.redAccent,
                            inactiveTrackColor: Colors.orange,
                          );
                        }),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      color: context.theme.scaffoldBackgroundColor,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      height: 50,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Get.theme.dividerColor.withOpacity(0.8),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () async => controller.refreshHome(),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Get.theme.dividerColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.green, width: 1),
                                ),
                                child: Text(
                                  'Search'.tr,
                                  style: TextStyle(
                                    fontFamily: FontFamily.vazirLight,
                                    fontSize: 12,
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Obx(() {
                                return TradeCustomTextFieldWidget(
                                  textController: controller.tecParamSearch.value,
                                  hintText: 'Desired currency'.tr,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontFamily: FontFamily.vazirLight,
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 50,
                                );
                              }),
                            ),
                            InkWell(
                              onTap: () => controller.resetSearch(),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Get.theme.dividerColor.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 4,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[BoxShadow(color: Get.theme.dividerColor.withOpacity(0.2), blurRadius: 3, offset: Offset(0, 3))]),
            ),
            Obx(() {
              return !controller.isLoading.value
                  ? controller.assets.length > 0
                      ? ListAssetsWidget()
                      : Container(
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Nothing found".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ).marginOnly(bottom: 16),
                              InkWell(
                                onTap: () => controller.resetSearch(),
                                child: Icon(
                                  Icons.refresh,
                                  size: 32,
                                ),
                              )
                            ],
                          )),
                        )
                  : ListShimmerAssetsWidget();
              // return controller.assets.length > 0 ? ListAssetsWidget() : ListShimmerAssetsWidget();
            }),
          ],
        ));
  }
}
