import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utilities.dart';

import '../controllers/assets_controller.dart';

class NetWorksAssetsWidget extends StatelessWidget {
  final DataWallet dataAssets;

  const NetWorksAssetsWidget(this.dataAssets);

  @override
  Widget build(final BuildContext context) {
    AssetsController controller = Get.find<AssetsController>();
    return Container(
      width: Get.width,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        height: 60,
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: dataAssets.currency!.networks!.length,
          itemBuilder: (context, index) {
            return Obx(() {
              return Container(
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: index,
                      groupValue: controller.selectNetworksIndex.value,
                      onChanged: (value) =>
                          controller.updateNetworkIndex(index),
                    ),
                    Text(dataAssets.currency!.networks![index].network!),
                  ],
                ),
              );
            });
          },
        ),
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
