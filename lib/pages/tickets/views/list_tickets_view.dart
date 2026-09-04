import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/tickets_controller.dart';
import '../widget/ticket_item_list_ticket.dart';
import '../widget/ticket_item_shimmer_list_ticket.dart';

class ListTicketsView extends GetView<TicketsController> {
  final bool hideAppBar;

  ListTicketsView({this.hideAppBar = false}) {
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
              child: Obx(() {
                return !controller.isSearching.value
                    ? controller.ticketList.length > 0
                        ? ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            itemCount: controller.ticketList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == controller.ticketList.length) {
                                return Obx(() {
                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Opacity(
                                        opacity: controller.isLoading.value ? 1 : 0,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  );
                                });
                              } else {
                                return TicketItemListTicket(controller.ticketList[index]);
                              }
                            },
                          )
                        : Container(
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Nothing found".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.vazirBold,
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ).marginOnly(bottom: 16),
                          InkWell(
                            onTap: () => controller.refreshList(),
                            child: Icon(
                              Icons.refresh,
                              size: 32,
                            ),
                          )
                        ],
                      )),
                )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return TicketItemShimmerListTicket();
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
