import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:webazin/utils/utils.dart';
import '../controllers/home_all_order_controller.dart';
import '../widgets/home_all_currency_list_item_widget.dart';
import '../widgets/home_all_currency_shimmer_list_item_widget.dart';

class HomeAllOrderView extends StatefulWidget {
  const HomeAllOrderView();

  @override
  _HomeAllOrderViewState createState() => _HomeAllOrderViewState();
}

class _HomeAllOrderViewState extends State<HomeAllOrderView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    HomeAllOrderController controller = Get.find<HomeAllOrderController>();
    List<Widget> taBar = [];
    taBar.add(InkWell(
      onTap: () {
        controller.changeTab("All", '');
      },
      child: Container(
        child: Center(
          child: Obx(() {
            return Text(
              "All".tr,
              style: TextStyle(
                fontFamily: FontFamily.vazirBold,
                color: controller.statusMarket.value == "All" ? AppColors.canvasColor : Get.theme.dividerColor,
              ),
            );
          }),
        ),
      ),
    ));

    taBar.add(InkWell(
      onTap: () {
        controller.changeTab("Filter", "positive");
      },
      child: Container(
        child: Center(
          child: Obx(() {
            return Text(
              "Top Gainers".tr,
              style: TextStyle(
                fontFamily: FontFamily.vazirBold,
                color: controller.statusMarket.value == "Filter" && controller.typeMarket.value == "positive" ? AppColors.canvasColor : Get.theme.dividerColor,
              ),
            );
          }),
        ),
      ),
    ));
    taBar.add(InkWell(
      onTap: () {
        controller.changeTab("Filter", "negative");
      },
      child: Container(
        child: Center(
          child: Obx(() {
            return Text(
              "Top Losers".tr,
              style: TextStyle(
                fontFamily: FontFamily.vazirBold,
                color: controller.statusMarket.value == "Filter" && controller.typeMarket.value == "negative" ? AppColors.canvasColor : Get.theme.dividerColor,
              ),
            );
          }),
        ),
      ),
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body: RefreshIndicator(
          onRefresh: () async {
            controller.refreshHome(showMessage: true);
          },
          child: Container(
            color: Get.theme.colorScheme.secondary,
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  color: context.theme.colorScheme.secondary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 50,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Get.theme.dividerColor,
                          ),
                          onPressed: () => {Get.back()},
                        ),
                      ),
                      Center(
                        child: Text(
                          "List of all currencies".tr,
                          style: TextStyle(
                            color: Get.theme.dividerColor,
                            fontFamily: FontFamily.vazirBold,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: taBar,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Get.theme.scaffoldBackgroundColor,
                    child: Obx(() {
                      return controller.isSearching.value
                          ? HomeAllCurrencyShimmerListItemWidget()
                          : controller.currencies.length > 0
                              ? HomeAllCurrencyListItemWidget()
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
                                );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
