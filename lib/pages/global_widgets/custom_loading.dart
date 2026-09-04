import 'package:flutter/material.dart';
// import 'package:loading/indicator/ball_pulse_indicator.dart';
// import 'package:loading/loading.dart';

import '../../utils/assets.dart';

class CustomLoading extends StatelessWidget {
  final bool barrierDismissible;

  /*
   *
    showDialog(
           context: context,
           builder: (final BuildContext context) {
             return CustomExitDialog(
               onOkTap: () {
                 Get.find<AuthService>().removeCurrentUser();
                 Get.toNamed(Routes.LOGIN);
               },
             );
           });
                                                  *
                                                  * */

  CustomLoading({this.barrierDismissible = false});

  dialogContent(final BuildContext context) {
    return WillPopScope(
      onWillPop: () async => barrierDismissible,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(32),
            width: 250,
            height: 250,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Assets.logo,
                    width: 100,
                  ),
                  // Loading(
                  //   indicator: BallPulseIndicator(),
                  //   size: 50.0,
                  //   color: Colors.pink,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
