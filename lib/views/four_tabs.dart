import 'dart:developer';

import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/controllers/more/more_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/add/add_ad.dart';
import 'package:ads_app/views/auth/login.dart';
import 'package:ads_app/views/chat/all_chats.dart';
import 'package:ads_app/views/four_tabs_widgets.dart';
import 'package:ads_app/views/home/home.dart';
import 'package:ads_app/views/more/more.dart';
import 'package:ads_app/views/more/more_widgets.dart';
import 'package:ads_app/views/offer/all_offers.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

import 'one_ad/one_ad.dart';

class FourTabs extends StatefulWidget {
  @override
  _FourTabsState createState() => _FourTabsState();
}

class _FourTabsState extends State<FourTabs> {
  final FourTabsController fourTabsController = Get.find<FourTabsController>();
  MoreController moreController = Get.put(MoreController());

  List<Widget> buildFourTabsScreen() {
    return [
      More(),
      AllChats(),
      AllOffers(),
      Home(),
    ];
  }

  List<Widget> buildFourTabsScreenNotLogin() {
    return [
      More(),
      Login(false),
      AllOffers(),
      Home(),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    checkForegroundNotification();
    super.initState();
  }

  checkForegroundNotification() {
    FirebaseMessaging.instance.getInitialMessage().then((notification) async {
      log("####Recveiving data on message tapped ####");
      if (notification != null)
        Get.to(
          OneAd(id: notification.data['id'].toString()),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dh(context),
      width: dw(context),
      color: Colors.white,
      child: Stack(
        children: [
          Obx(
            () => PersistentTabView(
              context,

              controller: fourTabsController.persistentTabController,

              screens: fourTabsController.isLogin.value
                  ? buildFourTabsScreen()
                  : buildFourTabsScreenNotLogin(),
              items: navBarsIcons(),
              confineInSafeArea: true,
              hideNavigationBar: true,
              navBarHeight: 12.w,

              backgroundColor: Colors.white, // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset:
                  true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardShows:
                  true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(0.0),
                colorBehindNavBar: white,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: ItemAnimationProperties(
                // Navigation Bar's items animation properties.

                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              screenTransitionAnimation: ScreenTransitionAnimation(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,

                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 300),
              ),
              navBarStyle: NavBarStyle
                  .style11, // Choose the nav bar style with this property.
            ),
          ),
          // the real tabs that with appear
          buildTheRealNavBar(
              context,
              fourTabsController.persistentTabController,
              fourTabsController,
              false),
          Positioned(
            bottom: 10.w,
            left: (dw(context) / 2) - 7.5.w,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => navigateForward(
                    fourTabsController.isLogin.value ? AddAd() : Login(true),
                    Transition.downToUp,
                    Curves.easeInOut,
                    500, []),
                child: Container(
                  decoration:
                      BoxDecoration(color: maincolor1, shape: BoxShape.circle),
                  width: 15.w,
                  height: 15.w,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 8.w,
                      color: white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Material(
              color: Colors.transparent,
              child: Obx(() => moreController.showLogOutDialog.value
                  ? MoreWidgets.show_log_out_dialog(context, moreController)
                  : SizedBox()))
        ],
      ),
    );
  }
}
