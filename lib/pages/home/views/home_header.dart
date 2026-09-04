import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webazin/utils/assets.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/webazin/utilities.dart';


import '../../../utils/config_app.dart';
import '../controllers/home_controller.dart';
import '../widgets/slide_item_widget.dart';
import '../widgets/slide_shimmer_item_widget.dart';
import '../widgets/slide_text_item_widget.dart';

class HomeHeader extends GetView<HomeController> {
  const HomeHeader();

  @override
  Widget build(final BuildContext context) {
    //
    final CarouselController _controller = CarouselController();
    return Container(
      width: double.infinity,
      height: ConfigApp.homeSliderWeight,
      child: Obx(() {
        return Core.applicationInfo.slides!.length > 0
            ? Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    color: context.theme.scaffoldBackgroundColor,
                    height: ConfigApp.homeSliderWeight - 45,
                    width: double.infinity,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 7),
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          controller.currentSlide.value = index;
                        },
                      ),
                      items: Core.applicationInfo.slides!.map((DataSlider slide) {
                        return Container(
                          child: Stack(
                            children: <Widget>[
                              Center(child: SlideItemWidget(slide: slide)),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: Colors.black87.withOpacity(0.4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(right: 4),
                                          child: SvgPicture.asset(
                                            Assets.alarm,
                                            width: 24,
                                            height: 24,
                                            color: Colors.white,
                                          )),
                                      SlideTextItemWidget(slide: slide),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      // carouselController: _controller,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: Core.applicationInfo.slides!.map((DataSlider slide) {
                          return Container(
                            width: 20.0,
                            height: 5.0,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: controller.currentSlide.value == Core.applicationInfo.slides!.indexOf(slide) ? AppColors.orangeColor : Colors.grey.withOpacity(0.4)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              )
            : Shimmer.fromColors(baseColor: Get.theme.cardColor, highlightColor: Get.theme.dividerColor.withOpacity(0.5), child: SlideShimmerItemWidget());
      }),
    );
  }
}
