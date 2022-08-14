import 'dart:convert';

import 'package:ads_app/services/tabs/ad/add_display.dart';
import 'package:ads_app/controllers/chat/all_chats_controller.dart';
import 'package:ads_app/controllers/one_ad_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/fullPageImage.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/local_database/local_database.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/views/chat/one_chat.dart';
import 'package:ads_app/views/one_ad/edit_ad.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class OneAdWidgets {
//
//
//
  static bottom_bar(OneAdController oneAdController) {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        height: 15.w,
        child: Container(
          color: maincolor1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                gTextW(
                    "addad3".tr, white, TextAlign.start, 1, 4, FontWeight.bold),
                SizedBox(
                  width: 5.w,
                ),
                gTextW("${oneAdController.ad.value?.price} K.D", white,
                    TextAlign.start, 1, 4, FontWeight.bold),

                Expanded(child: SizedBox()),

                InkWell(
                  onTap: () {
                    DisplayAd.displayAd(oneAdController.ad.value?.sellerPhone);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.5.w, horizontal: 2.w),
                      child: Icon(
                        FontAwesomeIcons.whatsapp,
                        size: 6.w,
                        color: maincolor1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                InkWell(
                  onTap: () async {
                    await launch(
                        'tel:${oneAdController.ad.value?.sellerPhone}');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.5.w, horizontal: 2.w),
                      child: Icon(
                        Icons.phone,
                        size: 6.w,
                        color: maincolor1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Obx(() => fourTabsController.isLogin.value
                    ? InkWell(
                        onTap: () async {
                          bool done = Get.isRegistered<AllChatsController>();

                          if (done) {
                            AllChatsController allChatsController =
                                Get.find<AllChatsController>();
                            allChatsController.getOneChatMessages(
                                oneAdController.ad.value!.sellerId.toString());
                            allChatsController.reciverMap.value = {
                              "image": oneAdController.ad.value?.imageSeller,
                              "name": oneAdController.ad.value?.seller,
                              "id": oneAdController.ad.value?.sellerId,
                            };
                            navigateForward(OneChat(), Transition.fadeIn,
                                Curves.easeInOut, 500, [
                              {
                                "id": oneAdController.ad.value?.sellerId,
                                "image": oneAdController.ad.value?.imageSeller,
                                "name": oneAdController.ad.value?.seller,
                              }
                            ]);
                          } else {
                            AllChatsController allChatsController =
                                Get.put(AllChatsController());
                            allChatsController.getOneChatMessages(
                                oneAdController.ad.value!.sellerId.toString());
                            allChatsController.reciverMap.value = {
                              "id": oneAdController.ad.value?.sellerId,
                              "image": oneAdController.ad.value?.imageSeller,
                              "name": oneAdController.ad.value?.seller,
                            };
                            navigateForward(OneChat(), Transition.fadeIn,
                                Curves.easeInOut, 500, [
                              {
                                "id": oneAdController.ad.value?.sellerId,
                                "image": oneAdController.ad.value?.imageSeller,
                                "name": oneAdController.ad.value?.seller,
                              }
                            ]);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.5.w, horizontal: 2.w),
                            child: Icon(
                              Icons.chat_rounded,
                              size: 6.w,
                              color: maincolor1,
                            ),
                          ),
                        ))
                    : SizedBox())
              ],
            ),
          ),
        ));
  }

  static header_slider(BuildContext context, OneAdController oneAdController) {
    return Container(
      height: dh(context) / 3,
      width: dw(context),
      color: Colors.white,
      child: FlutterCarousel(
          items: oneAdController.images.map((item) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: InkWell(
                  onTap: () {
                    navigateForward(FullPageImage(oneAdController.images),
                        Transition.fadeIn, Curves.easeInOut, 500, []);
                  },
                  child: buildNetworkImage(context, item, 0.w, 0.w, 0.w, 0.w,
                      dh(context) / 3, dw(context), BoxFit.cover),
                ));
          }).toList(),
          options: CarouselOptions(
            scrollPhysics: ScrollPhysics(parent: ScrollPhysics()),
            height: dh(context) / 3,
            aspectRatio: 1,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            onPageChanged: (s, c) {},
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayOnManualNavigate: true,
            pauseAutoPlayInFiniteScroll: false,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            disableCenter: false,
            showIndicator: true,
            slideIndicator: CircularSlideIndicator(
              padding: EdgeInsets.only(bottom: 16.w),
              indicatorBackgroundColor: white,
              itemSpacing: 12,
              currentIndicatorColor: Colors.orange,
              indicatorBorderColor: white,
              indicatorBorderWidth: 1,
              indicatorRadius: 1.w,
            ),
          )),
    );
  }

  static header(BuildContext context, OneAdController oneAdController) {
    return SizedBox(
      width: dw(context),
      height: dh(context) / 3,
      child: Stack(
        children: [
          OneAdWidgets.header_slider(context, oneAdController),

          //
          Positioned(
              bottom: 0.w,
              child: Container(
                decoration: BoxDecoration(
                    color: maincolor3,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150.w),
                        topRight: Radius.circular(150.w))),
                width: dw(context),
                height: 14.w,
                child: Padding(
                  padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.w),
                  child: ListTile(
                    title: gTextW("${oneAdController.ad.value?.name}", black,
                        TextAlign.start, 2, 3.4, FontWeight.bold),
                    trailing: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Obx(
                        () => InkWell(
                          onTap: () async {
                            bool add = fourTabsController.favs
                                    .indexOf(json.encode(oneAdController.ad)) ==
                                -1;
                            add
                                ? fourTabsController.favs
                                    .add(json.encode(oneAdController.ad))
                                : fourTabsController.favs
                                    .remove(json.encode(oneAdController.ad));
                            await LocalDatabase.addOrRemoveFav(
                                json.encode(oneAdController.ad), add);
                            List ss = await LocalDatabase.getAllfavs();

                            print(ss.length);
                          },
                          child: Icon(
                            fourTabsController.favs.indexOf(
                                        json.encode(oneAdController.ad)) ==
                                    -1
                                ? Icons.favorite_border
                                : Icons.favorite,
                            color: maincolor1,
                            size: 8.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),

          //
          Positioned(
              top: 2.w,
              child: SizedBox(
                width: dw(context),
                height: 12.w,
                child: ListTile(
                  leading: InkWell(
                    onTap: () {
                      navigateBack(context);
                    },
                    child: Container(
                      height: 10.w,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Icon(
                          Icons.arrow_back,
                          color: black.withOpacity(0.6),
                          size: 6.w,
                        ),
                      ),
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Share.share(
                          "${oneAdController.ad.value?.name} \n ${oneAdController.ad.value!.content} \n ${oneAdController.ad.value!.image} \n ${oneAdController.ad.value!.price} دك \n ${oneAdController.ad.value!.data} \n  ${oneAdController.ad.value!.government} \n ${oneAdController.ad.value!.region} \n ${oneAdController.ad.value?.seller} \n ${oneAdController.ad.value?.imageSeller} \n ${oneAdController.ad.value!.sellerPhone} \n   ${oneAdController.ad.value!.details} \n ");
                    },
                    child: Container(
                      height: 10.w,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Icon(
                          Icons.file_upload_outlined,
                          color: black.withOpacity(0.6),
                          size: 6.w,
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  static seller(BuildContext context, OneAdController oneAdController) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // buildNetworkImage(context, oneAdController.ad.value?.imageSeller, 50.w,
          //     50.w, 50.w, 50.w, 12.w, 12.w, BoxFit.cover),
          SizedBox(
            width: 2.w,
          ),
          gTextW(oneAdController.ad.value!.seller, black, TextAlign.start, 1,
              3.5, FontWeight.bold),
          Expanded(child: SizedBox()),
          fourTabsController.userMap["id"].toString() !=
                  oneAdController.ad.value?.sellerId.toString()
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: InkWell(
                    onTap: () {
                      navigateForward(EditAd(), Transition.downToUp,
                          Curves.easeInOut, 500, [oneAdController.ad]);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 7.w,
                      color: maincolor1,
                    ),
                  ),
                ),
          fourTabsController.userMap["id"].toString() !=
                  oneAdController.ad.value?.sellerId.toString()
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: InkWell(
                    onTap: () {
                      oneAdController.showDeleteDialog.value = true;
                      //
                    },
                    child: Icon(
                      Icons.delete,
                      size: 8.w,
                      color: Colors.red,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  static show_delete_dialog(
      BuildContext context, OneAdController oneAdController) {
    return InkWell(
      onTap: () => oneAdController.showDeleteDialog.value = false,
      child: Container(
        height: dh(context),
        width: dw(context),
        color: black.withOpacity(0.3),
        child: Obx(
          () => oneAdController.loading_deleteing.value
              ? Center(
                  child: SpinKitCircle(
                  color: maincolor1,
                  size: 10.w,
                ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.w),
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
                                child: gTextW(
                                    "هل تريد حقا حذف الإعلان ؟",
                                    black,
                                    TextAlign.center,
                                    1,
                                    3.3,
                                    FontWeight.bold),
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
                                        oneAdController.delete_this_Ad(context);
                                      },
                                      child: Container(
                                        height: 10.w,
                                        width: dw(context) / 4,
                                        decoration: BoxDecoration(
                                            color: maincolor1,
                                            border: Border.all(
                                                width: 1, color: maincolor1),
                                            borderRadius:
                                                BorderRadius.circular(3.w)),
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
                                      onTap: () => oneAdController
                                          .showDeleteDialog.value = false,
                                      child: Container(
                                        height: 10.w,
                                        width: dw(context) / 4,
                                        decoration: BoxDecoration(
                                            color: white,
                                            border: Border.all(
                                                width: 1, color: black),
                                            borderRadius:
                                                BorderRadius.circular(3.w)),
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
      ),
    );
  }

  static time_location(BuildContext context, OneAdController oneAdController) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          oneAdController.ad.value!.government.toString().length > 0
              ? Icon(
                  Icons.location_on,
                  size: 5.w,
                  color: maincolor1,
                )
              : SizedBox(),
          SizedBox(
            width: 2.w,
          ),
          oneAdController.ad.value!.government.toString().length > 0
              ? gTextW(
                  "${oneAdController.ad.value!.government} - ${oneAdController.ad.value!.region}",
                  black,
                  TextAlign.start,
                  1,
                  3,
                  FontWeight.normal)
              : SizedBox(),
          Expanded(child: SizedBox()),
          Icon(
            Icons.timer_outlined,
            size: 5.w,
            color: maincolor1,
          ),
          SizedBox(
            width: 2.w,
          ),
          gTextW(oneAdController.ad.value!.data, black, TextAlign.start, 1, 3,
              FontWeight.normal),
        ],
      ),
    );
  }

  static description(BuildContext context, OneAdController oneAdController) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(width: 1, color: black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: ListTile(
          title: gTextW(
              "home7".tr, black, TextAlign.start, 1, 3.5, FontWeight.normal),
          subtitle: gTextW(
              oneAdController.ad.value!.content,
              black.withOpacity(0.6),
              TextAlign.start,
              50,
              3.5,
              FontWeight.normal),
        ),
      ),
    );
  }

  static options(BuildContext context, OneAdController oneAdController) {
    return oneAdController.ad.value!.details != null &&
            oneAdController.ad.value!.details != "null"
        ? Padding(
            padding: EdgeInsets.all(5.w),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                border: Border.all(width: 1, color: black.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: ListTile(
                title: gTextW("home8".tr, black, TextAlign.start, 1, 3.5,
                    FontWeight.normal),
                subtitle: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 3),
                    shrinkWrap: true,
                    physics: ScrollPhysics(parent: ScrollPhysics()),
                    scrollDirection: Axis.vertical,
                    itemCount: oneAdController.ad.value?.details?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Map item =
                          oneAdController.ad.value!.details![index] as Map;
                      String title = item
                          .toString()
                          .substring(1, item.toString().length - 1)
                          .split(":")
                          .first;
                      String value = item
                          .toString()
                          .substring(1, item.toString().length - 1)
                          .split(":")
                          .last;
                      return SizedBox(
                        width: dw(context) / 2.2,
                        height: 10.w,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                            ),
                            child: Row(
                              mainAxisAlignment: index % 2 == 0
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                gTextW(title, black, TextAlign.start, 1, 3,
                                    FontWeight.normal),
                                SizedBox(
                                  width: 2.w,
                                ),
                                gTextW(value, maincolor1, TextAlign.start, 1, 3,
                                    FontWeight.bold)
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          )
        : SizedBox();
  }
}
