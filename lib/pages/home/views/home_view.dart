import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webazin/pages/global_widgets/scrolling_text.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../../utils/helper.dart';
import '../../../routes/app_routes.dart';
import '../../../services/them_service.dart';
import '../../../utils/assets.dart';

import '../../../utils/config_app.dart';
import 'package:webazin/utils/utils.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_shimmer_list_item_widget.dart';
import '../widgets/list_shimmer_top_csurrencies_widget.dart';
import 'home_header.dart';
import 'home_list_item_widget.dart';
import 'home_menu.dart';
import 'home_top_currencies.dart';

changeThem() {
  ThemeService().switchTheme;
}

class HomeView extends GetView<HomeController> {
  @override
  Widget build(final BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(),
    );
    if (!controller.isShowDialog) {
      Future.delayed(Duration.zero, () => sendMessage(context));
      controller.isShowDialog = true;
    }

    Color colors = context.theme.colorScheme.secondary;
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colors,
          body: RefreshIndicator(
            onRefresh: () async {
              controller.refreshHome(showMessage: true);
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: colors,
                    height: 44,
                    margin: const EdgeInsets.only(top: 4),
                    padding: EdgeInsets.only(left: 16, right: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () => Get.toNamed(Routes.TicketS),
                          // onTap: () =>  showLoading(),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  return Core.user.apiToken != null ? Get.toNamed(Routes.SETTINGS) : Get.toNamed(Routes.LOGIN)!.then((value) => Get.rootController.refresh());
                                },
                                child: Image.asset(
                                  Assets.profile2,
                                  width: 28,
                                  height: 28,
                                  color: context.theme.dividerColor.withOpacity(0.8),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                child: Image.asset(
                                  Assets.chat,
                                  width: 28,
                                  height: 28,
                                  color: context.theme.dividerColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 0,
                              child: MaterialButton(
                                color: Colors.transparent,
                                child: Text("", style: TextStyle(fontSize: 2)),
                                onPressed: ThemeService().switchTheme,
                              ).marginOnly(right: 32),
                            ),
                            Image.asset(Assets.logoWide, height: 28),
                            SizedBox(
                              width: 8,
                            ),
                            // InkWell(
                            //   onTap: () async {
                            //     await controller.refreshHome();
                            //   },
                            //   child: Icon(
                            //     FontAwesome.arrows_cw,
                            //     color: context.theme.dividerColor.withOpacity(0.8),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  HomeHeader(),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      color: context.theme.scaffoldBackgroundColor,
                    ),
                    child: ConfigApp.textMovie
                        ? Core.applicationInfo.message != null && Core.applicationInfo.message != ''
                            ? SizedBox(
                                height: 30,

                                child: ScrollingText(
                                    text: Core.applicationInfo.message ?? '',
                                    textStyle: TextStyle(color: context.theme.dividerColor, fontFamily: FontFamily.vazirLight, fontSize: 14),
                                    color: Colors.transparent),
                              )
                            : Container()
                        : Container(),
                  ),
                  Container(
                    width: double.infinity,
                    color: context.theme.scaffoldBackgroundColor,
                    child: Center(
                      child: Obx(() {
                        return controller.currencies.length > 0 //
                            ? HomeTopCurrencies(
                                limit: 3,
                              )
                            : ListShimmerTopCurrenciesWidget(3);
                      }),
                    ),
                  ),
                  Container(
                    color: context.theme.colorScheme.secondary,
                    width: double.infinity,
                    height: 10,
                  ),
                  HomeMenu(),
                  Container(
                    color: context.theme.colorScheme.secondary,
                    width: double.infinity,
                    height: 10,
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 8),
                    width: double.infinity,
                    color: context.theme.scaffoldBackgroundColor,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('24h Change', style: context.textTheme.bodyLarge!.copyWith(fontSize: 12,color: context.theme.dividerColor.withOpacity(0.4))),
                              SizedBox(
                                width: 16,
                              ),
                              Text('Last price', style: context.textTheme.bodyLarge!.copyWith(fontSize: 12,color: context.theme.dividerColor.withOpacity(0.4))),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Name', style: context.textTheme.bodyLarge!.copyWith(fontSize: 12,color: context.theme.dividerColor.withOpacity(0.4))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),                  Container(
                    width: double.infinity,
                    color: context.theme.scaffoldBackgroundColor,
                    child: Obx(() {
                      return controller.currencies.length > 0 ? HomeListItemWidget() : HomeShimmerListItemWidget();
                    }),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.HOMEALLCURRENCIES),
                    child: Container(
                      color: context.theme.scaffoldBackgroundColor,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          "More...".tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: FontFamily.vazirBold,
                            color: AppColors.green,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendMessage(final BuildContext context) async {
    // CallPopup data = Get.find<AppService>().callPopup.value;
    // List<DataPopup> list = await DbHelper.getPopupList();
    // List<int> l1 = [];
    // list.forEach((element) {
    //   l1.add(element.id!);
    // });
    // if (!l1.contains(data.data![0].id)) {
    //   showGeneralDialog(
    //       barrierColor: Colors.black.withOpacity(0.8),
    //       transitionBuilder: (context, a1, a2, widget) {
    //         return Transform.scale(
    //           scale: a1.value,
    //           child: Opacity(
    //             opacity: a1.value,
    //             child: AlertDialog(
    //               contentPadding: EdgeInsets.zero,
    //               backgroundColor: Colors.transparent,
    //               elevation: 0,
    //               content: WillPopScope(
    //                 onWillPop: () async => false,
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[
    //                     Container(
    //                       decoration: BoxDecoration(color: context.theme.primaryColor, borderRadius: BorderRadius.circular(16)),
    //                       height: 400,
    //                       child: Container(
    //                         decoration: BoxDecoration(
    //                           image: DecorationImage(
    //                             image: NetworkImage(data.data![0].image!),
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                         height: double.infinity,
    //                         child: Column(
    //                           children: <Widget>[
    //                             Container(
    //                               margin: const EdgeInsets.only(top: 16),
    //                               child: Text(
    //                                 data.data![0].title.toString(),
    //                                 style: TextStyle(
    //                                   fontFamily: FontFamily.vazirBold,
    //                                   fontSize: 15,
    //                                   color: Colors.white,
    //                                 ),
    //                               ),
    //                             ),
    //                             Flexible(
    //                               child: Container(
    //                                 height: double.infinity,
    //                                 padding: EdgeInsets.all(16),
    //                                 margin: const EdgeInsets.only(top: 26),
    //                                 child: Text(
    //                                   data.data![0].message.toString(),
    //                                   style: TextStyle(
    //                                     fontFamily: FontFamily.vazirBold,
    //                                     fontSize: 13,
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             Container(
    //                               height: 80,
    //                               child: Row(
    //                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                                 children: <Widget>[
    //                                   InkWell(
    //                                     onTap: () {
    //                                       // DbHelper.insertPopup(dataPopup: data.data![0]);
    //                                       Get.back();
    //                                       bool isShowHelper = getBool('${Core.helperHome}');
    //
    //                                       if (!isShowHelper) {
    //                                         controller.showTutorial(context);
    //                                       }
    //                                     },
    //                                     child: Container(
    //                                       width: 130,
    //                                       height: 50,
    //                                       decoration: BoxDecoration(
    //                                         borderRadius: BorderRadius.circular(8),
    //                                         border: Border.all(color: Colors.orangeAccent, width: 1),
    //                                       ),
    //                                       child: Center(
    //                                         child: Text(
    //                                           style: TextStyle(
    //                                             fontSize: 12,
    //                                             fontFamily: FontFamily.vazirBold,
    //                                             color: Colors.orange,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   InkWell(
    //                                     onTap: () async {
    //                                       await launch(data.data![0].link!);
    //                                       Get.back();
    //                                       bool isShowHelper = getBool('${Core.helperHome}');
    //
    //                                       if (!isShowHelper) {
    //                                         controller.showTutorial(context);
    //                                       }
    //                                     },
    //                                     child: Container(
    //                                       width: 130,
    //                                       height: 50,
    //                                       decoration: BoxDecoration(
    //                                         borderRadius: BorderRadius.circular(8),
    //                                         color: Colors.orangeAccent,
    //                                       ),
    //                                       child: Center(
    //                                         child: Text(
    //                                           style: TextStyle(
    //                                             fontSize: 12,
    //                                             fontFamily: FontFamily.vazirBold,
    //                                             color: Colors.white,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       width: 2,
    //                       height: 50,
    //                       color: Colors.white,
    //                     ),
    //                     InkWell(
    //                         onTap: () {
    //                           Get.back();
    //                           bool isShowHelper = getBool('${Core.helperHome}');
    //
    //                           if (!isShowHelper) {
    //                             controller.showTutorial(context);
    //                           }
    //                         },
    //                         child: SvgPicture.asset(
    //                           Assets.close,
    //                           width: 34,
    //                           height: 34,
    //                           color: Colors.white,
    //                         ))
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //       transitionDuration: Duration(milliseconds: 200),
    //       barrierDismissible: false,
    //       barrierLabel: '',
    //       context: context,
    //       pageBuilder: (context, animation1, animation2) {
    //         return Container();
    //       });
    // } else {
    //   bool isShowHelper = getBool('${Core.helperHome}');
    //   // final keyZero = GlobalKey();
    //   // final keyOne2 = GlobalKey();
    //   // WidgetsBinding.instance!.addPostFrameCallback(
    //   //       (_) => ShowCaseWidget.of(context)!.startShowCase([
    //   //     isShowHelper != true ? keyOne2 : keyZero,
    //   //     keyOne2,
    //   //     // keyTwo2,
    //   //   ]),
    //   // );
    //   if (!isShowHelper) {
    //     controller.showTutorial(context);
    //   }
    // }
  }
}

class ListItem extends StatelessWidget {
  final int index;

  const ListItem({Key? key, required this.index});

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            margin: const EdgeInsets.only(right: 15.0),
            color: Colors.blue,
          ),
          index != -1
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'This is title $index',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('This is more details'),
                    Text('One more detail'),
                  ],
                )
              : Expanded(
                  child: Container(
                    color: Colors.grey,
                  ),
                )
        ],
      ),
    );
  }
}
