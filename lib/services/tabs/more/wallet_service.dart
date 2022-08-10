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

class WalletService {
  static Future get_wallet_service() async {
    Map data = {};
    try {
      await Dio()
          .get(
        "$apiBaseUrl/getUserMoney",
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

  static Future charge_wallet_service(String price, String payment_id) async {
    Map data = {};
    try {
      await Dio()
          .post(
        "$apiBaseUrl/charge",
        data: {
          "price": price,
          "payment_id": payment_id,
        },
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
          if (response.data["status"] == true) {
            buildToast("تم شحن الرصيد بنجاح");
          }
          ;
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
