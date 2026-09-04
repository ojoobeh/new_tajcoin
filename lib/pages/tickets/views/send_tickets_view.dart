import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/tickets_controller.dart';
import '../widget/spinner_order_list_widget.dart';
import '../widget/spinner_section_list_widget.dart';
import '../widget/ticket_text_form_field_2_widget.dart';

class SendTicketsView extends GetView<TicketsController> {
  final bool hideAppBar;

  SendTicketsView({this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }

  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    controller.profileForm = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body: Form(
          key: controller.profileForm,
          child:  Container(
            child: Stack(
              children: <Widget>[
                Container(
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
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ListView(
                          primary: true,
                          children: <Widget>[

                            TicketTextFormField2Widget(
                              keyboardType: TextInputType.text,
                              onChanged: (input) => controller.subjectTicket.value = input,
                              validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                              hintText: "Title".tr,
                              initialValue: '',
                              iconData: Assets.category,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SpinnerSectionListWidget(Assets.category),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SpinnerOrderListWidget(Assets.order),
                                ],
                              ),
                            ),
                            Text(
                              'Description'.tr,
                              style: TextStyle(
                                color: Get.theme.dividerColor,
                                fontSize: 14,
                                fontFamily: FontFamily.vazirBold,
                              ),
                              textAlign: TextAlign.start,
                            ).marginOnly(top: 22),
                            Container(
                              height: 200,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Get.theme.dividerColor.withOpacity(0.6), width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                maxLines: 40,
                                key: key,
                                keyboardType: TextInputType.multiline,
                                onChanged: (value) => controller.messageTicket.value = value,
                                maxLength: 500,
                                initialValue: '',
                                style: Get.textTheme.labelLarge,
                                obscureText: false,
                                textAlign: TextAlign.start,
                              ),
                            ).marginOnly(top: 16),
                            Container(
                              height: 50,
                              child: MaterialButton(
                                onPressed: () => controller.isLoading.value ? null : controller.sendTicket(),
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
                ),
              ],
            ),

            // child: ListView(
            //   primary: true,
            //   children: <Widget>[
            //     TicketsCustomTextFieldWidget(
            //       onChanged: (input) => controller.subjectTicket.value = input,
            //       validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
            //       hintText: "Topic".tr,
            //       labelText: "Topic".tr,
            //       iconData: Assets.svTopic,
            //     ),
            //     Container(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Row(
            //             children: <Widget>[
            //               SvgPicture.asset(
            //                 Assets.svSupport,
            //                 width: 20,
            //                 color: Get.theme.dividerColor.withOpacity(0.5),
            //               ).marginSymmetric(horizontal: 4),
            //               Text(
            //                 'Section'.tr,
            //                 style: TextStyle(
            //                   color: Get.theme.dividerColor,
            //                   fontSize: 12,
            //                   fontFamily: FontFamily.vazirLight,
            //                 ),
            //                 textAlign: TextAlign.start,
            //               ),
            //             ],
            //           ),
            //           SpinnerSectionListWidget(),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Row(
            //             children: <Widget>[
            //               SvgPicture.asset(
            //                 Assets.svOrder,
            //                 width: 20,
            //                 color: Get.theme.dividerColor.withOpacity(0.5),
            //               ).marginSymmetric(horizontal: 4),
            //               Text(
            //                 'Regarding the order'.tr,
            //                 style: TextStyle(
            //                   color: Get.theme.dividerColor,
            //                   fontSize: 12,
            //                   fontFamily: FontFamily.vazirLight,
            //                 ),
            //                 textAlign: TextAlign.start,
            //               ),
            //             ],
            //           ),
            //           SpinnerOrderListWidget(),
            //         ],
            //       ),
            //     ),
            //     Text(
            //       'Description'.tr,
            //       style: TextStyle(
            //         color: Get.theme.dividerColor,
            //         fontSize: 14,
            //         fontFamily: FontFamily.vazirBold,
            //       ),
            //       textAlign: TextAlign.start,
            //     ).marginOnly(top: 22),
            //     Container(
            //       height: 300,
            //       padding: EdgeInsets.all(16),
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Get.theme.dividerColor.withOpacity(0.6), width: 1),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       child: TextFormField(
            //         maxLines: 40,
            //         key: key,
            //         keyboardType: TextInputType.multiline,
            //         onChanged: (value) => controller.messageTicket.value = value,
            //         maxLength: 500,
            //         initialValue: '',
            //         style: Get.textTheme.labelLarge,
            //         obscureText: false,
            //         textAlign: TextAlign.start,
            //       ),
            //     ).marginOnly(top: 16),
            //   ],
            // ),
          ),
        ));
  }
}
