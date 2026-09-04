import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../webazin/utilities.dart';
import '../controller/calculator_controller.dart';

class CalculatorSpinnerListWidget extends GetView<CalculatorController> {
  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      return controller.currencies != null && controller.currencies.length > 0
          ? Container(
              child: DropdownButton<DataCurrency>(
                dropdownColor: Get.theme.scaffoldBackgroundColor,
                underline: Container(),
                isExpanded: true,
                value: controller.selectCurrencies.value,
                icon: null,
                iconSize: 0,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (DataCurrency? value) {
                  controller.selectCurrency(value!);
                },
                items: controller.currencies.map((DataCurrency currencies) {
                  return DropdownMenuItem<DataCurrency>(
                    value: currencies,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            currencies.symbol!,
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: (currencies.iconUrl??'').contains(".svg")
                                ? SvgPicture.network(
                                    currencies.iconUrl ?? '',
                                    width: 32,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    width: 32,
                                    height: 32,
                                    imageUrl: currencies.iconUrl??'',
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
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          : Container(
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Get.theme.dividerColor.withOpacity(0.7)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpinKitWave(color: Get.theme.dividerColor, size: 24, type: SpinKitWaveType.start),
              ),
            );
    });
  }
}
