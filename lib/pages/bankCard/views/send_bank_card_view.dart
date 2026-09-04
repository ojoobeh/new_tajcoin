import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/bankCardController.dart';
import '../widget/bank_card_spinner_section_list_widget.dart';
import '../widget/bank_card_text_form_field_2_widget.dart';

class SendBankCardView extends GetView<BankCardController> {
  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    return Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body:  Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      Assets.vector,
                      height: 150,
                      width: Get.width,
                      fit: BoxFit.fill,
                    ),
                  )),
              Container(
                child: ListView(
                  primary: true,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          BankCardSpinnerSectionListWidget(Assets.bankCard),
                        ],
                      ),
                    ),
                    BankCardTextFormField2Widget(
                      keyboardType: TextInputType.number,
                      onChanged: (input) => controller.cardNumber.value = input,
                      validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                      hintText: "Card number".tr,
                      controller: controller.editingControllerCardNumber,
                      initialValue: '',
                      iconData: Assets.carNumber,
                    ),
                    BankCardTextFormField2Widget(
                      keyboardType: TextInputType.number,
                      onChanged: (input) => controller.accountNumber.value = input,
                      validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                      hintText: "Account number".tr,
                      controller: controller.editingControllerAccountNumber,
                      initialValue: '',
                      iconData: Assets.accountNumber,
                    ),
                    BankCardTextFormField2Widget(
                      keyboardType: TextInputType.number,
                      onChanged: (input) => controller.shabaNumber.value = input,
                      validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                      hintText: "Shaba number".tr,
                      controller: controller.editingControllerShabaNumber,
                      initialValue: '',
                      iconData: Assets.shabaNumber,
                    ),
                    Container(
                      height: 50,
                      child: MaterialButton(
                        onPressed: () => controller.sendCard(context),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: AppColors.orangeColor,
                        child: Text("Send".tr,
                            style: TextStyle(
                              color: Get.theme.primaryColor,
                              fontFamily: FontFamily.vazir,
                            )),
                        elevation: 0,
                      ),
                    ).paddingSymmetric(vertical: 40, horizontal: 20)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
