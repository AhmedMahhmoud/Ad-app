import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseNotificationScreen extends StatelessWidget {
  final RemoteMessage notification;
  const FirebaseNotificationScreen({Key? key, required this.notification,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notifications'.tr)),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: const Text('title'),
                subtitle: Text(notification.notification?.title ?? ''),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              child: ListTile(
                title: const Text('Body'),
                subtitle: Text(
                    notification.notification?.body ?? 'No notification'),
              ),
            ),
            SizedBox(height: 20,),
              if(notification.data.isNotEmpty)
              Card(
                child: ListTile(
                  title: const Text('data'),
                  subtitle: Text(notification.data.toString()),
                ),
              )
          ],
        ),
      ),
    );
  }
}