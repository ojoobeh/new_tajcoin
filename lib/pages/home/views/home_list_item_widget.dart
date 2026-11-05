import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webazin/data/extensions/text_extension.dart';
import 'package:webazin/data/extensions/widget_extension.dart';
import 'package:webazin/pages/market/controllers/market_controller.dart';
import 'package:webazin/routes/app_routes.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';
import 'package:webazin/widgets/image.dart';

import '../../../utils/config_app.dart';
import 'package:webazin/utils/utils.dart';
import '../../global_widgets/custom_expansion_tiles.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/home_controller.dart';

class HomeListItemWidget extends GetView<HomeController> {
  HomeListItemWidget();

  // onTap: () {
  // if (ConfigApp.goToMarket &&currencies.symbol != "IRT") {
  // DataMarketList data = DataMarketList.fromJson(currencies.markets![0].toJson());
  // Get.find<MarketController>().selectCurrency(data);
  // Get.find<RootController>().changePage(3);
  // }
  // },

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            color: context.theme.cardColor,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Latest Changes'.tr, style: context.textTheme.bodyLarge!.copyWith(fontSize: 12, color: context.theme.dividerColor.withOpacity(0.4))),
                      SizedBox(width: 56),
                      Text('Latest price'.tr, style: context.textTheme.bodyLarge!.copyWith(fontSize: 12, color: context.theme.dividerColor.withOpacity(0.4))),
                    ],
                  ),
                  Row(
                    children: [Text('Markets'.tr, style: context.textTheme.bodyLarge!.copyWith(fontSize: 12, color: context.theme.dividerColor.withOpacity(0.4)))],
                  ),
                ],
              ),
            ),
          ),


          Container(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,

              // itemCount: controller.currencies.length,
              itemCount: 5,
              itemBuilder: ((_, index) {
                DataCurrency currencies = controller.currencies.value[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            !currencies.chartImage!.contains(".svg")
                                ? CachedNetworkImage(
                                    width: 64,
                                    imageUrl: currencies.chartImage!,
                                    placeholder: (context, url) => Shimmer.fromColors(
                                      baseColor: Get.theme.cardColor,
                                      highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                                      child: Container(
                                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(100)),
                                        width: double.infinity,
                                        height: 20,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  )
                                : SvgPicture.network(
                                    currencies.chartImage!,
                                    width: 64,
                                    color: currencies.percent == "0"
                                        ? Colors.grey
                                        : currencies.percent.length > 1 && currencies.percent.contains("-")
                                        ? Colors.red
                                        : AppColors.green,
                                  ),
                            Container(
                              width: 56,
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: currencies.percent == "0"
                                    ? Colors.grey.withValues(alpha: 0.5)
                                    : currencies.percent.length > 1 && currencies.percent.contains("-")
                                    ? Colors.red.withValues(alpha: 0.5)
                                    : AppColors.green.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  color: currencies.percent == "0"
                                      ? Colors.grey
                                      : currencies.percent.length > 1 && currencies.percent.contains("-")
                                      ? Colors.red
                                      : AppColors.green,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "${currencies.percent} %",
                                  style: TextStyle(fontFamily: FontFamily.vazirBold, fontSize: 12, color: context.theme.dividerColor),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${getPrice(currencies.irtPrice.toString(), limit: 0)} ${' IRT'.tr}').labelMedium(),
                                Text('${getPrice(currencies.price.toString(), limit: 0)} ${'\$ '}').labelMedium(fontSize: 10),
                              ],
                            ),
                          ],
                        ).expanded(),
                        Row(
                          spacing: 4,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [Text(currencies.symbol!), Text(currencies.symbol!).bodySmall(fontSize: 8)],
                            ),
                            image(currencies.iconUrl!, width: 22, height: 22),
                          ],
                        ),
                      ],
                    ),
                    Divider(color: context.theme.primaryColorDark.withValues(alpha: 0.3)),
                  ],
                );
              }),
            ),
          ),//

          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            color: context.theme.cardColor,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Row(
                    spacing: 8,
                    children: [
                      Text('View All Markets'.tr, style: context.textTheme.bodyLarge!.copyWith(fontSize: 12, color: Color(0xff385ae4))),
                      Icon(Icons.arrow_forward_ios,  color: Color(0xff385ae4),size: 12,),
                    ],
                  ),
                ],
              ),
            ).onTap(() {
              Get.toNamed(Routes.HOMEALLCURRENCIES);
            },),
          ),
        ],
      ),
    );
  }
}
