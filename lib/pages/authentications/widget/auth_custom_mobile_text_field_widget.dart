import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../utils/ui.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/authentication_controller.dart';

class AuthCustomTextMobileFieldWidget extends GetView<AuthenticationController> {
  final String? labelText;
  final TextEditingController? textEditingController;
  final double? width;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;


  const AuthCustomTextMobileFieldWidget({
    this.labelText,
    this.textAlign,
    this.validator,
    this.textEditingController,
    this.onTap,
    this.width,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: width == 0 ? double.infinity : width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            labelText!,
            style: TextStyle(
              fontFamily: FontFamily.vazirLight,
              fontSize: 12,
              color: Get.theme.dividerColor.withOpacity(0.8),
            ),
          ).marginOnly(bottom: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Get.theme.dividerColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Obx(() {

                      return TextFormField(
                        maxLines: 1,
                        key: key,
                        keyboardType: TextInputType.number,
                        controller: textEditingController,
                        validator: validator,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirLight,
                          fontSize: 14,
                          color: Get.theme.dividerColor,
                        ),
                        obscureText: false,
                        textAlign:  TextAlign.end,
                        decoration: Ui.getInputDecoration(
                          hintText: controller.user.value.mobile??'' ,
                        ),
                      );
                    }),
                  ),
                ),
                Obx(() {
                  return controller.user.value.setting != null && controller.user.value.setting!.mobileStatus == null
                      ? InkWell(
                    onTap: onTap,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.green,
                      ),
                      child: Center(
                        child: controller.isLoadingPhone.value ?
                        SpinKitWave(color: Get.theme.dividerColor, size: 12,
                            type: SpinKitWaveType.center) : Text("Confirm".tr),
                      ),
                    ),
                  )
                      : Container();
                })
              ],
            ),
          ).marginOnly(bottom: 8),
        ],
      ),
    );
  }
}
