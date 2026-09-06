import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/widgets/image.dart';

import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';
import '../../../utils/getMultipart.dart';
import '../controllers/authentication_controller.dart';
import '../widget/auth_custom_mobile_text_field_widget.dart';
import '../widget/auth_custom_text_field_widget.dart';
import '../widget/authentication_botton_sheet_pick_image.dart';
import '../widget/birthday_widget.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  final bool hideAppBar;

  AuthenticationView({this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }

  @override
  Widget build(final BuildContext context) {
    if (!controller.isFataShow.value) {
      Future.delayed(Duration.zero, () => sendMessage(context));
      controller.isFataShow.value = true;
    }
    controller.profileForm = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () async {
        controller.user.value = DataUser();
        return true;
      },
      child: Scaffold(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          appBar: hideAppBar
              ? null
              : AppBar(
                  title: Text(
                    "Authentication".tr,
                    style: context.textTheme.bodySmall,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                    onPressed: () => Get.back(),
                  ),
                  elevation: 0,
                ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      !Core.user.setting!.status! ? controller.saveProfileForm() : null;
                    },
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    // ignore: deprecated_member_use
                    color: Core.user.setting!.status! ? context.theme.canvasColor//todo_buttonColor

                        : AppColors.orangeColor,
                    child: Core.user.setting!.status!
                        ? Text("You are already authenticated".tr, style: Get.textTheme.labelLarge!.merge(TextStyle(color: Get.theme.dividerColor)))
                        : Text("Submit".tr, style: Get.textTheme.labelLarge!.merge(TextStyle(color: Get.theme.primaryColor))),
                    elevation: 0,
                  ),
                ),
                // SizedBox(width: 10),
                // MaterialButton(
                //   onPressed: () {
                //     controller.resetProfileForm();
                //   },
                //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)),
                //   color: Get.theme.hintColor.withOpacity(0.1),
                //   child: Text("Reset".tr, style: Get.textTheme.labelLarge),
                //   elevation: 0,
                // ),
              ],
            ).paddingSymmetric(vertical: 10, horizontal: 20),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AuthCustomTextMobileFieldWidget(
                    onTap: () {
                      if (controller.mobileCodeController.text.length == 11) {
                        controller.verifyMobile(context);
                      } else {
                        toast("Mobile number is wrong".tr);
                      }
                    },
                    textEditingController: controller.mobileCodeController,
                    validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                    labelText: "Mobile".tr,
                  ),
                  AuthCustomTextFieldWidget(
                    textEditingController: controller.nameController,
                    textAlign: TextAlign.start,
                    validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                    hintText: "Name".tr,
                    labelText: "Name".tr,
                  ),
                  BirthdayWidget(),
                  AuthCustomTextFieldWidget(
                    textEditingController: controller.nationalCodeController,
                    keyboardType: TextInputType.number,
                    validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                    hintText: "National Code".tr,
                    labelText: "National Code".tr,
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        AuthenticationBottomSheetPickImage(),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: Get.theme.dividerColor.withOpacity(0.7),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Obx(() {
                              return controller.imageAuthentication.value == ''
                                  ? controller.networkImageAuthentication.value != ''
                                      ? image(
                                          controller.networkImageAuthentication.value,
                                          width: double.infinity,
                                          height: 200,
                                        )
                                      : Image.network(
                                          Core.applicationInfo.authImg ?? '',
                                          width: double.infinity,
                                          height: 200,
                                        )
                                  : Image.file(
                                      File(controller.imageAuthentication.value),
                                      height: 280,
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width / 3,
                                    );
                            }),
                            Obx(() {
                              return controller.imageAuthentication == ''
                                  ? Text(
                                      'Click on the image'.tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: FontFamily.vazirLight,
                                        color: Get.theme.dividerColor,
                                      ),
                                    ).marginOnly(top: 16)
                                  : Container();
                            })
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
                  onWillPop: () async => false,
                  child: Container(
                    height: 600,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Get.theme.scaffoldBackgroundColor),
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
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
                                TextSpan(text: 'Fata body2'.tr, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                                TextSpan(text: 'Fata body3'.tr, style: TextStyle(color: Get.theme.disabledColor, fontWeight: FontWeight.bold, fontSize: 12)),
                                TextSpan(text: 'Fata body4'.tr, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
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
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Obx(() {
                                  return Checkbox(
                                    value: controller.isAcceptFata.value,
                                    onChanged: (newValue) {
                                      controller.setIsAcceptFata();
                                    },
                                  );
                                }),
                                Text(
                                  "I read it and l accept it".tr,
                                  style: context.textTheme.titleSmall,
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.fataIsTrue(context);
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
