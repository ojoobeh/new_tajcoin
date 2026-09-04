import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/dto/order.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';

class OrderDetailView extends StatefulWidget {
  final DataOrder dataOrder;

  const OrderDetailView(this.dataOrder);

  @override
  _OrderDetailViewState createState() => _OrderDetailViewState(this.dataOrder);
}

class _OrderDetailViewState extends State<OrderDetailView> with TickerProviderStateMixin {
  late final DataOrder dataOrder;

  _OrderDetailViewState(this.dataOrder);

  late String typeT;
  late MaterialColor color;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();

    typeT = dataOrder.type == 1 ? "buy".tr+" " : "sale".tr+" ";

    color = dataOrder.statusColor == "orange"
        ? Colors.orange
        : dataOrder.statusColor == "green"
            ? Colors.green
            : dataOrder.statusColor == "blue"
                ? Colors.blue
                : dataOrder.statusColor == "red"
                    ? Colors.red
                    : Colors.yellow;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _button() {
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildContainer(55 * _controller.value),
            _buildContainer(60 * _controller.value),
            _buildContainer(65 * _controller.value),
            _buildContainer(70 * _controller.value),
            _buildContainer(75 * _controller.value),
            Align(
                child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.ok,
                  width: 25,
                  color: Colors.white,
                ),
              ),
            )),
          ],
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(1 - _controller.value),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail order".tr,
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
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: Center(
                    child: _button(),
                  ),
                ),
                Text(
                  dataOrder.statusText!,
                  style: TextStyle(
                    color: color.withOpacity(0.7),
                    fontFamily: FontFamily.vazirBold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  dataOrder.currency!.symbol! + " " + dataOrder.qty.toString(),
                  style: TextStyle(
                    color: Get.theme.dividerColor,
                    fontFamily: FontFamily.vazirBold,
                    fontSize: 20,
                  ),
                ).marginOnly(top: 16),
                Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 32),
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColorDark.withOpacity(0.6),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Order registration date".tr,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    dataOrder.createdAtFa.toString().replaceAll("null", "") ,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ).marginOnly(top: 18),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Exchange rate".tr,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    getPrice(dataOrder.currency!.irtPrice.toString()) + " " + " IRT".tr ,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ).marginOnly(top: 18),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Exchange amount".tr,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    dataOrder.currency!.symbol! + " " + dataOrder.qty!.toString(),
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ).marginOnly(top: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Exchange rate".tr,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    dataOrder.currency!.irtPrice!.toString() + " Irt ".tr,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ).marginOnly(top: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "USDT price".tr,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    dataOrder.currency!.price!.toString(),
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ).marginOnly(top: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Total amount in Irt".tr,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    dataOrder.price!.toString() + " Irt ".tr,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ).marginOnly(top: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Order status".tr,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    dataOrder.typeText!,
                                    style: TextStyle(
                                      color: Get.theme.dividerColor.withOpacity(0.7),
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ).marginOnly(top: 8),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 44,
                        height: 44,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(boxShadow: <BoxShadow>[
                          BoxShadow(color: this.color.withOpacity(0.3), blurRadius: 40, offset: Offset(0, 15)),
                          BoxShadow(color: this.color.withOpacity(0.2), blurRadius: 13, offset: Offset(0, 3))
                        ], borderRadius: BorderRadius.circular(60), color: Colors.white),
                        child: Center(
                          child: dataOrder.currency!.image!.contains(".svg")
                              ? SvgPicture.network(
                                  dataOrder.currency!.image!,
                                  width: 44,
                                  height: 44,
                                )
                              : Image.network(
                                  dataOrder.currency!.image!,
                                  width: 44,
                                  height: 44,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      color: Colors.orange,
                    ),
                    child: Center(
                      child: Text(
                        'Back'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor,
                        ),
                      ),
                    ),
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
