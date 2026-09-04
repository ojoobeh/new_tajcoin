import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webazin/pages/settings/views/botton_sheet_select_language_widget.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../routes/app_routes.dart';
import '../../../services/them_service.dart';
import '../../../utils/assets.dart';
import '../../../utils/config_app.dart';
import 'package:webazin/utils/utils.dart';
import '../../../utils/getMultipart.dart';
import '../controllers/settings_controller.dart';
import '../widget/item_setting_auth_widget.dart';
import '../widget/item_setting_widget.dart';
import '../widget/item_setting_widget2.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Setting".tr,
          style: TextStyle(
            fontFamily: FontFamily.vazirLight,
            color: context.theme.dividerColor.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: context.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Obx(() {
                return Container(
                  child: controller.user.value.apiToken != null
                      ? Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: CircleAvatar(
                                        child: ClipOval(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              left: 4,
                                              right: 4,
                                              top: 8,
                                            ),
                                            child: SvgPicture.asset(
                                              Assets.profile,
                                              color: context.theme.dividerColor.withOpacity(0.7),
                                              width: 64,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        backgroundColor: Colors.red,
                                        radius: 30,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width - 130,
                                      margin: const EdgeInsets.only(left: 16, right: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                controller.user.value.name ?? "",
                                                style: TextStyle(fontFamily: FontFamily.vazirLight, color: context.theme.dividerColor.withOpacity(0.9), fontSize: 14),
                                              ).marginOnly(bottom: 8),
                                              Row(
                                                children: <Widget>[
                                                  // SvgPicture.asset(
                                                  //   Assets.lightTheme,
                                                  //   width: 16,
                                                  //   color: context.theme.dividerColor,
                                                  // ),
                                                  // Container(
                                                  //   child: Transform.scale(
                                                  //     scale: 1.1,
                                                  //     child: Switch(
                                                  //       // onChanged: (value) => controller.setIsSwitched(value),
                                                  //       value: ThemeService().theme == ThemeMode.dark ,
                                                  //       activeColor: Colors.grey.shade600,
                                                  //       activeTrackColor: Colors.grey.shade200,
                                                  //       inactiveThumbColor: Colors.redAccent,
                                                  //       inactiveTrackColor: Colors.orange,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  InkWell(
                                                    child: Container(
                                                      width: 70,
                                                      padding: EdgeInsets.symmetric(vertical: 4),
                                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                                      child: Center(
                                                        child: Text(
                                                          ThemeService().theme == ThemeMode.dark ? 'Dark theme'.tr : "Light theme".tr,
                                                          style: TextStyle(
                                                            color: context.theme.dividerColor,
                                                            fontFamily: FontFamily.vazirLight,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: ThemeService().switchTheme,
                                                  ).marginOnly(right: 8),
                                                  InkWell(
                                                    onTap: ThemeService().switchTheme,
                                                    child: SvgPicture.asset(
                                                      ThemeService().theme == ThemeMode.dark ? Assets.darkTheme : Assets.lightTheme,
                                                      width: 14,
                                                      color: context.theme.dividerColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            getSecurityEmail(controller.user.value.email!),
                                            style: TextStyle(fontFamily: FontFamily.vazirLight, color: context.theme.dividerColor.withOpacity(0.9), fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("ID: " + controller.user.value.id!.toString()),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Image.network(controller.user.value.levelImage!),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                height: 12,
                                color: context.theme.colorScheme.secondary,
                              )
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  child: ClipOval(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: 4,
                                        right: 4,
                                        top: 8,
                                      ),
                                      child: SvgPicture.asset(
                                        Assets.profile,
                                        color: context.theme.dividerColor.withOpacity(0.7),
                                        width: 64,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                  radius: 30,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Log in/Sign Up'.tr,
                                      style: TextStyle(fontFamily: FontFamily.vazirLight, color: context.theme.dividerColor.withOpacity(0.9), fontSize: 18),
                                    ).marginOnly(bottom: 8),
                                    Text(
                                      'Click to login and enjoy more functions'.tr,
                                      style: TextStyle(fontFamily: FontFamily.vazirLight, color: context.theme.dividerColor.withOpacity(0.9), fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              }).marginSymmetric(vertical: 8),
              ItemSettingAuthWidget(
                title: "Authentication".tr,
                iconData: Assets.profile,
                onTop: () {
                  if (controller.user.value.setting!.docStatus == "accept") {
                    toast("You are already authenticated".tr);
                  } else {
                    Get.toNamed(Routes.AUTHENTICATION);
                  }
                },
              ),
              ItemSettingWidget(
                title: "Bank Cards".tr,
                iconData: Assets.svBankCard,
                onTop: () {
                  return Get.toNamed(Routes.BANKCARD);
                },
              ),
              ConfigApp.vip
                  ? ItemSettingWidget2(
                      title: "Vip".tr,
                      iconData: Assets.svVip,
                      onTop: () {
                        return Get.toNamed(Routes.VIPPACKS);
                      },
                    )
                  : Container(),
              ItemSettingWidget(
                title: "Support".tr,
                iconData: Assets.svSupport,
                onTop: () {
                  Get.toNamed(Routes.TicketS);
                },
              ),
              ItemSettingWidget(
                title: "Popular question".tr,
                iconData: Assets.questions,
                onTop: () {
                  Get.toNamed(Routes.PAGES, arguments: "ask");
                },
              ),
              ItemSettingWidget(
                title: "About us".tr,
                iconData: Assets.info,
                onTop: () {
                  Get.toNamed(Routes.PAGES, arguments: "about");
                  ////
                },
              ),
              ItemSettingWidget(
                title: "Terms and Conditions".tr,
                iconData: Assets.termsAndConditions,
                onTop: () {
                  Get.toNamed(Routes.PAGES, arguments: "terms");
                  ////
                },
              ),
              ItemSettingWidget(
                title: "Contact us".tr,
                iconData: Assets.contactUs,
                onTop: () {
                  Get.toNamed(Routes.PAGESCUNTACTUS, arguments: "contact");
                },
              ),
              ItemSettingWidget(
                title: "Change language".tr,
                iconData: Assets.language,
                onTop: () {

                  Get.bottomSheet(
                    BottomSheetSelectLanguageWidget(
                    ),
                  );
                  //
                  // String language = getData('language') ?? 'fa';
                  // if (language == 'fa') {
                  //   updateLocale(Locale('en'));
                  //   setData('language', 'en');
                  // } else {
                  //   updateLocale(Locale('fa'));
                  //   setData('language', 'fa');
                  // }
                  // controller.update();
                },
              ),
              ItemSettingWidget(
                title: "Change password".tr,
                iconData: Assets.password_1,
                onTop: () {
                  Get.toNamed(Routes.AuthenticationPasswordView);
                },
              ),
              ItemSettingWidget(
                title: "Log out".tr,
                iconData: Assets.logOut,
                onTop: () async {
                  debugPrint('Login Repeat>>>> 5');
                  setData(Core.userLogin, false);
                  await Get.offNamedUntil(
                    Routes.LOGIN,
                    (Route route) {
                      if (route.settings.name == Routes.LOGIN) {
                        return true;
                      }
                      return false;
                    },
                  );
                },
              ),
              Core.canCheckBiometric
                  ? Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                Assets.fingerprint,
                                width: 22,
                                color: context.theme.dividerColor.withOpacity(0.7),
                              ).marginSymmetric(
                                horizontal: 14,
                              ),
                              Center(
                                child: Text(
                                  'Fingerprint login'.tr,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: FontFamily.vazirMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() {
                            return Container(
                              child: Transform.scale(
                                scale: 1.1,
                                child: Switch(
                                  onChanged: (value) => controller.setIsFingerPrintAvailable(value),
                                  value: controller.isFingerPrintAvailable.value,
                                  activeColor: Colors.grey.shade600,
                                  activeTrackColor: Colors.redAccent,
                                  inactiveThumbColor: Colors.grey.shade200,
                                  inactiveTrackColor: Colors.grey,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    )
                  : Container(),
              Divider(
                height: 1,
                color: context.theme.dividerColor.withOpacity(0.4),
                endIndent: 16,
                indent: 16,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Application version".tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.vazirMedium,
                      ),
                    ),
                    Text(
                      Core.VERSIONNAME,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.vazirMedium,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
