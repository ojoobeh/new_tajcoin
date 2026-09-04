import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/history_controller.dart';
import '../widget/history_item_list_ticket.dart';
import '../widget/history_item_shimmer_list_ticket.dart';

class HistoryListView extends GetView<HistoryController> {
  final bool hideAppBar;

  HistoryListView({this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }

  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    controller.profileForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History of buying and selling".tr,
          style: TextStyle(
            color: context.theme.dividerColor,
            fontSize: 16,
            fontFamily: FontFamily.vazirBold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Get.theme.dividerColor),
          onPressed: () => {Get.back()},
        ),
      ),
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

                return Container(
                  child: !controller.isSearching.value
                      ? controller.historyList.length > 0
                      ? ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.historyList.length + 1,
                    controller: controller.scrollController,
                    itemBuilder: (context, index) {
                      if (index == controller.historyList.length) {
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
                        return HistoryItemListTicket(controller.historyList[index]);
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
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return HistoryItemShimmerListTicket();
                    },
                  ),
                );

                // return controller.historyList.length > 0
                //     ? Container(
                //         child: ListView.builder(
                //           primary: false,
                //           shrinkWrap: true,
                //           itemCount: controller.historyList.length,
                //           itemBuilder: (context, index) {
                //             return HistoryItemListTicket(controller.historyList[index]);
                //           },
                //         ),
                //       )
                //     : ListView.builder(
                //         primary: false,
                //         shrinkWrap: true,
                //         itemCount: 10,
                //         itemBuilder: (context, index) {
                //           return HistoryItemShimmerListTicket();
                //         },
                //       );
              }),
            )
          ],
        ),
      ),
    );
  }
}
