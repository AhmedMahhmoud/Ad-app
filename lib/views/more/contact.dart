import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/controllers/more/contact_controller.dart';
import 'package:ads_app/controllers/more/more_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/auth/login.dart';
import 'package:ads_app/views/more/ads/fav_ads.dart';
import 'package:ads_app/views/more/ads/last_seen_ads.dart';
import 'package:ads_app/views/more/ads/my_ads.dart';
import 'package:ads_app/views/more/ads/static_page.dart';
import 'package:ads_app/views/more/favs.dart';
import 'package:ads_app/views/more/more_widgets.dart';
import 'package:ads_app/views/more/profile/edit_profile.dart';
import 'package:ads_app/views/more/wallet/see_wallet.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  ContactController contactController = Get.put(ContactController());

  build_one_item_for_social(
      IconData iconData, Color color, String linkToLaunch, Color iconcolor) {
    return InkWell(
      onTap: () async {
        await launch(linkToLaunch);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Icon(
            iconData,
            color: iconcolor,
            size: 9.w,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: SizedBox(
          width: dw(context),
          height: dh(context),
          child: Obx(
            () => contactController.loading.value
                ? SpinKitCircle(
                    color: maincolor1,
                    size: 8.w,
                  )
                : SingleChildScrollView(
                    physics: ScrollPhysics(parent: ScrollPhysics()),
                    child: AnimationLimiter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: Duration(milliseconds: 800),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 200.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            Container(
                              height: 22.w,
                              width: dw(context),
                              color: Colors.transparent,
                              child: SharedWidgets.pageHeader(
                                  context, "تواصل معنا", true),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            SharedWidgets.logo(),
                            SizedBox(
                              height: 10.w,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: gTextW("تابعنا على ", black,
                                  TextAlign.start, 1, 3.5, FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(parent: ScrollPhysics()),
                                scrollDirection: Axis.vertical,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: build_one_item_for_social(
                                            FontAwesomeIcons.facebook,
                                            Colors.blue.shade900,
                                            contactController.links["facebook"],
                                            white),
                                      ),
                                      Expanded(
                                        child: build_one_item_for_social(
                                            FontAwesomeIcons.instagram,
                                            Color.fromRGBO(193, 58, 180, 1),
                                            contactController
                                                .links["instgrame"],
                                            white),
                                      ),
                                      Expanded(
                                        child: build_one_item_for_social(
                                            FontAwesomeIcons.snapchat,
                                            Color.fromRGBO(255, 252, 0, 1),
                                            contactController.links["snapchat"],
                                            black.withOpacity(0.8)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: build_one_item_for_social(
                                            FontAwesomeIcons.twitter,
                                            Color.fromRGBO(29, 161, 242, 1),
                                            contactController.links["twitter"],
                                            white),
                                      ),
                                      Expanded(
                                        child: build_one_item_for_social(
                                            FontAwesomeIcons.linkedin,
                                            Colors.blue,
                                            contactController.links["linkedin"],
                                            white),
                                      ),
                                      Expanded(child: SizedBox())
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await launch(
                                        "tel:${contactController.links["mobile"]}");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1, color: maincolor1),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(3.w),
                                      child: Icon(
                                        Icons.phone,
                                        size: 6.w,
                                        color: maincolor1,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final link = WhatsAppUnilink(
                                      phoneNumber:
                                          contactController.links['mobile'],
                                      text: "",
                                    );
                                    // Convert the WhatsAppUnilink instance to a string.
                                    // Use either Dart's string interpolation or the toString() method.
                                    // The "launch" method is part of "url_launcher".
                                    await launch('$link');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1, color: maincolor1),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(3.w),
                                      child: Icon(
                                        Icons.whatsapp,
                                        size: 6.w,
                                        color: maincolor1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: gTextW("نحن نسمعك", black, TextAlign.start,
                                  1, 3.5, FontWeight.bold),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.w),
                                child: Container(
                                  height: 35.w,
                                  width: dw(context),
                                  decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(
                                          width: 1, color: maincolor1),
                                      borderRadius: BorderRadius.circular(3.w)),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: TextField(
                                      maxLines: 5,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        color: black.withOpacity(0.7),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      controller: contactController.msg,
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
                                          hintText: "اكتب رسالتك هنا",
                                          hintStyle: TextStyle(
                                            fontSize: 3.5.w,
                                            color: black.withOpacity(0.3),
                                            fontWeight: FontWeight.normal,
                                          )),
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 8.w, bottom: 6.w),
                              child: Obx(
                                () => contactController.send_loading.value
                                    ? SpinKitCircle(
                                        color: maincolor1,
                                        size: 10.w,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          //
                                          contactController.send_msg();
                                          //
                                        },
                                        child: Container(
                                          child: Center(
                                            child: gTextW(
                                                "إرسال",
                                                white,
                                                TextAlign.center,
                                                1,
                                                3.5,
                                                FontWeight.bold),
                                          ),
                                          width: dw(context) / 2,
                                          height: 13.w,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 2,
                                                    spreadRadius: 2,
                                                    color: maincolor1
                                                        .withOpacity(0.5))
                                              ],
                                              color: maincolor1,
                                              borderRadius:
                                                  BorderRadius.circular(30.w)),
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20.w,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
