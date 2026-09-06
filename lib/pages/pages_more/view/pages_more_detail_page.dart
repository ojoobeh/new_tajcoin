import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
                child: Html(
                  data: dataMetaverse.body!.replaceAll('\r\n', '') ,

                  // customRender: {
                  //   "p": (RenderContext context, Widget child) {
                  //     return Text(
                  //       context.tree.element!.text,
                  //       textDirection: TextDirection.rtl,
                  //       textAlign: TextAlign.start,
                  //       style: TextStyle(
                  //         fontFamily: FontFamily.vazirBold,
                  //         color: Get.theme.dividerColor,
                  //       ),
                  //     );
                  //   },
                  // },
                  style: {
                    "*": Style(
                      textAlign: TextAlign.start,
                      alignment: Alignment.centerRight,
                      color: Get.theme.hintColor,
                      fontSize: FontSize(16.0),
                      display: Display.inlineBlock,
                      width: Width.auto(),
                    ),
                    "li": Style(
                      textAlign: TextAlign.start,
                      lineHeight: LineHeight.normal,
                      listStylePosition: ListStylePosition.outside,
                      fontSize: FontSize(14.0),
                      display: Display.block,
                    ),
                    "h4,h5,h6": Style(
                      textAlign: TextAlign.start,
                      fontSize: FontSize(16.0),
                    ),
                    "h1,h2,h3": Style(
                      textAlign: TextAlign.start,
                      lineHeight: LineHeight.number(2),
                      fontSize: FontSize(18.0),
                    ),
                    "br": Style(
                      height: Height.auto(),
                    ),
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
