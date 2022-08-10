import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/controllers/more/more_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/local_database/local_database.dart';
import 'package:ads_app/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

FourTabsController fourTabsController = Get.find<FourTabsController>();

class MoreWidgets {
  static listButton(Widget page, String title, var args) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 3.w),
      child: InkWell(
        onTap: () {
          navigateForward(
              page, Transition.leftToRight, Curves.easeInOut, 500, args);
        },
        child: Container(
          height: 12.w,
          decoration: BoxDecoration(
              color: white,
              border: Border.all(width: 1, color: maincolor2),
              borderRadius: BorderRadius.circular(20.w)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gTextW(
                    title, black, TextAlign.start, 1, 3.8, FontWeight.normal),
                Icon(
                  Icons.arrow_forward_ios,
                  color: maincolor1,
                  size: 5.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static logOut(
    MoreController moreController,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 8.w, top: 4.w),
      child: InkWell(
        onTap: () => moreController.showLogOutDialog.value = true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              gTextW("more7".tr, maincolor1, TextAlign.start, 1, 3.8,
                  FontWeight.normal),
              SizedBox(
                width: 5.w,
              ),
              Icon(
                FontAwesomeIcons.arrowAltCircleLeft,
                color: maincolor1,
                size: 6.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static show_log_out_dialog(
      BuildContext context, MoreController moreController) {
    return InkWell(
      onTap: () => moreController.showLogOutDialog.value = false,
      child: Container(
        height: dh(context),
        width: dw(context),
        color: black.withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: dw(context),
                  height: dw(context) / 2,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: gTextW("more8".tr, black, TextAlign.center, 1,
                            3.3, FontWeight.bold),
                      )),
                      Expanded(
                          child: Align(
                        alignment: Alignment.topCenter,
                        child: gTextW("more9".tr, black.withOpacity(0.5),
                            TextAlign.center, 1, 3, FontWeight.bold),
                      )),
                      Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                fourTabsController.logOut();
                              },
                              child: Container(
                                height: 10.w,
                                width: dw(context) / 4,
                                decoration: BoxDecoration(
                                    color: maincolor1,
                                    border:
                                        Border.all(width: 1, color: maincolor1),
                                    borderRadius: BorderRadius.circular(3.w)),
                                child: Center(
                                  child: gTextW(
                                      "more10".tr,
                                      white,
                                      TextAlign.center,
                                      1,
                                      3.8,
                                      FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              onTap: () =>
                                  moreController.showLogOutDialog.value = false,
                              child: Container(
                                height: 10.w,
                                width: dw(context) / 4,
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(width: 1, color: black),
                                    borderRadius: BorderRadius.circular(3.w)),
                                child: Center(
                                  child: gTextW(
                                      "more11".tr,
                                      black,
                                      TextAlign.center,
                                      1,
                                      3.8,
                                      FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static languageButton(FourTabsController fourTabsController) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 3.w),
      child: Container(
        height: 12.w,
        decoration: BoxDecoration(
            color: white,
            border: Border.all(width: 1, color: maincolor2),
            borderRadius: BorderRadius.circular(20.w)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              gTextW(
                  "اللغة", black, TextAlign.start, 1, 3.8, FontWeight.normal),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  //

                  Obx(
                    () => InkWell(
                        onTap: () {
                          fourTabsController.changeLanguage("ar");
                        },
                        child: Container(
                          child: gTextW(
                              "ع",
                              fourTabsController.lang.value == "ar"
                                  ? white
                                  : maincolor1,
                              TextAlign.center,
                              1,
                              4,
                              FontWeight.bold),
                          height: 8.w,
                          width: 10.w,
                          decoration: BoxDecoration(
                              color: fourTabsController.lang.value == "ar"
                                  ? maincolor1
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(1.w),
                              border: Border.all(width: 1, color: maincolor1)),
                        )),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        fourTabsController.changeLanguage("en");
                      },
                      child: Container(
                        child: gTextW(
                            "EN",
                            fourTabsController.lang.value == "ar"
                                ? maincolor1
                                : white,
                            TextAlign.center,
                            1,
                            4,
                            FontWeight.bold),
                        height: 8.w,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: fourTabsController.lang.value == "ar"
                                ? Colors.transparent
                                : maincolor1,
                            borderRadius: BorderRadius.circular(1.w),
                            border: Border.all(width: 1, color: maincolor1)),
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
