import 'dart:io';

import 'package:ads_app/controllers/more/profile_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/fullPageImage.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfileWidgets {
  static profile_image(String imagePath, ProfileController profileController,
      BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: InkWell(
        onTap: () {
          navigateForward(FullPageImage([imagePath]), Transition.fadeIn,
              Curves.easeInOut, 500, []);
        },
        child: Container(
          height: 40.w,
          width: 40.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: maincolor1.withOpacity(0.6)),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                onTap: () {
                  //

                  profileController.edit(context);
                },
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: maincolor1),
                    child: Padding(
                      padding: EdgeInsets.all(1.w),
                      child: Icon(
                        Icons.edit,
                        size: 6.w,
                        color: white,
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static passwordField(
    BuildContext context,
    ProfileController profileController,
    TextEditingController textEditingController,
    String hint,
  ) {
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
                obscureText: profileController.hidePassword.value,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: hint,
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
                    profileController.hidePassword.value =
                        !profileController.hidePassword.value;
                  },
                  child: Icon(
                    profileController.hidePassword.value
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
}
