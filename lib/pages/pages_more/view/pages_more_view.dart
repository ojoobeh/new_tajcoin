import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../controller/pages_more_controller.dart';
import '../widget/item_pages_more_list.dart';
import '../widget/item_pages_more_shimmer_list.dart';

class PagesMoreView extends GetView<PagesMoreController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          controller.title,
          style: TextStyle(
            fontFamily: FontFamily.vazirBold,
            color: Get.theme.dividerColor.withOpacity(0.8),
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Get.theme.dividerColor),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            )),

        child: Obx(() {
          return Container(
            child: !controller.isSearching.value
                ? controller.list.length > 0
                    ? ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: controller.list.length + 1,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) {
                          if (index == controller.list.length) {
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
                            return ItemPagesMoreList(controller.list[index], index);
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
                              onTap: () => controller.refreshHome(),
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
                      return ItemPagesMoreShimmerList();
                    },
                  ),
          );
        }),

        // child: Obx(() {
        //   return controller.list.length > 0
        //       ? ListView.builder(
        //           primary: false,
        //           shrinkWrap: true,
        //           itemCount: controller.list.length + 1,
        //           controller: controller.scrollController,
        //           itemBuilder: (context, index) {
        //             return ItemmetaList(controller.list[index], index);
        //           },
        //         )
        //       : Container();
        // }),
      ),
    );
  }
}
