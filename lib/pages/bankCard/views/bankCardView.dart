import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bankCardController.dart';
import 'list_bank_card_view.dart';
import 'send_bank_card_view.dart';


class BankCardView extends GetView<BankCardController> {
  final bool hideAppBar;

  BankCardView({this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }

  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bank Cards".tr,
            style: TextStyle(color: context.theme.dividerColor),
          ),
          centerTitle: true,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          elevation: 10,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Get.theme.dividerColor),
            onPressed: () => {Get.back()},
          ),
          bottom: TabBar(
            controller: controller.controller,
            tabs: [
              Tab(
                child: Text(
                  'Insert card'.tr,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Tab(
                child: Text(
                  'List of cards'.tr,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
            controller: controller.controller,
          children: <Widget>[
            SendBankCardView(),
            ListBankCardView(),
          ],
        ),
      ),
    );
  }
}
