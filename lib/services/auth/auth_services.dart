import 'dart:convert';
import 'dart:math';
import 'package:ads_app/controllers/auth/auth_controller.dart';
import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/local_database/local_database.dart';
import 'package:ads_app/main.dart';
import 'package:ads_app/services/sharedServices.dart';
import 'package:ads_app/views/auth/enter_forget_code.dart';
import 'package:ads_app/views/auth/enter_register_code.dart';
import 'package:ads_app/views/splash.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart' as getLang;
import 'package:dio/dio.dart';

FourTabsController fourTabsController = getLang.Get.find<FourTabsController>();

class AuthServices {
  // login with email and password
  static Future<bool> loginRequest(
    String email,
    String password,
    String device_token,
  ) async {
    FourTabsController fourTabsController =
        getLang.Get.find<FourTabsController>();
    bool done = false;
    try {
      await Dio().post("$apiBaseUrl/login",
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept-Language": "application/json",
              "lang": fourTabsController.lang.value,
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
          data: {
            "device_token": device_token,
            "email": email,
            "password": password,
          }).then((Response response) async {
        print(response.data);
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          done = false;
          return done;
        } else if (response.statusCode == 200) {
          if ("false" == response.data["status"]) {
            buildToast(response.data["message"]);
          } else {
            buildToast("تم تسجيل الدخول بنجاح");
          }
          Map responseMap = response.data["success"];
          await LocalDatabase.putUserData(json.encode(responseMap))
              .then((value) {
            fourTabsController.skipAndNotFirstTime();
            fourTabsController.getUserData();
            navigateForwardAndRemoveUntil(
                Splash(), getLang.Transition.fadeIn, Curves.easeInOut, 500);
          });

          done = true;
          return done;
        } else {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          done = false;
          return done;
        }
      }).catchError((Object o) {
        done = false;
      });
    } catch (e) {
      done = false;
    }

    return done;
  }

  // register with email and password
  static Future<bool> registerRequest(
    String name,
    String device_token,
    String phone,
    String password,
  ) async {
    AuthController authController = getLang.Get.find<AuthController>();
    bool done = false;
    try {
      await Dio().post("$apiBaseUrl/register",
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
          data: {
            "name": name,
            "phone": phone,
            "device_token": device_token,
            "password": password,
            "password_confirmation": password,
          }).then((Response response) async {
        print(response.data);
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          done = false;
          return done;
        } else if (response.statusCode == 200) {
          if ("failed" == response.data["status"]) {
            buildToast(response.data["error"]["phone"][0]);
          } else {
            print(response.data);
            Map responseMap = response.data;
            Map user = responseMap["data"];
            authController.registered_user_not_otp.value = user;

            navigateForward(EnterRegisterCode(), getLang.Transition.fadeIn,
                Curves.easeInOut, 500, []);
          }

          buildToast(response.data["msg"]);
          done = true;
          return done;
        } else {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          done = false;
          return done;
        }
      }).catchError((Object o) {
        done = false;
      });
    } catch (e) {
      done = false;
    }

    return done;
  }

  static Future<bool> otp_service_register(
    String activation_code,
    Map user,
  ) async {
    bool done = false;
    try {
      await Dio().post("$apiBaseUrl/otp",
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
          data: {
            "activation_code": "${activation_code}",
          }).then((Response response) async {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          done = false;
          return done;
        } else if (response.statusCode == 200) {
          if ("false" == response.data["status"]) {
            buildToast(response.data["message"]);
          } else {
            buildToast("تم تسجيل الدخول بنجاح");
            await LocalDatabase.putUserData(json.encode(user)).then((value) {
              fourTabsController.skipAndNotFirstTime();
              fourTabsController.getUserData();
              navigateForwardAndRemoveUntil(
                  Splash(), getLang.Transition.fadeIn, Curves.easeInOut, 500);
            });
          }

          buildToast(response.data["msg"]);
          done = true;
          return done;
        } else {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          done = false;
          return done;
        }
      }).catchError((Object o) {
        done = false;
      });
    } catch (e) {
      done = false;
    }

    return done;
  }

  // login with facebook
  static Future<bool> forgetPassword(
    String phone,
  ) async {
    AuthController authController = getLang.Get.find<AuthController>();
    bool done = false;
    try {
      await Dio().post("$apiBaseUrl/forgetPassword",
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
          data: {
            "phone": phone,
          }).then((Response response) {
        print(response.data);
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          done = false;
          return done;
        } else if (response.statusCode == 200) {
          if ("failed" == response.data["status"]) {
            buildToast(response.data["error"]["phone"][0]);
          } else {
            buildToast("تم إرسال الكود إلى هاتفك");
            authController.forgetCodeFromServer.value =
                response.data["data"].toString();
            print(authController.forgetCodeFromServer.value);

            navigateForward(EnterForgetCode(), getLang.Transition.downToUp,
                Curves.easeInOut, 500, []);
          }

          buildToast(response.data["msg"]);
          done = true;
          return done;
        } else {
          // buildToast(response.data["msg"]);
          done = false;
          return done;
        }
      }).catchError((Object o) {
        // buildToast("global2".tr);
        done = false;
      });
    } catch (e) {
      // buildToast("global2".tr);
      done = false;
    }

    return done;
  }
}
