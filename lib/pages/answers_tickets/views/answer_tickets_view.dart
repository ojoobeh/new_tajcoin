import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webazin/pages/answers_tickets/controllers/answers_tickets_controller.dart';
import 'package:webazin/pages/answers_tickets/widget/answers_ticket_item_list.dart';
import 'package:webazin/pages/global_widgets/circular_loading_widget.dart';
import 'package:webazin/utils/assets.dart';
import 'package:webazin/utils/utils.dart';

class AnswerTicketsView extends GetView<AnswersTicketsController> {
  AnswerTicketsView({super.key, this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }

  final bool hideAppBar;

  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: AppColors.orangeColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: Get.back,
                      child: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 32),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              'Ticket title: '.tr,
                              style: TextStyle(
                                fontFamily: FontFamily.vazirBold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              controller.dataTicket.value.subject!,
                              style: TextStyle(fontFamily: FontFamily.vazirMedium, fontSize: 14),
                            ),
                          ],
                        ),
                        Divider(height: 1).marginSymmetric(vertical: 4),
                        Container(
                          constraints: BoxConstraints(maxHeight: 120),
                          child: SingleChildScrollView(
                            child: Text(
                              controller.dataTicket.value.message!,
                              maxLines: 8,
                              softWrap: true,
                              style: TextStyle(
                                fontFamily: FontFamily.vazirLight,

                                fontSize: 12,
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
          ),
          Flexible(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 80,
              child: Obx(() => controller.answersList.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height - 110,
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: controller.answersList.length,
                        itemBuilder: (final BuildContext context, final int index) => AnswersTicketItemList(controller.answersList[index]),
                      ),
                    )
                  : Container()),
            ),
          ),
          SizedBox(
            height: 80,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Container(
                        height: 44,
                        width: 44,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.green.shade200, boxShadow: <BoxShadow>[
                          BoxShadow(color: Get.theme.dividerColor.withOpacity(0.3), blurRadius: 40, offset: const Offset(0, 15)),
                          BoxShadow(color: Get.theme.dividerColor.withOpacity(0.6), blurRadius: 13, offset: const Offset(0, 3))
                        ]),
                        child: Obx(() => controller.loadingSend.value
                            ? Center(child: CircularLoadingWidget(height: 30))
                            : SvgPicture.asset(
                                Assets.send1,
                                width: 22,
                              ))),
                    onTap: () => controller.loadingSend.value ? null : controller.sendTicket(),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Get.theme.dividerColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Get.theme.dividerColor.withOpacity(0.8), width: 0.5),
                      ),
                      child: TextFormField(
                        key: key,
                        focusNode: controller.focusNodeMessage,
                        controller: controller.teMessage,
                        keyboardType: TextInputType.multiline,
                        onChanged: (final String value) => controller.message = value,
                        style: TextStyle(fontFamily: FontFamily.vazirBold, fontSize: 15, color: Get.theme.dividerColor),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                            hintText: ''),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
