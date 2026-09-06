import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

import 'package:webazin/utils/utils.dart';
import '../../../webazin/utilities.dart';

class TicketItemListTicket extends StatelessWidget {
  final DataTicket dataTickets;

  const TicketItemListTicket(this.dataTickets);

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () =>
          // dataTickets.answers!=null&& dataTickets.answers.length>0
          //   ?
          Get.toNamed(Routes.ANSWERSTicketS, arguments: dataTickets),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black45.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 8)),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Topic'.tr+":",
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 14,
                          color: Get.theme.dividerColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        dataTickets.subject.toString().length > 35 ? '${dataTickets.subject.toString().substring(0, 35)}...' : dataTickets.subject.toString(),

                          style: TextStyle(

                            fontFamily: FontFamily.vazirLight,
                            fontSize: 12,
                            color: Get.theme.dividerColor,
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Code'.tr+":",
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 14,
                          color: Get.theme.dividerColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(dataTickets.id.toString(),
                          style: TextStyle(
                            fontFamily: FontFamily.vazirLight,
                            fontSize: 12,
                            color: Get.theme.dividerColor,
                          )),
                    ],
                  ),
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
                  Row(
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
                      Text(dataTickets.createdAtFa!.split(" ")[0] ,
                          style: TextStyle(
                            fontFamily: FontFamily.vazirLight,
                            fontSize: 12,
                            color: Get.theme.dividerColor,
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Updated At: '.tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 14,
                          color: Get.theme.dividerColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(dataTickets.updatedAt!.split(" ")[0] ,
                          style: TextStyle(
                            fontFamily: FontFamily.vazirLight,
                            fontSize: 12,
                            color: Get.theme.dividerColor,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor.withOpacity(0.5),
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
                        'Section: '.tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 14,
                          color: Get.theme.dividerColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(dataTickets.category ?? '',
                          style: TextStyle(
                            fontFamily: FontFamily.vazirLight,
                            fontSize: 12,
                            color: Get.theme.dividerColor,
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Status: '.tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 14,
                          color: Get.theme.dividerColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: dataTickets.statusColor == "green"
                              ? AppColors.green
                              : dataTickets.statusColor == "blue"
                                  ? Colors.blue.shade800
                                  : Colors.yellow.shade800,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(dataTickets.statusFa ?? '',
                              style: TextStyle(
                                fontFamily: FontFamily.vazirLight,
                                fontSize: 12,
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
