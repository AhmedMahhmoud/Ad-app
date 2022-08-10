import 'package:ads_app/controllers/chat/all_chats_controller.dart';
import 'package:ads_app/controllers/more/my_ads_controller.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/views/chat/one_chat.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/tabs/ad/add_display.dart';
import '../../../helpers/constants.dart';

class AdsWidgets {
  //

  static one_ad_image(BuildContext context, String image, bool consted) {
    return Expanded(
        flex: 1,
        child: Stack(
          children: [
            buildNetworkImageWithoutCache(
                context, image, 3.w, 3.w, 0.w, 0.w, 100.w, 100.w, BoxFit.cover),
            Positioned(
              top: 1.w,
              right: 1.w,
              left: 1.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  consted
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Image.asset(
                            "assets/images/pin_3.png",
                            height: 7.w,
                            width: 7.w,
                            fit: BoxFit.scaleDown,
                          ))
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ));
  }

  static one_ad_contact(BuildContext context, Map ad) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.w, horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => fourTabsController.isLogin.value
                  ? InkWell(
                      onTap: () async {
                        bool done = Get.isRegistered<AllChatsController>();
                        if (done) {
                          AllChatsController allChatsController =
                              Get.find<AllChatsController>();
                          allChatsController
                              .getOneChatMessages(ad["seller_id"].toString());
                          allChatsController.reciverMap.value = {
                            "image": ad["imageSeller"],
                            "name": ad["seller"],
                            "id": ad["seller_id"].toString(),
                          };
                          navigateForward(OneChat(), Transition.fadeIn,
                              Curves.easeInOut, 500, [
                            {
                              "image": ad["imageSeller"],
                              "name": ad["seller"],
                              "id": ad["seller_id"].toString(),
                            }
                          ]);
                        } else {
                          AllChatsController allChatsController =
                              Get.put(AllChatsController());
                          allChatsController
                              .getOneChatMessages(ad["seller_id"].toString());
                          allChatsController.reciverMap.value = {
                            "image": ad["imageSeller"],
                            "name": ad["seller"],
                            "id": ad["seller_id"].toString(),
                          };
                          navigateForward(OneChat(), Transition.fadeIn,
                              Curves.easeInOut, 500, [
                            {
                              "image": ad["imageSeller"],
                              "name": ad["seller"],
                              "id": ad["seller_id"].toString(),
                            }
                          ]);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.5.w),
                            border: Border.all(width: 1, color: maincolor1)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.w),
                          child: Icon(
                            Icons.chat_rounded,
                            color: maincolor1,
                            size: 4.8.w,
                          ),
                        ),
                      ),
                    )
                  : SizedBox()),
              InkWell(
                onTap: () {
                  DisplayAd.displayAd(ad['seller_phone']);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.5.w),
                      border: Border.all(width: 1, color: maincolor1)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.w),
                    child: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: maincolor1,
                      size: 5.w,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await launch('tel:${ad['seller_phone']}');
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.5.w),
                      border: Border.all(width: 1, color: maincolor1)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.w),
                    child: Icon(
                      FontAwesomeIcons.phoneAlt,
                      color: maincolor1,
                      size: 4.8.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(3.w),
                bottomRight: Radius.circular(3.w))),
      ),
      flex: 1,
    );
  }

  static one_ad_time(String date) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w, right: 1.w, top: 2.w, bottom: 1.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.timer,
            size: 4.5.w,
            color: maincolor1,
          ),
          SizedBox(
            width: 0.5.w,
          ),
          gTextW(date, black.withOpacity(0.3), TextAlign.start, 1, 2.8,
              FontWeight.bold),
        ],
      ),
    );
  }

  static one_ad_location(bool isMine, Map ad) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w, right: 1.w, top: 2.w, bottom: 1.w),
      child: Container(
        decoration: isMine
            ? BoxDecoration()
            : BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(width: 1, color: black.withOpacity(0.2)))),
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ad["government"].toString().trim().length > 0 &&
                          ad["government"].toString().trim() != "null"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 4.5.w,
                              color: red,
                            ),
                            SizedBox(
                              width: 0.5.w,
                            ),
                            gTextW(
                                " ${ad["government"]} \n ${ad["region"]}",
                                black.withOpacity(0.3),
                                TextAlign.start,
                                1,
                                2.5,
                                FontWeight.bold),
                          ],
                        )
                      : SizedBox()),
              gTextW("${ad['price']} k.D", maincolor1, TextAlign.start, 1, 3,
                  FontWeight.bold),
            ],
          ),
        ),
      ),
    );
  }

  static status_title_to_show(bool selected, String title, int indexToPut,
      MyAdsController myAdsController) {
    return Expanded(
      child: InkWell(
        onTap: () {
          myAdsController.whichTypeToShow.value = indexToPut;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.w),
              color: selected ? maincolor1 : white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.w),
              child: gTextW(title, selected ? white : black, TextAlign.center,
                  1, 3.5, FontWeight.normal),
            ),
          ),
        ),
      ),
      flex: 1,
    );
  }

  static one_ad(BuildContext context, bool ss, Map ad, bool consted) {
    bool isMine = fourTabsController.isLogin.value
        ? fourTabsController.userMap["id"] == ad["seller_id"]
            ? true
            : false
        : false;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 1.w),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            one_ad_image(context, ad["image"], consted),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          one_ad_time(ad["data"]),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: gTextW(ad["name"], black, TextAlign.start, 1,
                                3.2, FontWeight.normal),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: gTextW(
                                "${ad["content"]}",
                                black.withOpacity(0.7),
                                TextAlign.start,
                                1,
                                2.8,
                                FontWeight.normal),
                          ),
                          one_ad_location(isMine, ad),
                        ],
                      ),
                      flex: 3,
                    ),
                    // isMine ? SizedBox() :
                    one_ad_contact(context, ad),
                  ],
                )),
          ],
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 1, spreadRadius: 1, color: black.withOpacity(0.1))
        ], borderRadius: BorderRadius.circular(3.w), color: white),
      ),
    );
  }
  //
}
