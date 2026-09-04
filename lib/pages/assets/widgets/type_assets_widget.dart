import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utilities.dart';

import '../controllers/assets_controller.dart';

class TypeAssetsWidget extends StatelessWidget {
  final DataWallet dataAssets;

  const TypeAssetsWidget(this.dataAssets);

  @override
  Widget build(final BuildContext context) {
    AssetsController controller = Get.find<AssetsController>();
    return Container(
      width: Get.width,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        height: 60,

        child: Wrap(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 80,
              height: 25,
              child: InkWell(
                onTap: () => controller.updateTypeIndex(0),
                child: Container(
                  width: 80,
                  height: 25,
                  decoration: BoxDecoration(
                      color: controller.selectTypeIndex.value == 0 ? Colors.blueGrey.withOpacity(0.9) : Colors.blueGrey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.blueGrey,
                      )),
                  child: Center(
                    child: Text(
                      "Direct".tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color:  controller.selectTypeIndex.value == 0 ? context.theme.scaffoldBackgroundColor.withOpacity(0.9): context.theme.dividerColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => controller.updateTypeIndex(1),
              child: Container(
                width: 80,
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 25,
                decoration: BoxDecoration(
                  color: controller.selectTypeIndex.value == 1 ? Colors.blueGrey.withOpacity(0.9) : Colors.blueGrey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    "Internal".tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: controller.selectTypeIndex.value == 1 ? context.theme.scaffoldBackgroundColor.withOpacity(0.9) : context.theme.dividerColor.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // child: ListView.builder(
        //   primary: false,
        //   shrinkWrap: true,
        //   scrollDirection: Axis.horizontal,
        //   itemCount: 2,
        //   itemBuilder: (context, index) {
        //     return Obx(() {
        //       return Container(
        //         child: Row(
        //           children: <Widget>[
        //             Radio(
        //               value: index,
        //               groupValue: controller.selectTypeIndex.value,
        //               onChanged: (value) =>
        //                   controller.updateTypeIndex(index),
        //             ),
        //             Text(controller.typeList[index]),
        //           ],
        //         ),
        //       );
        //     });
        //   },
        // ),
      ),
    );
  }
}

/*
 itemCount: controller
              .currencies[controller.indexSelect.value].networks.length,
          itemBuilder: (context, index) {
            Text(controller.currencies[controller.indexSelect.value]
                .networks[index].name);
                */
