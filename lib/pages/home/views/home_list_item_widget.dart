import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webazin/pages/market/controllers/market_controller.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';


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
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 10),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // itemCount: controller.currencies.length,
      itemCount: 5,
      itemBuilder: ((_, index) {
        DataCurrency currencies = controller.currencies.value[index];
        return CustomExpansionTile(
          title: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Container(
                  padding: EdgeInsets.zero,
                  height: 64,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 30,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: currencies.percent == "0"
                                    ? Colors.grey
                                    : currencies.percent.length > 1 && currencies.percent.contains("-")
                                        ? Colors.red
                                        : AppColors.green,
                                borderRadius: BorderRadius.all(Radius.circular(4))),
                            child: Center(
                                child: Text(
                              currencies.percent.toString() + " %",
                              style: TextStyle(
                                fontFamily: FontFamily.vazirBold,
                                fontSize: 12,
                                color: context.theme.dividerColor,
                              ),
                              textDirection: TextDirection.ltr,
                            )),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      getPrice(currencies.irtPrice.toString(), limit: 0),
                                      style: TextStyle(
                                        fontFamily: FontFamily.vazirBold,
                                        fontSize: 12,
                                        color: context.theme.dividerColor.withOpacity(0.9),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      ' IRT'.tr,
                                      style: TextStyle(
                                        fontFamily: FontFamily.vazirBold,
                                        fontSize: 10,
                                        color: context.theme.dividerColor.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '\$ ' + currencies.price.toString(),
                                  style: TextStyle(
                                    fontFamily: FontFamily.vazirLight,
                                    fontSize: 12,
                                    color: context.theme.dividerColor.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            currencies.symbol!,
                            style: TextStyle(
                              fontFamily: FontFamily.vazirBold,
                              fontSize: 16,
                              color: context.theme.dividerColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          currencies.iconUrl!.contains(".svg")
                              ? SvgPicture.network(
                                  currencies.iconUrl!,
                                  width: 28,
                                  fit: BoxFit.cover,
                                ).marginOnly(left: 8)
                              : Image.network(
                                  currencies.iconUrl!,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ).marginOnly(left: 8),
                        ],
                      ),
                    ],
                  ),
                ).marginSymmetric(horizontal: 16),
                Divider(
                  height: 1,
                  indent: 8,
                  endIndent: 8,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  !currencies.chartImage!.contains(".svg")
                      ? CachedNetworkImage(
                          width: 100,
                          height: 50,
                          imageUrl: currencies.chartImage!,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Get.theme.cardColor,
                            highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              width: double.infinity,
                              height: 20,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        )
                      : SvgPicture.network(
                          currencies.chartImage!,
                          width: 80,
                          height: 50,
                        ),
                  ConfigApp.goToMarket && currencies.symbol != "IRT" && currencies.markets!.length > 0
                      ? InkWell(
                          onTap: () {
                            if (ConfigApp.goToMarket && currencies.symbol != "IRT" && currencies.markets!.length > 0) {
                              DataMarket data = DataMarket.fromJson(currencies.markets![0].toJson());
                              Get.find<MarketController>().selectCurrency(data);
                              Get.find<RootController>().changePage(3);
                            }
                          },
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.green,
                            ),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "trade now".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 13,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.arrow_right,
                                      size: 32,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
