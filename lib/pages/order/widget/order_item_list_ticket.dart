import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/dto/order.dart';


import '../../../utils/custom_devider.dart';
import 'package:webazin/utils/utils.dart';
import '../views/order_detail_view.dart';

class OrderItemListTicket extends StatelessWidget {
  final DataOrder dataOrder;

  const OrderItemListTicket(this.dataOrder);

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(OrderDetailView(dataOrder)),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black87.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 8)),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Currency: '.tr,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 14,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Text(dataOrder.currency!.symbol!,
                          style: TextStyle(
                            fontFamily: FontFamily.vazirLight,
                            fontSize: 12,
                            color: Get.theme.dividerColor,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      dataOrder.currency!.image != null && dataOrder.currency!.image != ''
                          ? dataOrder.currency!.image!.contains(".svg")
                              ? SvgPicture.network(
                                  dataOrder.currency!.image!,
                                  width: 22,
                                )
                              : Image.network(
                                  dataOrder.currency!.image!,
                                  width: 22,
                                )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            CustomDivider(
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.red,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Quantity: '.tr,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 14,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(dataOrder.qty.toString(),
                      style: TextStyle(
                        fontFamily: FontFamily.vazirLight,
                        fontSize: 12,
                        color: Get.theme.dividerColor,
                      )),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Get.theme.dividerColor.withOpacity(0.4),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Created At: '.tr,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 14,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(dataOrder.createdAtFa?.toIso8601String() ?? '',
                      style: TextStyle(
                        fontFamily: FontFamily.vazirLight,
                        fontSize: 12,
                        color: Get.theme.dividerColor,
                      )),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Get.theme.dividerColor.withOpacity(0.4),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Price: '.tr,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 14,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(dataOrder.price.toString(),
                      style: TextStyle(
                        fontFamily: FontFamily.vazirLight,
                        fontSize: 12,
                        color: Get.theme.dividerColor,
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Status: '.tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 14,
                          color: Get.theme.scaffoldBackgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: dataOrder.statusColor == 'green'
                              ? AppColors.green
                              : dataOrder.statusColor == 'blue'
                                  ? Colors.blue.shade800
                                  : dataOrder.statusColor == 'orange'
                                      ? Colors.orange
                                      : dataOrder.statusColor == 'red'
                                          ? Colors.red
                                          : Colors.red.shade800,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(dataOrder.statusText ?? '',
                              style: TextStyle(
                                fontFamily: FontFamily.vazirLight,
                                fontSize: 10,
                                color: context.theme.canvasColor//todo_selectedRowColor

                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Order status: '.tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 10,
                          color: Get.theme.scaffoldBackgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: dataOrder.type == 'buy'
                              ? AppColors.green
                              : Colors.red.shade800,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(dataOrder.typeText ?? '',
                              style: TextStyle(
                                fontFamily: FontFamily.vazirLight,
                                fontSize: 10,
                                color: context.theme.canvasColor//todo_selectedRowColor

                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
