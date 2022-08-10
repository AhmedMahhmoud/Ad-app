import 'dart:developer';

import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/services/sharedServices.dart';

import 'package:dio/dio.dart';

class HomeServices {
  static Future<Map> get_home_service() async {
    Map home_data = {};

    try {
      await Dio()
          .get(
        "$apiBaseUrl/home",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "lang": fourTabsController.lang.value
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        log(response.toString());
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          home_data = response.data;
          return home_data;
        } else {
          return home_data;
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return home_data;
    }

    return home_data;
  }

  static Future<Map> get_sub_category_service(String id, String type) async {
    Map home_data = {};

    try {
      await Dio()
          .get(
        "$apiBaseUrl/category/$id/subCategory?type=$type",
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
          return [];
        } else if (response.statusCode == 200) {
          home_data = response.data;
          return home_data;
        } else {
          return home_data;
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return home_data;
    }

    return home_data;
  }

  static Future<Map> get_govs_ads_service_service(
      String cat_id, String gov_id, String region_id) async {
    Map home_data = {};

    try {
      await Dio()
          .get(
        "$apiBaseUrl/filterByGovernment?category_id=$cat_id&government_id=$gov_id&region_id=$region_id",
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
          return [];
        } else if (response.statusCode == 200) {
          home_data = response.data;
          return home_data;
        } else {
          return home_data;
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return home_data;
    }

    return home_data;
  }
}
