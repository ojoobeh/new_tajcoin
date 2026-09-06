import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../controllers/assets_controller.dart';
import 'assets_list_item_widget.dart';

class ListAssetsWidget extends GetWidget<AssetsController> {
  final int limit;

  ListAssetsWidget({this.limit= 0});

  @override
  Widget build(final BuildContext context) {
    bool isShowHelper = getBool('${Core.helperAsset}');
    if (!isShowHelper) {
      controller.showTutorial(context);
    }
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Obx(() {
          return ListView.builder(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: (controller.assets.length) + 1,
              controller: controller.scrollController,
              itemBuilder: (_, index) {
                if (index == controller.assets.length) {
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
                  return  AssetsListItemWidget(index);
                }
              });
        }),
      ),
    );
  }
}
