import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../controller/vip_packs_controller.dart';
import '../widget/item_packs_list.dart';
import '../widget/item_packs_shimmer_list.dart';

class VipPacksView extends GetView<VipPacksController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'VIP packages'.tr,
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
        child: Obx(() {
          return controller.isDone.value
              ? controller.packsList.length > 0
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.packsList.length,
                      itemBuilder: (context, index) {
                        return ItemPacksList(controller.packsList[index], index);
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
                            ),
                          ).marginOnly(bottom: 16),
                          InkWell(
                            onTap: () => controller.getVipPacks(),
                            child: Icon(
                              Icons.refresh,
                              size: 32,
                            ),
                          )
                        ],
                      )),
                    )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ItemPacksShimmerList();
                  },
                );

        }),
      ),
    );
  }
}
