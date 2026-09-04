import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/dto/user.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';

class BankCardItemListTicket extends StatelessWidget {
  final DataCards dataCards;

  const BankCardItemListTicket(this.dataCards);

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () => null,
      // dataTickets.answers!=null&& dataTickets.answers.length>0
      //   ?

      // :Fluttertoast.showToast(
      //     msg: "No answer".tr,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     fontSize: 16.0
      // ),
      child: Container(
        height: 220,
        margin: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.card02),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Get.theme.dividerColor.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 8)),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                      color: dataCards.statusColor == 'green'
                          ? AppColors.green
                          : dataCards.statusColor == 'blue'
                              ? Colors.blue.shade800
                              : Colors.red.shade800,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Text(dataCards.status ?? '',
                          style: TextStyle(
                            fontFamily: FontFamily.vazirLight,
                            fontSize: 12,
                            color: context.theme.highlightColor,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Text(dataCards.bankName.toString(),
                          style: TextStyle(
                            fontFamily: FontFamily.vazirBold,
                            fontSize: 12,
                            color: Get.theme.dividerColor,
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      dataCards.icon != null && dataCards.icon != ''
                          ? Image.network(
                              dataCards.icon!,
                              width: 22,
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(getCardNumber(dataCards.cardNumber!),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontFamily: FontFamily.vazirBold,
                        fontSize: 22,
                        color: Get.theme.dividerColor,
                      )),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'expiration date:****'.tr,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 14,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('IR-' + (dataCards.sheba ?? ''),
                      style: TextStyle(
                        fontFamily: FontFamily.vazirLight,
                        fontSize: 12,
                        color: Get.theme.dividerColor,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
