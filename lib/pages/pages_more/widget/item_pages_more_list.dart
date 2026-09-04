import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:webazin/utils/utils.dart';
import '../../../webazin/utilities.dart';
import '../controller/pages_more_controller.dart';
import '../view/pages_more_detail_page.dart';

class ItemPagesMoreList extends GetView<PagesMoreController> {
  DataMorePage data;
  int index;

  ItemPagesMoreList(this.data, this.index);

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PagesMoreDetailPage(data),
          )),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Get.theme.dividerColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: data.image!,
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
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    data.title!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16,left: 4),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.createdAt!,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: FontFamily.vazirLight,
                        color: Get.theme.dividerColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
