import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webazin/data/extensions/text_extension.dart';
import 'package:webazin/data/extensions/widget_extension.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';

import 'package:webazin/utils/utils.dart';
import 'package:webazin/widgets/image.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_shimmer_list_item_widget.dart';

class HomeTopCurrencies extends GetWidget<HomeController> {
  final int limit;

  HomeTopCurrencies({this.limit = 0});

  @override
  Widget build(final BuildContext context) {
    return Container(
      // height: 140,
      margin: const EdgeInsets.only(bottom: 15),
      child: Obx(() {
        return controller.currencies.length > 0
            ? Row(
                children: [
                  _item(index: 0, color: Color(0xff111328)).expanded(),
                  _item(index: 1, color: Color(0xff141319)).expanded(),
                ],
              )
            : HomeShimmerListItemWidget();
      }),
    );
  }

  Widget _item({required int index, required Color color}) => Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.theme.dividerColor.withValues(alpha: 0.1)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              image(controller.currencies[index].iconUrl!, width: 32, height: 32),
              Row(spacing: 2, children: [Text(controller.currencies[index].symbol!).labelSmall(fontSize: 12), Text('/USDT').labelSmall()]),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text('${getPrice(controller.currencies[index].price.toString(), limit: 0)} ${'\$ '}').labelLarge(fontSize: 18),
                  Text('${getPrice(controller.currencies[index].irtPrice.toString(), limit: 0)} ${'IRT'.tr}').labelLarge(fontSize: 9),
                ],
              ).expanded(),

              Container(
                width: 56,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Center(
                  child: Text(
                    "${controller.currencies[index].percent} %",
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 12,
                      color: controller.currencies[index].percent == "0"
                          ? Colors.grey
                          : controller.currencies[index].percent.length > 1 && controller.currencies[index].percent.contains("-")
                          ? Colors.red
                          : AppColors.green,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
            ],
          ),
          !controller.currencies[index].chartImage!.contains(".svg")
              ? Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: controller.currencies[index].chartImage!,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Get.theme.cardColor,
                        highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(100)),
                          width: double.infinity,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ).expanded(),
                  ],
                )
              : SvgPicture.network(
                  controller.currencies[index].chartImage!,
                  color: controller.currencies[index].percent == "0"
                      ? Colors.grey
                      : controller.currencies[index].percent.length > 1 && controller.currencies[index].percent.contains("-")
                      ? Colors.red
                      : AppColors.green,
                ),
        ],
      ),
    ),
  );

  Widget _item2({required int index, required Color color}) => Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.theme.dividerColor.withValues(alpha: 0.1)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            //
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(spacing: 2, children: [Text(controller.currencies[index].symbol!).labelSmall(fontSize: 12), Text('/USDT').labelSmall()]),
              image(controller.currencies[index].iconUrl!, width: 22, height: 22),
              // Image.network(controller.currencies[index].icon!,width: 32,height: 32),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${getPrice(controller.currencies[index].price.toString(), limit: 0)} ${'\$ '}').labelLarge(fontSize: 14),
              SizedBox(),
              // Image.network(controller.currencies[index].icon!,width: 32,height: 32),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 56,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Center(
                  child: Text(
                    "${controller.currencies[index].percent} %",
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 12,
                      color: controller.currencies[index].percent == "0"
                          ? Colors.grey
                          : controller.currencies[index].percent.length > 1 && controller.currencies[index].percent.contains("-")
                          ? Colors.red
                          : AppColors.green,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
              SizedBox(),
            ],
          ),
          !controller.currencies[index].chartImage!.contains(".svg")
              ? Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: controller.currencies[index].chartImage!,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Get.theme.cardColor,
                        highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(100)),
                          width: double.infinity,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ).expanded(),
                  ],
                )
              : SvgPicture.network(
                  controller.currencies[index].chartImage!,
                  color: controller.currencies[index].percent == "0"
                      ? Colors.grey
                      : controller.currencies[index].percent.length > 1 && controller.currencies[index].percent.contains("-")
                      ? Colors.red
                      : AppColors.green,
                ),
        ],
      ),
    ),
  );
}
