import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webazin/webazin/utilities.dart';

import 'package:webazin/utils/utils.dart';

class SlideTextItemWidget extends StatelessWidget {
  final DataSlider slide;

  const SlideTextItemWidget({
    required this.slide,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () async => await launch(slide.link!),
      child: Container(
        height: 30,
        width: Get.width-90,
        child: Center(
            child: Text(
          slide.title!,
          style: TextStyle(
            fontFamily: FontFamily.vazirBold,
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
