
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/bankCardController.dart';
import '../widget/bank_card_item_list_ticket.dart';
import '../widget/bank_card_item_shimmer_list_ticket.dart';

class ListBankCardView extends GetView<BankCardController> {
  final bool hideAppBar;

  ListBankCardView({this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }

  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    controller.profileForm = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Container(
        child: Column(
          children: <Widget>[
            Divider(
              height: 0.5,
              color: Get.theme.dividerColor.withOpacity(0.4),
            ),
            Flexible(
              //cardListDone.value
              child: Obx(() {
                return controller.cardListDone.value
                    ? controller.cardsList.length > 0
                        ? Container(
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: controller.cardsList.length,
                              itemBuilder: (context, index) {
                                return BankCardItemListTicket(controller.cardsList[index]);
                              },
                            ),
                          )
                        : Container(
                            child: Center(
                              child: Text(
                                'The list of cards is empty'.tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                    : ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return BankCardItemShimmerListTicket();
                        },
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}
