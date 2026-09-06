import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:webazin/utils/utils.dart';
import 'package:webazin/widgets/persianDatePicker/flutter_datepicker.dart';
import '../controllers/authentication_controller.dart';

class BirthdayWidget extends GetView<AuthenticationController> {
  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () async {

        // LinearDatePicker(
        //     startDate: "1922/02/20", //yyyy/mm/dd
        //     endDate: "2023/02/20",
        //     initialDate: "2010/11/15",
        //     dateChangeListener: (String selectedDate) {
        //       print(selectedDate);
        //     },
        //     showDay: true,  //false -> only select year & month
        //     labelStyle: TextStyle(
        //       fontFamily: 'sans',
        //       fontSize: 14.0,
        //       color: Colors.black,
        //     ),
        //     selectedRowStyle: TextStyle(
        //       fontFamily: 'sans',
        //       fontSize: 18.0,
        //       color: Colors.deepOrange,
        //     ),
        //     unselectedRowStyle: TextStyle(
        //       fontFamily: 'sans',
        //       fontSize: 16.0,
        //       color: Colors.blueGrey,
        //     ),
        //     yearText: "سال | year",
        //     monthText: "ماه | month",
        //     dayText: "روز | day",
        //     showLabels: true, // to show column captions, eg. year, month, etc.
        //     columnWidth: 100,
        //     showMonthName: true,
        //     isJalaali: true  // false -> Gregorian
        // );


        Jalali? pickedDate =
        await showModalBottomSheet<Jalali>(
          context: context,
          builder: (context) {
            Jalali? tempPickedDate;
            return Container(
              height: 250,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CupertinoButton(
                          child:  Text(
                            'Cancel'.tr,
                            style: TextStyle(
                              fontFamily: 'Dana',
                                color: context.theme.dividerColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoButton(
                          child:  Text(
                            "Confirm".tr,
                            style: TextStyle(
                              fontFamily: 'Dana',
                              color: context.theme.dividerColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(
                                tempPickedDate ??
                                    Jalali.now());
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            );
          },
        );

        // Jalali? picked = await showPersianDatePicker(
        //   context: context,
        //
        //   initialDate: Jalali(1385, 9),
        //   firstDate: Jalali(1300, 8),
        //   lastDate: Jalali(1385, 9),
        // );
        //
        // if (picked != null && picked != controller.selectedDate) {
        //   String birthday=picked.year.toString() +
        //       '/' +
        //       picked.month.toString() +
        //       '/' +
        //       picked.day.toString();
        //   controller.updateBirthday(birthday);
        // }
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Birthday'.tr,
              style: TextStyle(
                fontFamily: FontFamily.vazirLight,
                fontSize: 12,
                color: Get.theme.dividerColor.withOpacity(0.8),
              ),
              textAlign: TextAlign.start,
            ).marginOnly(right: 8),
            Container(
              width: double.infinity,
              height: 45,
              margin: const EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Get.theme.dividerColor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Container(
                  width: double.infinity,
                  child: Obx((){
                    return Text(
                      controller.birthDay.value ,
                      style: TextStyle(
                        fontFamily: FontFamily.vazirLight,
                        fontSize: 12,
                        color: Get.theme.dividerColor,
                      ),
                      textAlign: TextAlign.end,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
