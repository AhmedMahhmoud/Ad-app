import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //initilize

  static Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/launcher_icon');

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      print("welcomeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      /* try {
        if (payload != null) {
          Get.to(
            OneAd(id: payload.toString()),
          );
        } else {
          debugPrint('payload is null');
        }
      } catch (e) {
        log("e $e");
      }*/
      // implement the navigation logic
    });
  }

  //Instant Notifications
  static Future instantNofitication(String title, String body, payload) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );
    var platform = NotificationDetails(
        android: AndroidNotificationDetails(
      channel.id,
      channel.name, channelDescription: channel.description,
      playSound: true,
      icon: '@drawable/launcher_icon',
      // other properties...
    ));
    await _flutterLocalNotificationsPlugin.show(0, title, body, platform,
        payload: "payload");
  }

  //Image notification

  // download image and show in local notification

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';

    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<void> showBigPictureNotification(
      String title, String body, String downloadLinkForImage) async {
    final String largeIconPath =
        await _downloadAndSaveFile(downloadLinkForImage, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(downloadLinkForImage, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: title,
            htmlFormatContentTitle: true,
            summaryText: body,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'big text channel id', 'big text channel name',
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  static Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
