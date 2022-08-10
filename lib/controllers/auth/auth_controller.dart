import 'dart:math';

import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/views/auth/change_password.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController loginPhone = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  TextEditingController registerName = TextEditingController();
  TextEditingController registerPhone = TextEditingController();
  TextEditingController registerPassword = TextEditingController();
  TextEditingController registerPasswordConfirm = TextEditingController();
  TextEditingController registerCode = TextEditingController();

  //
  //
  TextEditingController forgetCodePhone = TextEditingController();
  TextEditingController enterCode = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordConfirm = TextEditingController();
  //
  //
  RxBool hidePassword = true.obs;
  RxBool loadingLogin = false.obs;
  RxBool loadingforget = false.obs;
  RxBool loadingRegister = false.obs;
  RxString forgetCodeFromServer = "".obs;
  RxMap registered_user_not_otp = {}.obs;

  Future register_code_is_correct(BuildContext context) async {
    if (registerCode.text.trim().toString() !=
        registered_user_not_otp["activation_code"].toString()) {
      buildToast("الكود المدخل غير صحيح");
      return;
    } else {
      AuthServices.otp_service_register(
          "${registered_user_not_otp["activation_code"]}",
          registered_user_not_otp);
    }
  }

  Future codeIsCorrect(BuildContext context) async {
    if (enterCode.text.trim() != forgetCodeFromServer.value) {
      buildToast("الكود المدخل غير صحيح");
      return;
    }
    navigateForward(
        ChangePassword(), Transition.downToUp, Curves.easeInOut, 500, []);
  }

  Future sendForget() async {
    if (!GetUtils.isNumericOnly(forgetCodePhone.text.trim()) ||
        forgetCodePhone.text.trim().length != 8) {
      buildToast("من فضلك أدخل جوال صحيح");
      return;
    }
    loadingforget.value = true;

    await AuthServices.forgetPassword(forgetCodePhone.text.trim());
    loadingforget.value = false;
  }

  Future login() async {
    if (!GetUtils.isNumericOnly(loginPhone.text.trim()) ||
        loginPhone.text.trim().length != 8) {
      buildToast("من فضلك أدخل جوال صحيح");
      return;
    }
    if (loginPassword.text.trim().isEmpty) {
      buildToast("من فضلك أدخل كلمة مرور صحيح");
      return;
    }
    loadingLogin.value = true;

    await FirebaseMessaging.instance.getToken().then((token) async {
      await AuthServices.loginRequest(
          loginPhone.text.trim(), loginPassword.text.trim(), token!);
    });
    loadingLogin.value = false;
  }

  Future register() async {
    if (registerName.text.trim().isEmpty) {
      buildToast("من فضلك أدخل الإسم");
      return;
    }
    if (!GetUtils.isNumericOnly(registerPhone.text.trim()) ||
        registerPhone.text.trim().length != 8) {
      buildToast("من فضلك أدخل جوال صحيح");
      return;
    }

    if (registerPassword.text.trim().isEmpty) {
      buildToast("من فضلك أدخل كلمة مرور صحيح");
      return;
    }

    if (registerPasswordConfirm.text.trim().isEmpty ||
        (registerPassword.text.trim() != registerPasswordConfirm.text.trim())) {
      buildToast("كلمة المرور غير متطابقة");
      return;
    }
    loadingRegister.value = true;

    await FirebaseMessaging.instance.getToken().then((token) async {
      await AuthServices.registerRequest(registerName.text.trim(), token!,
          registerPhone.text.trim(), registerPassword.text.trim());
    });
    loadingRegister.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
