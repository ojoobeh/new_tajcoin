
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tickets_controller.dart';
import 'list_tickets_view.dart';
import 'send_tickets_view.dart';

class TicketsView extends GetView<TicketsController> {
  final bool hideAppBar;

  TicketsView({this.hideAppBar = false}) {
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
            "Ticket".tr,
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
                  'Send Ticket'.tr,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Tab(
                child: Text(
                  'List Tickets'.tr,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller.controller,
          children: <Widget>[
            SendTicketsView(),
            ListTicketsView(),
          ],
        ),
      ),
    );
  }
}
