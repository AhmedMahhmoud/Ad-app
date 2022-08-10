import 'dart:io';

import 'package:ads_app/controllers/add_ad/add_ad_controller.dart';
import 'package:ads_app/controllers/more/wallet_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/add/pick_media.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddAdWidget {
  //
  //
//

  static buttonsToAdd(BuildContext context, AddAdController adController) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => adController.mainImage.value.path == "null"
              ? add_image_button(context, true, () {
                  navigateForward(PickMedia(), Transition.downToUp,
                      Curves.easeInOut, 500, [true, false]);
                })
              : InkWell(
                  onTap: () {
                    navigateForward(PickMedia(), Transition.downToUp,
                        Curves.easeInOut, 500, [true, false]);
                  },
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () async {
                          adController.edit_photo(
                              adController.mainImage.value, context, true);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(1.w),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.w),
                                color: white),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.w, horizontal: 1.w),
                              child: Icon(
                                Icons.edit,
                                color: maincolor1,
                                size: 7.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    width: dw(context) / 2.5,
                    height: dw(context) / 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.w),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(
                            adController.mainImage.value.path,
                          )),
                        )),
                  ))),
          add_image_button(context, false, () {
            navigateForward(PickMedia(), Transition.downToUp, Curves.easeInOut,
                500, [false, false]);
          }),
        ],
      ),
    );
  }
//
//

  static post_image_list(BuildContext context, AddAdController adController) {
    return //
        Obx(
      () => adController.otherImages.length == 0
          ? SizedBox()
          : Container(
              width: dw(context),
              height: dw(context) / 2,
              child: Obx(
                () => ListView.builder(
                  itemCount: adController.otherImages.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(parent: ScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    File mediaFile = adController.otherImages[index];
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        child: Container(
                          width: dw(context) / 3,
                          height: dw(context) / 2,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 3.w,
                                  left: 3.w,
                                  child: InkWell(
                                    onTap: () async {
                                      // edit video or image
                                      adController.otherImages.removeAt(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.w),
                                          color: white),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.w, horizontal: 1.w),
                                        child: Icon(
                                          Icons.cancel,
                                          color: maincolor1,
                                          size: 7.w,
                                        ),
                                      ),
                                    ),
                                  )),
                              Positioned(
                                  bottom: 3.w,
                                  right: 3.w,
                                  child: InkWell(
                                    onTap: () async {
                                      adController.edit_photo(
                                          mediaFile, context, false);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.w),
                                          color: white),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.w, horizontal: 1.w),
                                        child: Icon(
                                          Icons.edit,
                                          color: maincolor1,
                                          size: 7.w,
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.w),
                              border: Border.all(width: 3, color: white),
                              color: white,
                              image: DecorationImage(
                                image: FileImage(
                                  File(mediaFile.path),
                                ),
                                fit: BoxFit.cover,
                              )),
                        ));
                  },
                ),
              ),
            ),
    );
  }

//

  static add_image_button(BuildContext context, bool main, Function action) {
    return InkWell(
      onTap: () => action(),
      child: Container(
        height: dw(context) / 4,
        width: dw(context) / 3,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              main ? Icons.add_a_photo : Icons.add,
              size: 8.w,
              color: black,
            ),
            gTextW(main ? "addad99".tr : "addad100".tr, black, TextAlign.center,
                1, 3.3, FontWeight.bold),
          ],
        ),
      ),
    );
  }
  //
  //

  static buildOneField(
      adController,
      BuildContext context,
      String title,
      TextEditingController textEditingController,
      TextInputType textInputType,
      int lines,
      String prefix) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 2.w),
            child: SharedWidgets.sharedTextField(context, textEditingController,
                title, black, textInputType, (s) {}, lines, prefix),
          )),
    );
  }

  static buildFilterTextField(AddAdController adController, Map item,
      BuildContext context, Function actionOnChnage) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.w, left: 5.w, right: 5.w),
      child: Container(
          height: 13.w,
          width: dw(context),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 2.w),
            child: SharedWidgets.sharedTextField(
                context,
                TextEditingController(),
                item["name"],
                black,
                TextInputType.name, (s) {
              actionOnChnage(s);
            }, 1, ""),
          )),
    );
  }

  static buildOneDropdown(AddAdController adController, RxString currenthint,
      List items, BuildContext context, Function actionOnChnage) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Padding(
              padding:
                  EdgeInsets.only(top: 1.w, left: 5.w, right: 5.w, bottom: 1.w),
              child: DropdownButton(
                isExpanded: true,
                elevation: 0,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 8.w,
                  color: black,
                ),
                dropdownColor: white,
                underline: SizedBox(),
                hint: Obx(() => gTextW(currenthint.value.toString(), black,
                    TextAlign.start, 1, 3.3, FontWeight.bold)),
                items: items.map((item) {
                  return DropdownMenuItem(
                      value: item,
                      child: gTextW(item["name"].toString(), black,
                          TextAlign.start, 1, 3.5, FontWeight.bold));
                }).toList(),
                onChanged: (item) => actionOnChnage(item),
              ))),
    );
  }

  static one_package(bool fromApi, bool selected, String title, String value,
      Function actionOnChange) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.w),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            border: Border.all(width: 2, color: black.withOpacity(0.2)),
            color: white),
        child: fromApi == false
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gTextW(
                        title, black, TextAlign.start, 1, 3.5, FontWeight.bold),
                    gTextW("${value} k.D", maincolor1, TextAlign.start, 1, 3.5,
                        FontWeight.bold)
                  ],
                ),
              )
            : ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                leading: Image.asset(
                  "assets/images/mic.png",
                  height: 7.w,
                  width: 7.w,
                  fit: BoxFit.scaleDown,
                ),
                title: gTextW(
                    title, black, TextAlign.start, 1, 3.5, FontWeight.bold),
                subtitle: gTextW("${value} k.D", maincolor1, TextAlign.start, 1,
                    3.5, FontWeight.bold),
                trailing: Switch(
                  value: selected,
                  onChanged: (value) => actionOnChange(value),
                  activeColor: maincolor1,
                ),
              ),
      ),
    );
  }

  static agree_to_terms(bool selected, Function actionOnChange) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gTextW("more33".tr, maincolor1, TextAlign.start, 1, 3.5,
              FontWeight.bold),
          Switch(
            value: selected,
            onChanged: (value) => actionOnChange(value),
            activeColor: maincolor1,
          )
        ],
      ),
    );
  }

  static final_price_row(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        gTextW(title, black, TextAlign.start, 1, 3, FontWeight.bold),
        gTextW(
            "${value} k.D", maincolor1, TextAlign.start, 1, 3, FontWeight.bold)
      ],
    );
  }

  static not_enough_money(BuildContext context, String amount,
      AddAdController adController, WalletController walletController) {
    return showDialog(
        useRootNavigator: true,
        barrierColor: white.withOpacity(0.5),
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: dw(context) - 20.w,
              // height: dw(context) - 20.w,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5.w),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(parent: ScrollPhysics()),
                scrollDirection: Axis.vertical,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.close,
                                color: black,
                                size: 8.w,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Icon(
                      Icons.info_outline,
                      size: 10.w,
                      color: maincolor1,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(0.w),
                      child: gTextW("${"addad20".tr} ${amount} K.D", black,
                          TextAlign.center, 1, 4, FontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.all(5.w),
                    child: InkWell(
                      onTap: () {
                        //
                        adController.chargeAndBack(context, walletController);
                      },
                      child: Container(
                        height: 10.w,
                        width: dw(context) / 3,
                        decoration: BoxDecoration(
                          color: maincolor1,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        child: Center(
                          child: gTextW("addad19".tr, white, TextAlign.center,
                              1, 3, FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
