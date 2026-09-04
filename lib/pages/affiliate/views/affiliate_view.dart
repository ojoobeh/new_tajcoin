import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webazin/pages/affiliate/controllers/affiliate_controller.dart';
import 'package:webazin/pages/affiliate/widget/list_affiliate_widget.dart';
import 'package:webazin/pages/global_widgets/circular_loading_widget.dart';
import 'package:webazin/utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/utils/ui.dart';

class AffiliateView extends GetView<AffiliateController> {

  AffiliateView({super.key, this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }
  final bool hideAppBar;

  @override
  Widget build(final BuildContext context) => Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              appBar: hideAppBar
                  ? null
                  : AppBar(
                      title: Text(
                        "Affiliate".tr,
                        style: context.textTheme.bodySmall,
                      ),
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                        onPressed: Get.back,
                      ),
                      elevation: 0,
                    ),
              body: Obx(() => controller.dataAffiliate.value.referrals != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: Get.theme.dividerColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width / 2) - 50,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                Assets.referrals,
                                                width: 36,
                                                height: 36,
                                              ),
                                              Text(
                                                'subset'.tr,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: FontFamily.vazirLight,
                                                  color: Get.theme.dividerColor,
                                                ),
                                              ).marginOnly(top: 8),
                                              Text(controller.dataAffiliate.value.referrals!.length.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: FontFamily.vazirLight,
                                                    color: Get.theme.dividerColor,
                                                  )).marginOnly(top: 8),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width / 2) - 50,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                Assets.referrals_count,
                                                width: 36,
                                                height: 36,
                                              ),
                                              Text('Total order'.tr,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: FontFamily.vazirLight,
                                                    color: Get.theme.dividerColor,
                                                  )).marginOnly(top: 8),
                                              Text(controller.dataAffiliate.value.referralsCount.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: FontFamily.vazirLight,
                                                    color: Get.theme.dividerColor,
                                                  )).marginOnly(top: 8),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width / 2) - 50,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                Assets.referrals_flag,
                                                width: 32,
                                                height: 32,
                                              ),
                                              Text('Total commission'.tr,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: FontFamily.vazirLight,
                                                    color: Get.theme.dividerColor,
                                                  )).marginOnly(top: 8),
                                              Text(controller.dataAffiliate.value.commissions.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: FontFamily.vazirLight,
                                                    color: Get.theme.dividerColor,
                                                  )).marginOnly(top: 8),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width / 2) - 50,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                Assets.referrals_average,
                                                width: 32,
                                                height: 32,
                                              ),
                                              Text('Average commission per order'.tr,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: FontFamily.vazirLight,
                                                    color: Get.theme.dividerColor,
                                                  )).marginOnly(top: 8),
                                              Text(controller.dataAffiliate.value.commissionsAverage.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: FontFamily.vazirLight,
                                                    color: Get.theme.dividerColor,
                                                  )).marginOnly(top: 8),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Get.theme.dividerColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  child: Text('refCode'.tr),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        controller.dataAffiliate.value.code.toString(),
                                        style: TextStyle(color: Get.theme.dividerColor.withOpacity(0.7), fontSize: 14),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(text: controller.dataAffiliate.value.code.toString()));
                                          Get.showSnackbar(Ui.SuccessSnackBar(message: "Copy Successfully".tr));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              Assets.copy,
                                              width: 16,
                                              height: 16,
                                              color: Get.theme.dividerColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Get.theme.dividerColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    child:  Text('Table of purchases of friends introduced by you'.tr),
                                  ),
                                  Container(
                                    height: 30,
                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                )),
                                            child: Center(
                                                child: Text(
                                              '#',
                                              style: TextStyle(fontSize: 8, fontFamily: FontFamily.vazirLight),
                                            )),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 5,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                                left: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                                bottom: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'User'.tr,
                                              style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirLight),
                                            )),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 5,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                                bottom: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Commission'.tr,
                                              style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirLight),
                                            )),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                )),
                                            child: Center(
                                                child: Text(
                                              'Date'.tr,
                                              style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirLight),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const ListAffiliateWidget(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container())),
          Obx(() => controller.isLoading.value
              ? Container(
                  color: Colors.black87.withOpacity(0.5),
                  child: Center(
                    child: CircularLoadingWidget(
                      height: 300,
                    ),
                  ),
                )
              : Container()),
        ],
      );

  void sendMessage(final BuildContext context)  {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.8),
        transitionBuilder: (  final BuildContext context,  final Animation<double> a1,  final Animation<double> a2,  final Widget widget) => Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  content: WillPopScope(
                    onWillPop: () async => false,
                    child: Container(
                      height: 600,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Get.theme.scaffoldBackgroundColor),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            Assets.fata,
                            width: 100,
                          ),
                          Text(
                            'Fata Title'.tr,
                            style: TextStyle(
                              fontFamily: FontFamily.vazirBold,
                              fontSize: 14,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Fata body1'.tr, style: TextStyle(color: Get.theme.disabledColor, fontWeight: FontWeight.bold, fontSize: 12)),
                                TextSpan(text: 'Fata body2'.tr, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                                TextSpan(text: 'Fata body3'.tr, style: TextStyle(color: Get.theme.disabledColor, fontWeight: FontWeight.bold, fontSize: 12)),
                                TextSpan(text: 'Fata body4'.tr, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                                TextSpan(text: 'Fata body5'.tr, style: TextStyle(color: Get.theme.disabledColor, fontWeight: FontWeight.bold, fontSize: 12)),
                              ],
                            ),
                          ).marginOnly(top: 18),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Fata body6'.tr, style: TextStyle(color: Get.theme.disabledColor, fontWeight: FontWeight.bold, fontSize: 12)),
                              ],
                            ),
                          ).marginOnly(top: 8),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              width: MediaQuery.of(context).size.width - 100,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient:  const LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors:  <Color>[
                                    Color(0xFF0C9AA4),
                                    Color(0xFF13E585),
                                  ])),
                              child: Center(
                                child: Text(
                                  'Fata sign'.tr,
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
            ),
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: ( final BuildContext context,  final Animation<double> animation1,  final Animation<double> animation2) => Container());
  }
}
