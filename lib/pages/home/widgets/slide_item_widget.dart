
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../../utils/config_app.dart';

class SlideItemWidget extends StatelessWidget {
  final DataSlider? slide;

  const SlideItemWidget({
    this.slide,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () async=> await launch(slide!.link!),
      child: Container(
        height: ConfigApp.homeSliderWeight-40,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: CachedNetworkImageProvider(
                slide!.image!,

            ),
          ),
        ),
      ),
    );
  }
}
