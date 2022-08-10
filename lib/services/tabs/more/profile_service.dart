import 'dart:io';

import 'package:ads_app/controllers/auth/auth_controller.dart';
import 'package:ads_app/controllers/chat/all_chats_controller.dart';
import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/services/sharedServices.dart';
import 'package:ads_app/views/auth/enter_forget_code.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart' as getLang;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

FourTabsController fourTabsController = getLang.Get.find<FourTabsController>();

class ProfileService {
  //
  //

  static Future<bool> update_profile(
    File image,
    String name,
    String phone,
  ) async {
    bool done = false;

    try {
      await Dio()
          .post("$apiBaseUrl/edit-details",
              options: Options(
                headers: {
                  'Authorization':
                      "Bearer ${fourTabsController.userMap["token"]}"
                },
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                },
              ),
              data: image.path != "null"
                  ? FormData.fromMap({
                      "name": name,
                      "phone": phone,
                      "image": await MultipartFile.fromFile(
                        image.path,
                        filename: image.path,
                        contentType: MediaType("image", "png"),
                      ),
                    })
                  : FormData.fromMap({
                      "name": name,
                      "phone": phone,
                    }))
          .then((Response response) {
        print(response.data);
        print(response.statusCode);
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر حاول لاحقا");
          done = false;
          return done;
        } else if (response.statusCode == 200) {
          buildToast("تم تحديث بياناتك بنجاح");

          done = true;
          return done;
        }
        return done;
      }).catchError((Object o) {
        buildToast("يوجد مشكلة بالسيرفر حاول لاحقا");
        print(o);

        return done;
      });
    } catch (e) {
      print(e);
      buildToast("يوجد مشكلة بالسيرفر حاول لاحقا");
      return done;
    }

    return done;
  }

  static Future<bool> update_password(
    String oldpassword,
    String newpassword,
  ) async {
    bool done = false;

    try {
      await Dio().post("$apiBaseUrl/changePassword",
          options: Options(
            headers: {
              'Authorization': "Bearer ${fourTabsController.userMap["token"]}"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
          data: {
            "old_password": oldpassword,
            "password": newpassword,
            "password_confirmation": newpassword,
          }).then((Response response) {
        print(response.data);
        print(response.statusCode);
        if (response.statusCode == 500) {
          buildToast("كلمة المرور المدخلة غير صحيحة");
          done = false;
          return done;
        } else if (response.statusCode == 200) {
          if (response.data["status"] == "false") {
            buildToast(response.data["message"]);
          } else {
            buildToast("تم تحديث كلمة المرور بنجاح");
          }

          done = true;
          return done;
        }
        return done;
      }).catchError((Object o) {
        buildToast("يوجد مشكلة بالسيرفر حاول لاحقا");
        print(o);

        return done;
      });
    } catch (e) {
      print(e);
      buildToast("يوجد مشكلة بالسيرفر حاول لاحقا");
      return done;
    }

    return done;
  }

  static Future get_profile_service() async {
    Map data = {};
    try {
      await Dio()
          .get(
        "$apiBaseUrl/get-details",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': "Bearer ${fourTabsController.userMap["token"]}"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return {};
        } else if (response.statusCode == 200) {
          data = response.data["data"];
          return data;
        } else {
          return {};
        }
      }).catchError((Object o) {
        return {};
      });
    } catch (e) {
      return {};
    }

    return data;
  }
}
