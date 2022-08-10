import 'package:ads_app/controllers/auth/auth_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class AuthWidgets {
  static nameField(
      TextEditingController textEditingController, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Icon(
              Icons.person,
              size: 7.w,
              color: black.withOpacity(0.3),
            ),
          ),
          Expanded(
              child: Center(
            child: TextField(
              style: TextStyle(
                fontSize: 4.w,
                color: black.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              ),
              controller: textEditingController,
              cursorHeight: 7.w,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: "auth1".tr,
                  hintStyle: TextStyle(
                    fontSize: 3.5.w,
                    color: black.withOpacity(0.3),
                    fontWeight: FontWeight.normal,
                  )),
            ),
          )),
        ],
      ),
      height: 13.w,
      width: dw(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(width: 2, color: black.withOpacity(0.1)),
      ),
    );
  }

  static phoneField(
      TextEditingController textEditingController, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Icon(
              Icons.phone_android_rounded,
              size: 7.w,
              color: black.withOpacity(0.3),
            ),
          ),
          Expanded(
              child: Center(
            child: TextField(
              style: TextStyle(
                fontSize: 4.w,
                color: black.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              ),
              controller: textEditingController,
              cursorHeight: 7.w,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: "auth2".tr,
                  hintStyle: TextStyle(
                    fontSize: 3.5.w,
                    color: black.withOpacity(0.3),
                    fontWeight: FontWeight.normal,
                  )),
            ),
          )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Container(
                width: 1,
                height: 9.w,
                color: black.withOpacity(0.2),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: Image.asset(
                "assets/images/country_logo.png",
                fit: BoxFit.cover,
                height: 5.w,
                width: 8.w,
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: gTextW("965+", black.withOpacity(0.3), TextAlign.center, 1,
                3.8, FontWeight.normal),
          ),
        ],
      ),
      height: 13.w,
      width: dw(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(width: 2, color: black.withOpacity(0.1)),
      ),
    );
  }

  static passwordField(BuildContext context, AuthController authController,
      TextEditingController textEditingController) {
    return Obx(
      () => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Icon(
                Icons.lock,
                size: 7.w,
                color: black.withOpacity(0.3),
              ),
            ),
            Expanded(
                child: Center(
              child: TextField(
                style: TextStyle(
                    fontSize: 3.5.w,
                    color: black.withOpacity(0.7),
                    fontWeight: FontWeight.normal,
                    letterSpacing: 2),
                controller: textEditingController,
                cursorHeight: 7.w,
                obscuringCharacter: "*",
                obscureText: authController.hidePassword.value,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: "auth3".tr,
                    hintStyle: TextStyle(
                      fontSize: 3.5.w,
                      color: black.withOpacity(0.3),
                      fontWeight: FontWeight.normal,
                    )),
              ),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: InkWell(
                  onTap: () {
                    authController.hidePassword.value =
                        !authController.hidePassword.value;
                  },
                  child: Icon(
                    authController.hidePassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility,
                    size: 7.w,
                    color: black.withOpacity(0.3),
                  )),
            ),
          ],
        ),
        height: 13.w,
        width: dw(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(width: 2, color: black.withOpacity(0.1)),
        ),
      ),
    );
  }

  static submitButton(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.w, bottom: 6.w),
      child: Center(
        child: Container(
          child: Center(
            child:
                gTextW(text, white, TextAlign.center, 1, 3.5, FontWeight.bold),
          ),
          width: dw(context) / 2,
          height: 13.w,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                color: maincolor1.withOpacity(0.5))
          ], color: maincolor1, borderRadius: BorderRadius.circular(30.w)),
        ),
      ),
    );
  }

  static codeEnterForVerification(TextEditingController textEditingController) {
    final defaultPinTheme = PinTheme(
      width: 15.w,
      height: 15.w,
      textStyle:
          TextStyle(fontSize: 6.w, color: white, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: maincolor1,
        ),
        borderRadius: BorderRadius.circular(3.w),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: maincolor1),
      color: maincolor1.withOpacity(0.5),
      borderRadius: BorderRadius.circular(3.w),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: maincolor1,
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: textEditingController,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        errorPinTheme: defaultPinTheme,
        disabledPinTheme: defaultPinTheme,
        followingPinTheme: defaultPinTheme,
        closeKeyboardWhenCompleted: true,
        autofocus: true,
        keyboardType: TextInputType.number,

        validator: (s) {
          print(s);
        },
        // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,

        showCursor: true,
        errorText: "",

        onCompleted: (pin) => print(pin),
      ),
    );
  }
}
