import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'notificationLocale.dart';

//
//
// foreground background listen for cahnging

runListener() async {
  FGBGEvents.stream.listen((event) async {
    if (event == FGBGType.foreground) {
      List list = await getAllLocaleNotifications();
      list.forEach((element) {
        if (json.decode(element)["order"] != null) {
          // checkIfOrderNotification(json.decode(element));
        }
        if (json.decode(element)["user"] != null) {
          updateLocaleData(json.decode(json.decode(element)["user"]));
        }
      });
    }
  });

// in dispose
}
//

updateLocaleData(Map userNotificationMap) {
  // List addRemove = [];
  // addRemove.clear();
  // json.decode(userNotificationMap["addRemove"]).forEach((element) {
  //   addRemove.add({
  //     "add": element["add"],
  //     "amount": element["amount"],
  //     "createdAt": Timestamp.fromMillisecondsSinceEpoch(
  //         element["createdAt"]["_seconds"] * 1000),
  //     "reason": element["reason"],
  //   });
  // });

  // LocalDatabase.putProfileData(UserModel(
  //   stopWork: json.decode(userNotificationMap["stopWork"]),
  //   branchId: json.decode(userNotificationMap["branchId"]),
  //   addRemove: addRemove,
  //   salary: json.decode(userNotificationMap["salary"]),
  //   deliveryLocations: fourTabsController.profile.value.deliveryLocations,
  //   privileges: json.decode(userNotificationMap["privileges"]),
  //   deviceToken: fourTabsController.profile.value.deviceToken,
  //   docId: fourTabsController.profile.value.docId,
  //   fbId: fourTabsController.profile.value.fbId,
  //   imagePath: fourTabsController.profile.value.imagePath,
  //   location: fourTabsController.profile.value.location,
  //   name: fourTabsController.profile.value.name,
  //   phone: fourTabsController.profile.value.phone,
  //   userId: fourTabsController.profile.value.userId,
  //   userType: json.decode(userNotificationMap["userType"]),
  // )).then((value) {
  //   fourTabsController.getUserModel().then((value) {
  //     if (fourTabsController.profile.value.userType == "user") {
  //       ComingOrdersController comingOrdersController =
  //           Get.isRegistered<MyOrdersController>()
  //               ? Get.find()
  //               : Get.put(ComingOrdersController());
  //       comingOrdersController.assign();
  //     }
  //   });
  // });
}

Future<List> getAllLocaleNotifications() async {
  // var localNotificationsBox = await Hive.openBox('localeNotifications');
  // String localNotificationsJson =
  //     localNotificationsBox.get("localeNotifications") != null
  //         ? localNotificationsBox.get("localeNotifications")
  //         : json.encode([]);
  // List localNotifications = json.decode(localNotificationsJson);
  // return localNotifications;
  // var localNotificationsBox = await Hive.openBox('test');
  // String message = localNotificationsBox.get("tt") != null
  //     ? localNotificationsBox.get("tt")
  //     : "";
  // if (message.length > 0) {
  //   Map messageMap = jsonDecode(message);
  //   if(  Get.isRegistered<OneChatController>() ){
  //   OneChatController oneChatController =   Get.find();
  //   oneChatController.all_messages.insert(
  //       0,
  //       InSideMessageModel(
  //           id: messageMap["_id"],
  //           body: messageMap["body"],
  //           date: messageMap["date"],
  //           file_path: "",
  //           from: messageMap["from"],
  //           to: messageMap["to"],
  //           type: messageMap["type"],
  //           video_thumbnail: ""));
  //   oneChatController.update();
  //   localNotificationsBox.put("tt", "");

  //   }

  // }

  return [];
}

putAllLocaleNotifications(String notification, bool clear) async {
  await Hive.initFlutter();
  var localNotificationsBox = await Hive.openBox('test');
  localNotificationsBox.put("tt", notification);
  await Hive.close();
}

//

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   Get.to(FirebaseNotificationScreen());
// }

// checkIfOrderNotification(Map message) async {
//   if (message["order"] != null) {
//     Map orderMap = json.decode(message["order"]);
//     MyOrdersController myOrdersController =
//         Get.isRegistered<MyOrdersController>()
//             ? Get.find()
//             : Get.put(MyOrdersController());
//     int index = myOrdersController.currentOrders.lastIndexWhere(
//         (element) => element.no.toString() == (orderMap["no"]).toString());
//     if (index != -1) {
//       BranchOrderModel branchOrderModel =
//           myOrdersController.currentOrders[index];
//       myOrdersController.currentOrders.removeAt(index);
//       if (int.parse((orderMap["status"]).toString()) > 3) {
//         myOrdersController.previousOrders.add(BranchOrderModel(
//             moreMoney: int.parse((orderMap["no"]).toString()),
//             basket: branchOrderModel.basket,
//             stuffMap: branchOrderModel.stuffMap,
//             customerMap: branchOrderModel.customerMap,
//             deviceToken: branchOrderModel.deviceToken,
//             updatedAt: branchOrderModel.updatedAt,
//             comment: branchOrderModel.comment,
//             cancelReason: branchOrderModel.cancelReason,
//             stuff: branchOrderModel.stuff,
//             createdAt: branchOrderModel.createdAt,
//             finishedAt: branchOrderModel.finishedAt,
//             products: branchOrderModel.products,
//             status: int.parse((orderMap["status"]).toString()),
//             type: branchOrderModel.type,
//             fbId: branchOrderModel.fbId,
//             no: branchOrderModel.no,
//             docId: branchOrderModel.docId,
//             where: branchOrderModel.where,
//             branch: branchOrderModel.branch));
//       } else {
//         myOrdersController.currentOrders.insert(
//             index,
//             BranchOrderModel(
//                 moreMoney: int.parse((orderMap["no"]).toString()),
//                 basket: branchOrderModel.basket,
//                 stuffMap: branchOrderModel.stuffMap,
//                 customerMap: branchOrderModel.customerMap,
//                 deviceToken: branchOrderModel.deviceToken,
//                 updatedAt: branchOrderModel.updatedAt,
//                 comment: branchOrderModel.comment,
//                 cancelReason: branchOrderModel.cancelReason,
//                 stuff: branchOrderModel.stuff,
//                 createdAt: branchOrderModel.createdAt,
//                 finishedAt: branchOrderModel.finishedAt,
//                 products: branchOrderModel.products,
//                 status: int.parse((orderMap["status"]).toString()),
//                 type: branchOrderModel.type,
//                 fbId: branchOrderModel.fbId,
//                 no: branchOrderModel.no,
//                 docId: branchOrderModel.docId,
//                 where: branchOrderModel.where,
//                 branch: branchOrderModel.branch));
//       }
//     }
//   }
// }

// initialMessaging() async {
//   // FirebaseMess aging.instance.getInitialMessage(); when app is closed
//   // Set the background messaging handler early on, as a named top-level function
//
//   await Firebase.initializeApp();
//   await FirebaseMessaging.instance.getToken();
//   await FirebaseMessaging.instance.subscribeToTopic("sevenNew");
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//   // await FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//   //   Map messageMap = jsonDecode(message.data["message"]);
//   //   OneChatController oneChatController = Get.find();
//   //   oneChatController.all_messages.insert(
//   //       0,
//   //       InSideMessageModel(
//   //           id: messageMap["_id"],
//   //           body: messageMap["body"],
//   //           date: messageMap["date"],
//   //           file_path: "",
//   //           from: messageMap["from"],
//   //           to: messageMap["to"],
//   //           type: messageMap["type"],
//   //           video_thumbnail: ""));
//   //   oneChatController.update();
//   // });
//   await FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     // checkIfOrderNotification(message.data);
//   });
// }

firebaseMessagingConfig(BuildContext context) async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log(message.data["id"].toString());
    log(message.data["image"].toString());
    log(message.data["title"].toString());
    log(message.data["type"].toString());
    log(message.data["body"].toString());

    log(message.data["notifcation_type"].toString());
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (android != null) {
      NotificationService.instantNofitication(
          notification!.title!, notification.body!, message.data.toString());
    }
  });
}

Future<void> iosPermission() async {
  if (Platform.isIOS) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.requestPermission();
  }
}
