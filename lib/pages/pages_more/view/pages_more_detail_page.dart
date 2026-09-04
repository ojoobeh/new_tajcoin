import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../../../webazin/utilities.dart';

class PagesMoreDetailPage extends StatelessWidget {
  DataMorePage dataMetaverse;

  PagesMoreDetailPage(this.dataMetaverse);

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.secondary,
      appBar: AppBar(
        title: Text(
          dataMetaverse.title!,
          style: TextStyle(
            fontFamily: FontFamily.vazirBold,
            color: Get.theme.dividerColor.withOpacity(0.8),
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Get.theme.dividerColor),
          onPressed: () => {Get.back()},
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            )),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  dataMetaverse.image!,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
