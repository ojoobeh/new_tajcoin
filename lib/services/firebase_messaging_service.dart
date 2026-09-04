import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/ui.dart';

class FireBaseMessagingService extends GetxService {
  Future<FireBaseMessagingService> init() async {
    firebaseCloudMessagingListeners();
    return this;
  }

  void firebaseCloudMessagingListeners() {
    FirebaseMessaging.instance.requestPermission(sound: true, badge: true, alert: true);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      Get.showSnackbar(Ui.notificationSnackBar(
        title: notification?.title??'',
        message: notification?.body??'',
      ));
    });

    FirebaseMessaging.onBackgroundMessage((message) async => _firebaseonBackgroundMessage);
  }

  Future<void> _firebaseonBackgroundMessage(RemoteMessage message) async {
    RemoteNotification notification = message.notification!;
    Get.showSnackbar(Ui.notificationSnackBar(
      title: notification.title!,
      message: notification.body!,
    ));


  }

  Future<void> setDeviceToken() async {
    try{
      // String? deviceToken= await FirebaseMessaging.instance.getToken();
      // Core.user.deviceToken =deviceToken;
      debugPrint('OK');
    }catch(e){
      debugPrint(e.toString());
    }

  }
}
