import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../../../webazin/data/dto/dto.dart';
import '../controllers/tickets_controller.dart';

class SpinnerSectionListWidget extends GetView<TicketsController> {
  String iconData;

  SpinnerSectionListWidget(this.iconData);

  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      return controller.ticketCategoryList != null && controller.ticketCategoryList.value.length > 0
          ? Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 8, left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 18),
                      width: Get.width - 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          DropdownButton<DataTicketCategory>(
                            dropdownColor: Get.theme.scaffoldBackgroundColor,
                            value: controller.selectCategory.value,
                            icon: const Icon(Icons.arrow_drop_down),
                            underline: Container(),
                            iconSize: 32,
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontFamily: FontFamily.vazir,
                            ),
                            onChanged: (DataTicketCategory? value) {
                              controller.selectIndexCategory(value!);
                            },
                            items: controller.ticketCategoryList.map((DataTicketCategory vahed) {
                              return DropdownMenuItem<DataTicketCategory>(
                                value: vahed,
                                child: Container(
                                  width: 150,
                                  child: Text(
                                    vahed.title!,
                                    textAlign: TextAlign.start,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Get.theme.dividerColor),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Divider(
                            height: 3,
                            color: Get.theme.dividerColor.withOpacity(0.5),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      iconData,
                      width: 26,
                      height: 26,
                      color: context.theme.dividerColor.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            )
          : Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 8, left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 18),
                      width: Get.width - 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SpinKitWave(color: Get.theme.dividerColor, size: 24, type: SpinKitWaveType.start),
                          ),
                          Divider(
                            height: 3,
                            color: Get.theme.dividerColor.withOpacity(0.5),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      iconData,
                      width: 26,
                      height: 26,
                      color: context.theme.dividerColor.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
