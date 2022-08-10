import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/local_database/local_database.dart';
import 'package:ads_app/views/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class FourTabsController extends GetxController {
  RxBool loadingTabs = true.obs;
  RxBool internet = true.obs;
  RxBool isLogin = false.obs;
  RxMap userMap = {}.obs;
  RxBool skipped = false.obs;
  RxString lang = "ar".obs;
  RxInt selectedIndex = 3.obs;
  RxList favs = [].obs;
  RxBool showNavBar = true.obs;
  PersistentTabController persistentTabController =
      PersistentTabController(initialIndex: 3);
  getUserData() async {
    await LocalDatabase.isFirstTimeToOpenApp().then((value) {
      skipped.value = value ? false : true;
    });
    await LocalDatabase.userData().then((value) {
      if (value != null) {
        isLogin.value = true;
        userMap.value = value;
      } else {
        isLogin.value = false;
        userMap.value = {};
      }
    });
    await LocalDatabase.getLang().then((value) async {
      print(value);
      if (value != null) {
        lang.value = value;
        changeLanguage(value);
      } else {
        await LocalDatabase.putLang("ar");
        changeLanguage("ar");
      }
    });
  }

  logOut() async {
    var appBox = await Hive.openBox('app');
    appBox.delete("user");
    skipAndNotFirstTime();
    getUserData();
    navigateForwardAndRemoveUntil(
        Splash(), Transition.fadeIn, Curves.easeInOut, 500);
  }

  skipAndNotFirstTime() async {
    await LocalDatabase.notFirstTimeAnyMore();
  }
  //

  Future changeLanguage(String ss) async {
    lang.value = ss;
    await LocalDatabase.putLang(ss);
    Get.updateLocale(Locale(ss));
  }

  getFavs() async {
    List ss = await LocalDatabase.getAllfavs();
    favs.clear();
    favs.addAll(ss);
  }

  @override
  void onInit() {
    getFavs();
    getUserData();

    super.onInit();
  }
}
