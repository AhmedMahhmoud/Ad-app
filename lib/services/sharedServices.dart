import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

String apiBaseUrl = "https://sevenkuwait.com/api";

Future<bool> isThereInternet() async {
  bool found = false;
  try {
    List connection = await InternetAddress.lookup("google.com");
    if (connection.isNotEmpty && connection[0].rawAddress.isNotEmpty) {
      found = true;
    }
  } on SocketException catch (e) {
    found = false;
  }
  return found;
}

// save_language

Future<void> refreshTokenAtHomeStart() async {
  FirebaseMessaging.instance.getToken().then((token) async {
    try {
      await Dio()
          .patch(
        "$apiBaseUrl/users/6229d07bafa981d6772ea026",
        data: {"fb_token": token},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            'Authorization':
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Im1ldGhvZCI6InJlZW1pZnkiLCJmaXJzdE5hbWUiOiJNYWhtb3VkIiwibGFzdE5hbWUiOiJTYWxhbWEgNiIsImVtYWlsIjoibWFobW91ZDZAZ21haWwuY29tIiwicmVnaXN0ZXJfZGF0ZSI6IjIwMjItMDMtMTBUMTA6MTg6MzQuNzIzWiIsInByb2ZpbGVfaW1hZ2UiOiIvaW1hZ2VzL3VzZXJzLzYxZjE1ZDIxM2FmNGFkY2ZkOTQ3NDhkYS9kZWZhdWx0LTE2NDY2NjA0MDAzMTAucG5nIiwiY292ZXJfaW1hZ2UiOm51bGwsInByb2ZpbGVfaW1hZ2VzIjpbXSwiY292ZXJfaW1hZ2VzIjpbXSwiYmlvIjoiIiwiX2lkIjoiNjIyOWQwN2JhZmE5ODFkNjc3MmVhMDI2In0sImlhdCI6MTY0NjkwNzUxNSwiZXhwIjoxNjQ5NDk5NTE1fQ.ADtEWt98jb9ggdmW7sRKWWJmOg9__ZLj7lY57B0U9q8"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        print(response.statusCode);
        print(response.data);
      });
    } catch (e) {}
  });
}
