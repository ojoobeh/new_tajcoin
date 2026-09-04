import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webazin/webazin/data/models/vip/call_vip_packs.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../utils/core.dart';
import 'package:webazin/utils/utils.dart';
import '../controller/vip_packs_controller.dart';

class ItemPacksList extends GetView<VipPacksController> {
  DataVipPacks dataVipPacks;
  int index;

  ItemPacksList(this.dataVipPacks, this.index);

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () => controller.getPackage(context, dataVipPacks),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
          decoration: BoxDecoration(
            color: Get.theme.dividerColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),

          ),
          child: Column(
            children: <Widget>[

              CachedNetworkImage(
                imageUrl: Core.laravelBaseUrl + dataVipPacks.image!,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Get.theme.cardColor,
                  highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              // Image.network(
              //   Core.laravelBaseUrl + dataVipPacks.image!,
              //   width: double.infinity,
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "credit:".tr + dataVipPacks.days.toString() + " days ".tr,
                      style: TextStyle(
                        fontFamily: FontFamily.vazirBold,
                        color: Get.theme.dividerColor,
                      ),
                    ),
                    Text(
                      "Price: ".tr + getPrice(dataVipPacks.price!) + " Irt ".tr,
                      style: TextStyle(
                        fontFamily: FontFamily.vazirBold,
                        color: Get.theme.dividerColor,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Text(
                  dataVipPacks.description!,
                  style: TextStyle(
                    fontFamily: FontFamily.vazirBold,
                    color: Get.theme.dividerColor,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
