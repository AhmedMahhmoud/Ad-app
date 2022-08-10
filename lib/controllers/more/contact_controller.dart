import 'package:ads_app/controllers/global_actions_controller.dart';
import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:ads_app/services/tabs/more/more_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  RxMap links = {}.obs;
  RxBool loading = false.obs;
  RxBool send_loading = false.obs;
  TextEditingController msg = TextEditingController();

  // get_one_ad_service

  Future send_msg() async {
    if (msg.text.trim().isNotEmpty) {
      send_loading.value = true;
      await MoreServices.send_msg(msg.text.trim());
      send_loading.value = false;
      msg.clear();
    }
  }

  Future get_links_to_contact() async {
    loading.value = true;
    Map data = await MoreServices.social_links_service();
    links.value = data;
    loading.value = false;
  }

  @override
  void onInit() {
    get_links_to_contact();
    super.onInit();
  }
}
