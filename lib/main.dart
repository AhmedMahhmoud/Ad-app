import 'dart:developer';

import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/lang/translation.dart';
import 'package:ads_app/views/notifications/fire_base.dart';
import 'package:ads_app/views/one_ad/one_ad.dart';
import 'package:ads_app/views/splash.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controllers/notificationLocale.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Get.to(FirebaseNotificationScreen(
    notification: message,
  ));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // await Firebase.initializeApp().then((value) async{
  //   await initialMessaging();
  //   await iosPermission();
  //   await runListener();
  // });

  NotificationService.initialize()
      .whenComplete(() => log("LOCAL SERVICE INTIALIZED"));
  await Firebase.initializeApp();
  await FCMConfig.instance
      .init(
    defaultAndroidForegroundIcon: '@mipmap/ic_launcher',
    //default is @mipmap/ic_launcher
    defaultAndroidChannel: AndroidNotificationChannel(
      'high_importance_channel', // same as value from android setup
      'Fcm config',
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('notification'),
    ),
    onBackgroundMessage: _firebaseMessagingBackgroundHandler,
    sound: true,
  )
      .then((value) async {
    await FCMConfig.instance.messaging.subscribeToTopic('sevenNew');
  });
  log('(${await FCMConfig.instance.messaging.getToken()})');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with FCMNotificationMixin, FCMNotificationClickMixin {
  final FourTabsController fourTabsController = Get.put(FourTabsController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: maincolor1,
    ));

    return Sizer(
      builder: (context, orientation, deviceType) {
        return Obx(
          () => GetMaterialApp(
              title: "SEVEN",
              debugShowMaterialGrid: false,
              translations: Translation(),
              theme: ThemeData(
                fontFamily: "driod_arabic",
                scaffoldBackgroundColor: Colors.white,
              ),
              fallbackLocale: Locale(fourTabsController.lang.value),
              locale: Locale(fourTabsController.lang.value),
              debugShowCheckedModeBanner: false,
              home: Splash()),
        );
      },
    );
  }

  @override
  void onClick(RemoteMessage notification) {
    // Get.to(FirebaseNotificationScreen(notification: notification,));
    log("on click");
    log(notification.data.toString());
    log(notification.data['id'] ?? '');
    log(notification.notification?.title ?? '');
    Get.to(
      OneAd(id: notification.data['id'].toString()),
    );
  }

  @override
  void onNotify(RemoteMessage notification) {}
}
