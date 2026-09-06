import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utility/global.dart';


import 'package:webazin/utils/utils.dart';
import '../controllers/home_controller.dart';

class ListTopCurrenciesWidget extends GetWidget<HomeController> {
  final int limit;

  ListTopCurrenciesWidget({this.limit= 0});

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 95,
      margin: const EdgeInsets.only(bottom: 15),
      child: Obx(() {
        return controller.currencies.length > 0
            ? ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: limit == 0 ? controller.currencies.length : limit,
                itemBuilder: (_, index) {
                  var _category = controller.currencies.elementAt(index);
                  Color color = _category.percent.toString().contains("-")
                      ? Colors.red
                      : AppColors.green;
                  return Container(
                    width: (Get.width/limit)-(100/limit),
                    margin: EdgeInsetsDirectional.only(
                        end: index == limit - 1
                            ? 0
                            : 10,
                        start: index == 0 ? 0 : 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _category.symbol !="USDT"?'/USDT':"",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 12,
                                  color: context.theme.dividerColor.withOpacity(0.5),
                                ),
                              ),
                              Text(
                                _category.symbol!,
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 16,
                                  color: context.theme.dividerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                        sDouble(_category.price.toString(),decimal: (int.parse(_category.decimal!)))+" \$",
                            maxLines: 2,
                            style: TextStyle(
                              color: context.theme.dividerColor.withOpacity(0.8),
                              fontSize: 16,
                              fontFamily: FontFamily.vazirBold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(
                            "%" + _category.percent.toString(),
                            textDirection: TextDirection.ltr,
                            maxLines: 2,
                            style: TextStyle(
                              color: color,
                              fontSize: 12,
                              fontFamily: FontFamily.vazirBold,
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                })
            : Container();
      }),
    );
  }
}
