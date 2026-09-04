import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:webazin/utils/utils.dart';
import '../../trader/widgets/trade_custom_text_field_widget.dart';
import '../controllers/order_controller.dart';
import '../widget/order_item_list_ticket.dart';
import '../widget/order_item_shimmer_list_ticket.dart';
import '../widget/order_spinner_status_widget.dart';
import '../widget/order_spinner_type_widget.dart';

class OrderListView extends GetView<OrderController> {
  final bool hideAppBar;

  OrderListView({this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }

  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    controller.profileForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders".tr,
          style: TextStyle(
            color: context.theme.dividerColor,
            fontSize: 16,
            fontFamily: FontFamily.vazirBold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Get.theme.dividerColor),
          onPressed: () => {Get.back()},
        ),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshHome(showMessage: true);
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Divider(
                height: 0.5,
                color: Get.theme.dividerColor.withOpacity(0.4),
              ),
              Column(
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
                                    'Status '.tr,
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
                                    child: OrderSpinnerStatus(),
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
                                    child: OrderSpinnerType(),
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
              ),
              Flexible(
                child: Obx(() {
                  return Container(
                    child: !controller.isSearching.value
                        ? controller.orderList.length > 0
                            ? ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: controller.orderList.length + 1,
                                controller: controller.scrollController,
                                itemBuilder: (context, index) {
                                  if (index == controller.orderList.length) {
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
                                    return OrderItemListTicket(controller.orderList[index]);
                                  }
                                },
                              )
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
                              )
                        : ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return OrderItemShimmerListTicket();
                            },
                          ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
