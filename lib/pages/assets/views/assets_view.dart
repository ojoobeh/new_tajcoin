
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../root/controllers/root_controller.dart';
import '../controllers/assets_controller.dart';
import 'assets_footer.dart';
import 'assets_header.dart';

class AssetsView extends GetView<AssetsController> {
  @override
  Widget build(final BuildContext context) {
    printInfo();

    // controller.setIsSwitched(true);
    return Scaffold(
      backgroundColor: context.theme.colorScheme.secondary,
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshHome(showMessage: true);
        },

        child:WillPopScope(
            onWillPop: () async {
              Get.find<RootController>().changePage(0);
              return false;
            },
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      AssetsHeader(),
                      Flexible(
                        child: AssetsFooter(),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
