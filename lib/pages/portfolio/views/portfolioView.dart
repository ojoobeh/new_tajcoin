import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/portfolioController.dart';
import '../widgets/portfolio_item_list_widget.dart';
import '../widgets/portfolio_item_shimmer_list_widget.dart';

class PortfolioView extends GetView<PortfolioController> {
  @override
  Widget build(final BuildContext context) {
    if (!controller.isPortfolioHide.value) {
      Future.delayed(Duration.zero, () => sendMessage(context));
      controller.isPortfolioHide.value = true;
    }

    printInfo();
    controller.initScrollController();
    return Scaffold(
      backgroundColor: context.theme.colorScheme.secondary,
      body: RefreshIndicator(
          onRefresh: () async {
            controller.setLoading(true);
            await controller.refreshHome(showMessage: true);
          },
          child: WillPopScope(
            onWillPop: () async {
              Get.find<RootController>().changePage(0);
              return false;
            },
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 22),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(),
                            Container(
                              child: Text(
                                'Instant portfolio'.tr,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontFamily.vazirBold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                // sendMessage(context);
                                controller.setLoading(true);
                                await controller.refreshHome(showMessage: true);
                              },
                              child: Obx(() {
                                return controller.isLoading.value
                                    ? CircularLoadingWidget(
                                        height: 30,
                                      )
                                    : SvgPicture.asset(
                                        Assets.refresh,
                                        color: Colors.black87,
                                        width: 22,
                                      );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(36),
                      topLeft: Radius.circular(36),
                    ),
                    color: Get.theme.scaffoldBackgroundColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Text(
                            'Name/amount'.tr,
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Text(
                            'Change IRT'.tr,
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: Center(
                              child: Text(
                            'Change USDT'.tr,
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Obx(() {
                    return Container(
                      height: double.infinity,
                      color: Get.theme.scaffoldBackgroundColor,
                      child: !controller.isSearching.value
                          ? controller.dataPortfolio.length > 0
                              ? ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: controller.dataPortfolio.length + 1,
                                  controller: controller.scrollController,
                                  itemBuilder: (context, index) {
                                    if (index == controller.dataPortfolio.length) {
                                      return Obx(() {
                                        return Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Opacity(
                                              opacity: controller.isLoading.value ? 1 : 0,
                                              child: CircularProgressIndicator(),
                                            ),
                                          ),
                                        );
                                      });
                                    } else {
                                      return PortfolioItemListWidget(controller.dataPortfolio[index]);
                                    }
                                  },
                                )
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
                                        onTap: () => controller.refreshHome(),
                                        child: Icon(
                                          Icons.refresh,
                                          size: 32,
                                        ),
                                      )
                                    ],
                                  )),
                                )
                          : ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return PortfolioItemShimmerListWidget();
                              },
                            ),
                    );
                  }),
                ),
              ],
            ),
          )),
    );
  }

  void sendMessage(final BuildContext context) async {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.8),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                content: WillPopScope(
                  onWillPop: () async => true,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Get.theme.scaffoldBackgroundColor),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Attention'.tr,
                          style: TextStyle(
                            fontFamily: FontFamily.vazirBold,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Attention: This plugin is only to facilitate the user s calculations'.tr +
                                      "It is created and is not the basis of decision for the user. The user is responsible for controlling the correctness of the calculations,".tr +
                                      "and the Taj Coin application is responsible for this They don t have".tr ,
                                  style: TextStyle(color: Get.theme.disabledColor, fontFamily: FontFamily.vazirBold, fontSize: 14)),
                            ],
                          ),
                        ).marginOnly(top: 18),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Attention: The profit and loss calculated by the system does not include site fees.'.tr,
                                  style: TextStyle(color: Get.theme.disabledColor, fontFamily: FontFamily.vazirBold, fontSize: 14)),
                            ],
                          ),
                        ).marginOnly(top: 18),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Obx(() {
                                return Checkbox(
                                  value: controller.isAcceptPortFolio.value,
                                  onChanged: (newValue) {
                                    controller.setIsAcceptPortFolio();
                                  },
                                );
                              }),
                              Text(
                                'Do not show this window again'.tr,
                                style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.portfolioIsTrue(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 16),
                            width: MediaQuery.of(context).size.width - 100,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                                  Color(0xFF0C9AA4),
                                  Color(0xFF13E585),
                                ])),
                            child: Center(
                              child: Text(
                                'Close'.tr,
                                style: TextStyle(fontFamily: FontFamily.vazirBold, fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
