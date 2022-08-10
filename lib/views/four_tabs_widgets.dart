import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

buildTabIcon(IconData iconData) {
  return PersistentBottomNavBarItem(
    icon: Icon(
      iconData,
      color: white,
    ),
    title: ("sss"),
    textStyle: TextStyle(
        color: Colors.transparent,
        fontSize: 1,
        backgroundColor: Colors.transparent,
        decorationColor: Colors.transparent),
    iconSize: 8.w,
    activeColorPrimary: black,
    inactiveColorPrimary: black.withOpacity(0.5),
  );
}

oneTapInFourTabs(
    BuildContext context,
    PersistentTabController persistentTabController,
    int index,
    FourTabsController fourTabsController,
    String title,
    bool selected,
    IconData iconData,
    bool backfirst) {
  return Expanded(
      flex: 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (backfirst) {
              navigateBack(context);
            }
            persistentTabController.jumpToTab(index);
            fourTabsController.selectedIndex.value = index;
          },
          child: Container(
            width: dw(context) / 5,
            height: 17.w,
            color: white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    child: Icon(
                  iconData,
                  size: 6.5.w,
                  color: selected ? maincolor1 : black.withOpacity(0.3),
                )),
                gTextW(title, selected ? maincolor1 : black.withOpacity(0.3),
                    TextAlign.center, 1, 2.8, FontWeight.bold)
              ],
            ),
          ),
        ),
      ));
}

List<PersistentBottomNavBarItem> navBarsIcons() {
  return [
    buildTabIcon(Icons.home),
    buildTabIcon(Icons.ondemand_video_outlined),
    buildTabIcon(Icons.add),
    buildTabIcon(Icons.person_pin_rounded),
  ];
}

buildTheRealNavBar(
    BuildContext context,
    PersistentTabController persistentTabController,
    FourTabsController fourTabsController,
    bool backFirst) {
  return Positioned(
    left: 0,
    right: 0,
    bottom: 0,
    height: 20.w,
    child: Container(
      width: dw(context),
      height: 20.w,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: dw(context),
              height: 17.w,
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    oneTapInFourTabs(
                        context,
                        persistentTabController,
                        3,
                        fourTabsController,
                        "four1".tr,
                        fourTabsController.selectedIndex.value == 3,
                        Icons.home,
                        backFirst),
                    oneTapInFourTabs(
                        context,
                        persistentTabController,
                        2,
                        fourTabsController,
                        "four2".tr,
                        fourTabsController.selectedIndex.value == 2,
                        Icons.local_offer_outlined,
                        backFirst),
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          width: dw(context) / 5,
                          height: 18.w,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 2.5.w),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: gTextW("addad1".tr, black.withOpacity(0.4),
                                  TextAlign.center, 1, 2.8, FontWeight.bold),
                            ),
                          ),
                        )),
                    oneTapInFourTabs(
                        context,
                        persistentTabController,
                        1,
                        fourTabsController,
                        "four3".tr,
                        fourTabsController.selectedIndex.value == 1,
                        Icons.chat_rounded,
                        backFirst),
                    oneTapInFourTabs(
                        context,
                        persistentTabController,
                        0,
                        fourTabsController,
                        "four4".tr,
                        fourTabsController.selectedIndex.value == 0,
                        Icons.menu,
                        backFirst),
                  ],
                ),
              ),
            ),
          ),
          //
        ],
      ),
    ),
  );
}
