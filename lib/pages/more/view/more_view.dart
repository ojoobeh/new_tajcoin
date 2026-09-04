import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../../../utils/config_app.dart';
import 'package:webazin/utils/utils.dart';
import '../../../utils/getMultipart.dart';
import '../../default/controller/default_controller.dart';
import '../widget/custom_button_more.dart';

class MoreView extends GetView<DefaultController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Container(
        child: Container(
          height: Get.height - 33,
          margin: const EdgeInsets.only(top: 32),
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Available".tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Recommend",
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      CustomButtonMore(
                        title: "Security".tr,
                        iconData: Assets.twoStepLogin,
                        onTap: () {
                          Get.toNamed(Routes.SETTINGSMS);
                        },
                      ),
                      ConfigApp.referrals
                          ? CustomButtonMore(
                              title: "Subset".tr,
                              iconData: Assets.subset,
                              onTap: () {
                                Get.toNamed(Routes.AFFILIATE);
                              },
                            )
                          : Container(),
                      ConfigApp.accreditation
                          ? CustomButtonMore(
                              title: "loan".tr,
                              iconData: Assets.accreditation,
                              onTap: () {
                                Get.toNamed(Routes.PAGESMORE, arguments: ['accreditation', 'loan'.tr]);
                              },
                            )
                          : Container(),
                      CustomButtonMore(
                        title: "History".tr,
                        iconData: Assets.history,
                        onTap: () {
                          Get.toNamed(Routes.HISTORY);
                        },
                      ),
                      CustomButtonMore(
                        title: "Support".tr,
                        iconData: Assets.support,
                        onTap: () {
                          Get.toNamed(Routes.TicketS);
                        },
                      ),
                      ConfigApp.vip
                          ? CustomButtonMore(
                              title: "signal".tr,
                              iconData: Assets.vip,
                              onTap: () {
                                if (Core.user.vip!.active!) {
                                  Get.toNamed(Routes.PAGESMORE, arguments: ['vip', 'signal'.tr]);
                                } else {
                                  snackbarOrange(title: ''.tr, subtitle: "Please subscribe first".tr);
                                  Get.toNamed(Routes.VIPPACKS);
                                }
                              },
                            )
                          : Container(
                              width: 1,
                            ),
                      CustomButtonMore(
                        title: "Cooperation".tr,
                        iconData: Assets.cooperation,
                        onTap: () {
                          Get.toNamed(Routes.PAGES, arguments: "Cooperation".tr);
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  height: 5,
                  color: Get.theme.colorScheme.secondary,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "New".tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      // ConfigApp.accreditation
                      //     ? CustomButtonMore(
                      //         title: "Accreditation".tr,
                      //         iconData: Assets.accreditation,
                      //         onTap: () {
                      //           Get.toNamed(Routes.PAGESMORE, arguments: ['accreditation', 'Accreditation'.tr]);
                      //         },
                      //       )
                      //     : Container(
                      //         width: 1,
                      //       ),
                      ConfigApp.discount
                          ? CustomButtonMore(
                              title: "Discounts".tr,
                              iconData: Assets.discount,
                              onTap: () {
                                Get.toNamed(Routes.PAGESMORE, arguments: ['discount', 'Discounts'.tr]);
                              },
                            )
                          : Container(
                              width: 1,
                            ),
                      ConfigApp.reward
                          ? CustomButtonMore(
                              title: "Reward".tr,
                              iconData: Assets.reward,
                              onTap: () {
                                Get.toNamed(Routes.PAGESMORE, arguments: ['reward', 'Reward'.tr]);
                              },
                            )
                          : Container(
                              width: 1,
                            ),
                      CustomButtonMore(
                        title: "Pay gateway".tr,
                        iconData: Assets.payment,
                        onTap: () async {
                          await launch("https://Tajpay.org");
                        },
                      ),
                      CustomButtonMore(
                        title: "meta".tr,
                        iconData: Assets.metavers,
                        onTap: () {
                          Get.toNamed(Routes.PAGESMORE, arguments: ['metaverse', 'meta'.tr]);
                        },
                      ),
                      CustomButtonMore(
                        title: "AirDrop".tr,
                        iconData: Assets.airdrop,
                        onTap: () {
                          Get.toNamed(Routes.PAGESMORE, arguments: ['airdrop', 'AirDrop'.tr]);
                        },
                      ),
                      CustomButtonMore(
                        title: "Analysis".tr,
                        iconData: Assets.tahlil,
                        onTap: () {
                          Get.toNamed(Routes.PAGESMORE, arguments: ['analysis', 'Analysis'.tr]);
                        },
                      ),
                      CustomButtonMore(
                        title: "Api",
                        iconData: Assets.api,
                        onTap: () {
                          toast('Send a ticket to support to get the API'.tr);
                        },
                      ),
                      ConfigApp.calculator
                          ? CustomButtonMore(
                              title: "Calculator".tr,
                              iconData: Assets.calculator,
                              onTap: () {
                                Get.toNamed(Routes.CALCULATOR);
                              },
                            )
                          : Container(
                              width: 1,
                            ),

                      CustomButtonMore(
                        title: "Weblog".tr,
                        iconData: Assets.weblog,
                        onTap: () {
                          launch('https://Cryptopersian.com');
                        },
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  height: 5,
                  color: Get.theme.colorScheme.secondary,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Coming Soon...".tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      CustomButtonMore(
                        title: "Virtual".tr,
                        iconData: Assets.virtual,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Contract".tr,
                        iconData: Assets.contract,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Round".tr,
                        iconData: Assets.roundOfLuck,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Store".tr,
                        iconData: Assets.shopping,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Ticket".tr,
                        iconData: Assets.ticket,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Stake".tr,
                        iconData: Assets.deposit,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "NFT".tr,
                        iconData: Assets.nft,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Extraction".tr,
                        iconData: Assets.existing,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Caht".tr,
                        iconData: Assets.chat,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "ETH_2.0".tr,
                        iconData: Assets.eth2,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Lvg trade".tr,
                        iconData: Assets.traidAhrom,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Insurance".tr,
                        iconData: Assets.bimeh,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "robot".tr,
                        iconData: Assets.robot,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Gift card".tr,
                        iconData: Assets.giftCard,
                        onTap: () {},
                      ),

                      CustomButtonMore(
                        title: "Price alert".tr,
                        iconData: Assets.alarmPrice,
                        onTap: () {},
                      ),
                      CustomButtonMore(
                        title: "Market".tr,
                        iconData: Assets.market,
                        onTap: () {},
                      ),
                      // !ConfigApp.calculator
                      //     ? CustomButtonMore(
                      //         title: "Calculator".tr,
                      //         iconData: Assets.calculator,
                      //         onTap: () {},
                      //       )
                      //     : Container(
                      //         width: 1,
                      //       ),
                      //
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
