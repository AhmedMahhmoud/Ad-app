import 'dart:convert';
import 'package:hive/hive.dart';

class LocalDatabase {
  static Future userData() async {
    var appBox = await Hive.openBox('app');
    return appBox.get("user") == null ? null : json.decode(appBox.get("user"));
  }

  static Future putUserData(String user) async {
    var appBox = await Hive.openBox('app');
    return appBox.put("user", user);
  }

  static Future<bool> isFirstTimeToOpenApp() async {
    var appBox = await Hive.openBox('app');
    return appBox.get("firstTime") == null;
  }

  static Future putLang(String lang) async {
    var appBox = await Hive.openBox('app');
    appBox.put("lang", lang);
  }

  static Future getLang() async {
    var appBox = await Hive.openBox('app');
    return appBox.get("lang");
  }

  static Future notFirstTimeAnyMore() async {
    var appBox = await Hive.openBox('app');
    appBox.put("firstTime", "no");
  }

  static Future<List> getAllfavs() async {
    var favs = await Hive.openBox('favs');
    String drugsJson =
        favs.get("favs") != null ? favs.get("favs") : json.encode([]);
    List drugs = json.decode(drugsJson);
    return drugs;
  }

  static Future putAllfavs(String favs) async {
    var drugsBox = await Hive.openBox('favs');
    drugsBox.put("favs", favs);
  }

  static addOrRemoveFav(String ad, bool add) async {
    List favs = await getAllfavs();
    add ? favs.add(ad) : favs.remove(ad);
    putAllfavs(json.encode(favs));
  }
}
