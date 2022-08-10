import 'dart:developer';

import 'package:ads_app/controllers/global_actions_controller.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helpers/globalWidget.dart';
import '../models/ad.dart';

class OneAdController extends GetxController {
  final String adID;
  final ad = Rx<AdModel?>(null);
  final isMine = false.obs;
  final showDeleteDialog = false.obs;
  final isFavourite = false.obs;
  final loading = false.obs;
  final loading_deleteing = false.obs;
  final images = [].obs;
  final comments = [].obs;
  TextEditingController comment = TextEditingController();

  OneAdController(this.adID);

  Future<void> delete_this_Ad(BuildContext context) async {
    loading_deleteing.value = true;

    bool ss = await AdService.delete_one_ad_service(adID.toString());
    showDeleteDialog.value = false;
    loading_deleteing.value = false;
    if (ss) {
      Navigator.pop(context, [true, adID.toString()]);
    }
  }

  Future<void> getMyAds() async {
    try {
      log(adID.toString());
      loading.value = true;
      String? uuid = await GlobalActionsController.getUUID();
      ad.value =
          await AdService.get_one_ad_service(adID.toString(), uuid ?? '0000');
      if (ad.value != null) {
        images.add(ad.value!.image);
        for (var item in ad.value!.files) {
          images.add(item.path);
        }
      }
      getMyAdsComments(adID.toString());
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
    } finally {
      loading.value = false;
    }
  }

  Future<void> getMyAdsComments(String id) async {
    loading.value = true;

    List ss = await AdService.get_one_ad_comments_service(id);
    comments.clear();
    for (var item in ss) {
      comments.add(item);
    }
    print(ss);
    loading.value = false;
  }

  Future<void> send_ads_comment() async {
    String dd = comment.text.trim();
    comments.add({
      "comment": dd,
      "user_id": fourTabsController.userMap["name"],
      "times": DateTime.now().toString()
    });
    comment.clear();
    await AdService.send_one_ad_comment_service(dd, adID.toString());
  }

  @override
  void onInit() {
    getMyAds();

    super.onInit();
  }
}
