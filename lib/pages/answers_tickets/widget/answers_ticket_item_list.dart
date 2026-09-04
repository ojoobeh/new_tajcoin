import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webazin/utils/assets.dart';
import 'package:webazin/utils/ui.dart';

import '../../../webazin/utilities.dart';

class AnswersTicketItemList extends StatelessWidget {

  const AnswersTicketItemList(this.answersTickets, {super.key});
  final DataAnswer answersTickets;

  @override
  Widget build(final BuildContext context) => Directionality(
      textDirection: answersTickets.roleId == "admin" ? TextDirection.ltr : TextDirection.rtl,
      child: answersTickets.roleId == "admin"
          ? Container(
              margin: const EdgeInsets.only(top: 14, left: 14),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.yellow.shade100, boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.black87.withOpacity(0.3), blurRadius: 40, offset: const Offset(0, 15)),
                      BoxShadow(color: Colors.black87.withOpacity(0.6), blurRadius: 13, offset: const Offset(0, 3))
                    ]),
                    child: SvgPicture.asset(
                      Assets.svSupport,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 100,
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(246, 187, 5, 1).withOpacity(0.8),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          boxShadow:<BoxShadow> [
                            BoxShadow(color: Colors.black87.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 8)),
                          ],
                        ),
                        child: Center(
                          child: Container(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              margin: const EdgeInsets.only(top: 14, right: 14),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.blue.shade100, boxShadow:<BoxShadow> [
                      BoxShadow(color: Colors.black87.withOpacity(0.3), blurRadius: 40, offset: const Offset(0, 15)),
                      BoxShadow(color: Colors.black87.withOpacity(0.6), blurRadius: 13, offset: const Offset(0, 3))
                    ]),
                    child: SvgPicture.asset(
                      Assets.svPerson,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xff4298da).withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.black87.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: Center(
                      child: Container(),
                    ),
                  ),
                ],
              ),
            ),
    );
}
