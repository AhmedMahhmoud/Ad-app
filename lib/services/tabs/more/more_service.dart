import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/services/sharedServices.dart';
import 'package:dio/dio.dart';

class MoreServices {
  static Future social_links_service() async {
    Map ad = {};
    try {
      await Dio()
          .get(
        "$apiBaseUrl/social",
        options: Options(
          headers: {
            "lang": fourTabsController.lang.value,
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${fourTabsController.userMap["token"]}"
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
          ad = response.data["data"];
          return ad;
        } else {
          return {};
        }
      }).catchError((Object o) {
        return {};
      });
    } catch (e) {
      return {};
    }

    return ad;
  }

  static Future send_msg(String text) async {
    Map ad = {};
    try {
      await Dio().post("$apiBaseUrl/contact", data: {
        "email": fourTabsController.userMap["phone"],
        "msg": text,
      }).then((Response response) {
        print(response.data);
        buildToast("تم إستلام رسالتك بنجاح");
      }).catchError((Object o) {
        return {};
      });
    } catch (e) {
      return {};
    }

    return ad;
  }
}
