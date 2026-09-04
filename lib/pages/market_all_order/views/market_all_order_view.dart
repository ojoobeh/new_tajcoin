import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:webazin/utils/utils.dart';
import '../../trader/widgets/trade_custom_text_field_widget.dart';
import '../controllers/market_all_order_controller.dart';
import '../widgets/list_markets_widget.dart';
import '../widgets/market_all_order_spinner_status_widget.dart';
import '../widgets/market_all_order_spinner_type_widget.dart';

class MarketAllOrderView extends StatefulWidget {
  const MarketAllOrderView();

  @override
  _MarketAllOrderViewState createState() => _MarketAllOrderViewState();
}

class _MarketAllOrderViewState extends State<MarketAllOrderView> with SingleTickerProviderStateMixin {
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
    MarketAllOrderController controller = Get.find<MarketAllOrderController>();
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: Get.theme.colorScheme.secondary,
          body: RefreshIndicator(
            onRefresh: () async {
              controller.refreshHome(showMessage: true);
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 51,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 50,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: Get.theme.dividerColor),
                            onPressed: () => {Get.back()},
                          ),
                        ),
                        Center(child: Obx(() {
                          return Text(
                            controller.statusMarket.value == "AllAll" ? "List of all orders".tr : controller.selectMarketList.symbol,
                            style: TextStyle(
                              color: context.theme.dividerColor,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        })),
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
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            controller.changeTab("Open");
                          },
                          child: Container(
                            child: Center(
                              child: Obx(() {
                                return Text(
                                  "Open orders".tr,
                                  style: TextStyle(
                                    fontFamily: FontFamily.vazirBold,
                                    color: controller.statusMarket.value == "Open" ? AppColors.buttonColor : Get.theme.dividerColor,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.changeTab("All");
                          },
                          child: Container(
                            child: Center(
                              child: Obx(() {
                                return Text(
                                  "Total orders".tr,
                                  style: TextStyle(
                                    fontFamily: FontFamily.vazirBold,
                                    color: controller.statusMarket.value == "All" ? AppColors.buttonColor : Get.theme.dividerColor,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.changeTab("AllAll");
                          },
                          child: Container(
                            child: Center(
                              child: Obx(() {
                                return Text(
                                  "The total order of currencies".tr,
                                  style: TextStyle(
                                    fontFamily: FontFamily.vazirBold,
                                    color: controller.statusMarket.value == "AllAll" ? AppColors.buttonColor : Get.theme.dividerColor,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx((){
                    return controller.statusMarket.value == "All" ||controller.statusMarket.value == "AllAll"
                        ? Column(
                      children: <Widget>[
                        Container(
                          color: Get.theme.scaffoldBackgroundColor,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 50,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Get.theme.dividerColor.withOpacity(0.8),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () async => controller.refreshHome(),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Get.theme.dividerColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.green, width: 1),
                                    ),
                                    child: Text(
                                      'Search'.tr,
                                      style: TextStyle(
                                        fontFamily: FontFamily.vazirLight,
                                        fontSize: 12,
                                        color: AppColors.green,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Obx(() {
                                    return TradeCustomTextFieldWidget(
                                      textController: controller.tecParamSearch.value,
                                      hintText: 'Desired currency'.tr,
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        fontFamily: FontFamily.vazirLight,
                                      ),
                                      keyboardType: TextInputType.text,
                                      maxLength: 50,
                                    );
                                  }),
                                ),
                                InkWell(
                                  onTap: () => controller.resetSearch(),
                                  child: Center(
                                    child: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Get.theme.scaffoldBackgroundColor,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Status ',
                                          style: TextStyle(
                                            fontFamily: FontFamily.vazirBold,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: AppColors.green, width: 1),
                                          ),
                                          child: MarketAllOrderSpinnerStatus(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                child: Center(
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'type '.tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.vazirBold,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: AppColors.green, width: 1),
                                          ),
                                          child: MarketAllOrderSpinnerType(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),
                      ],
                    ):Container();
                  }),

                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: ListMarketsWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
