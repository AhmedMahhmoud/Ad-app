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

FourTabsController fourTabsController = getLang.Get.find<FourTabsController>();

class StaticPageSrevice {
  static Future get_page_service(String id) async {
    String data = " ";
    try {
      await Dio()
          .get(
        "$apiBaseUrl/page/$id",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "lang": fourTabsController.lang.value,
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
          return "";
        } else if (response.statusCode == 200) {
          data = response.data["data"]["content"];
          return data;
        } else {
          return "";
        }
      }).catchError((Object o) {
        return "";
      });
    } catch (e) {
      return "";
    }

    return data;
  }
}
