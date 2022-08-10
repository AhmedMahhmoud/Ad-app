import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/controllers/more/more_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/local_database/local_database.dart';
import 'package:ads_app/services/tabs/chat/chat_services.dart';
import 'package:ads_app/views/auth/login.dart';
import 'package:ads_app/views/more/ads/fav_ads.dart';
import 'package:ads_app/views/more/ads/last_seen_ads.dart';
import 'package:ads_app/views/more/ads/my_ads.dart';
import 'package:ads_app/views/more/ads/static_page.dart';
import 'package:ads_app/views/more/contact.dart';
import 'package:ads_app/views/more/favs.dart';
import 'package:ads_app/views/more/more_widgets.dart';
import 'package:ads_app/views/more/profile/edit_profile.dart';
import 'package:ads_app/views/more/wallet/see_wallet.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:ads_app/views/splash.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

import '../notifications/notification_screen.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  buildDeleteAccountConfirm(
      BuildContext context, FourTabsController fourTabsController) {
    return AwesomeDialog(
      btnCancel: SizedBox(),
      btnOk: SizedBox(),
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      body: Padding(
        padding: EdgeInsets.all(2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: InkWell(
                onTap: () async {
                  deleteThenLogOut(context, fourTabsController);
                },
                child: Container(
                  width: dw(context) / 2,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Center(
                    child: gTextW(
                      "تأكيد",
                      white,
                      TextAlign.center,
                      1,
                      3.5,
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )..show();
  }

  deleteThenLogOut(
      BuildContext context, FourTabsController fourTabsController) async {
    await ChatServices.delete_my_account_service();
    var appBox = await Hive.openBox('app');
    appBox.delete("user");
    await LocalDatabase.notFirstTimeAnyMore();

    fourTabsController.getUserData();
    navigateForwardAndRemoveUntil(
        Splash(), Transition.fadeIn, Curves.easeInOut, 500);
  }

  MoreController moreController = Get.find<MoreController>();
  FourTabsController fourTabsController = Get.find<FourTabsController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: SizedBox(
          width: dw(context),
          height: dh(context),
          child: Stack(
            children: [
              SingleChildScrollView(
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
                          height: 40.w,
                          width: dw(context),
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Positioned(
                                right: 0,
                                left: 0,
                                top: 0,
                                height: 22.w,
                                child: SharedWidgets.pageHeader(
                                    context, "more1".tr, false),
                              ),
                              Positioned(
                                top: 18.w,
                                left: (dw(context) / 2) - 10.w,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: maincolor3,
                                      shape: BoxShape.circle),
                                  height: 20.w,
                                  width: 20.w,
                                  child: Center(
                                    child: SharedWidgets.logo(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        logoText(black, 4),
                        SizedBox(
                          height: 5.w,
                        ),
                        Obx(() => fourTabsController.isLogin.value
                            ? MoreWidgets.listButton(MyAds(), "more2".tr, [])
                            : SizedBox()),
                        Obx(() => fourTabsController.isLogin.value
                            ? MoreWidgets.listButton(
                                SeeWallet(), "more3".tr, [])
                            : SizedBox()),
                        Obx(() => fourTabsController.isLogin.value
                            ? MoreWidgets.listButton(Favs(), "المفضلة", [])
                            : SizedBox()),
                        Obx(() => fourTabsController.isLogin.value
                            ? MoreWidgets.listButton(NotificationScreen(), "الاشعارات", [])
                            : SizedBox()),
                        Obx(() => fourTabsController.isLogin.value
                            ? MoreWidgets.listButton(
                                EditProfile(), "more4".tr, [])
                            : SizedBox()),
                        Obx(() => !fourTabsController.isLogin.value
                            ? MoreWidgets.listButton(
                                Login(true), "auth16".tr, [])
                            : SizedBox()),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8.w, right: 8.w, bottom: 3.w),
                          child: InkWell(
                            onTap: () {
                              fourTabsController.showNavBar.value = false;
                              navigateForward(
                                  LastSeen(),
                                  Transition.leftToRight,
                                  Curves.easeInOut,
                                  500, []);
                            },
                            child: Container(
                              height: 12.w,
                              decoration: BoxDecoration(
                                  color: white,
                                  border:
                                      Border.all(width: 1, color: maincolor2),
                                  borderRadius: BorderRadius.circular(20.w)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    gTextW("شوهد مؤخرا", black, TextAlign.start,
                                        1, 3.8, FontWeight.normal),
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
                        ),
                        MoreWidgets.listButton(Contact(), "تواصل معنا", []),
                        MoreWidgets.listButton(
                            StaticPage(), "more5".tr, ["2", "more5".tr]),
                        MoreWidgets.listButton(
                            StaticPage(), "more6".tr, ["1", "more6".tr]),
                        MoreWidgets.languageButton(fourTabsController),
                        Obx(() => fourTabsController.isLogin.value
                            ? MoreWidgets.logOut(moreController)
                            : SizedBox()),
                        Obx(() => fourTabsController.isLogin.value
                            ? Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      buildDeleteAccountConfirm(
                                          context, fourTabsController);
                                    },
                                    child: Container(
                                      width: dw(context),
                                      height: 10.w,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                      ),
                                      child: Center(
                                        child: gTextW(
                                          "Delete My Account",
                                          white,
                                          TextAlign.center,
                                          1,
                                          3.5,
                                          FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox()),
                        SizedBox(
                          height: 20.w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
