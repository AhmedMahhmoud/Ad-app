import 'dart:io';

import 'package:ads_app/controllers/auth/auth_controller.dart';
import 'package:ads_app/controllers/chat/all_chats_controller.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/services/sharedServices.dart';
import 'package:ads_app/views/auth/enter_forget_code.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart' as getLang;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class OffersService {
  static Future<List> get_offers_cats_service() async {
    List data = [];
    try {
      await Dio()
          .get(
        "$apiBaseUrl/offers",
        options: Options(
          headers: {
            "lang": fourTabsController.lang.value,
            "Content-Type": "application/json",
            "Accept": "application/json",
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
          return [];
        } else if (response.statusCode == 200) {
          data = response.data["categories "];
          return data;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return data;
  }

  static Future<List> get_cats_data_service(String id, String type) async {
    List data = [];
    try {
      await Dio()
          .get(
        "$apiBaseUrl/offers/$id?type=$type",
        options: Options(
          headers: {
            "lang": fourTabsController.lang.value,
            "Content-Type": "application/json",
            "Accept": "application/json",
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
          return [];
        } else if (response.statusCode == 200) {
          data = response.data["offers"];
          return data;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return data;
  }
}
