import 'package:ads_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SharedWidgets {
//

  static pageHeaderBGImage(BuildContext context) {
    return Image.asset(
      "assets/images/header_bg.png",
      repeat: ImageRepeat.noRepeat,
      fit: BoxFit.cover,
      width: dw(context),
      height: 22.w,
    );
  }

  static pageHeaderListTile(BuildContext context, String title, bool goBack) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        !goBack
            ? SizedBox()
            : InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 6.w,
                  color: white,
                ),
              ),
        SizedBox(
          width: 4.w,
        ),
        gTextW(title, white, TextAlign.start, 1, 4, FontWeight.bold),
      ],
    );
  }

  static pageHeader(BuildContext context, String title, bool goBack) {
    return SizedBox(
      height: 22.w,
      width: dw(context),
      child: Stack(
        children: [
          SharedWidgets.pageHeaderBGImage(context),
          Positioned(
            bottom: 2.w,
            left: 4.w,
            right: 4.w,
            child: SharedWidgets.pageHeaderListTile(context, title, goBack),
          )
        ],
      ),
    );
  }

  static logo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.w),
      child: Image.asset(
        "assets/images/logo.jpeg",
        fit: BoxFit.fitWidth,
        height: 17.w,
        width: 17.w,
      ),
    );
  }

  static sharedTextField(
      BuildContext context,
      TextEditingController textEditingController,
      String hintText,
      Color textColor,
      TextInputType textInputType,
      Function onChange,
      int lines,
      String suffix) {
    return TextField(
      onChanged: (ss) => onChange(ss),
      style: TextStyle(
          fontSize: 3.5.w,
          color: textColor,
          fontWeight: FontWeight.normal,
          letterSpacing: 2),
      controller: textEditingController,
      cursorHeight: 7.w,
      cursorColor: Colors.grey,
      keyboardType: textInputType,
      maxLines: lines,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
          suffixIcon: gTextW(suffix, textColor.withOpacity(0.3),
              TextAlign.start, 1, 4, FontWeight.bold),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 3.5.w,
            color: textColor.withOpacity(0.5),
            fontWeight: FontWeight.normal,
          )),
    );
  }

//
//
//
}
