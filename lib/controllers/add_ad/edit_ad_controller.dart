import 'package:ads_app/controllers/one_ad_controller.dart';
import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAdController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  OneAdController oneAdController = Get.find<OneAdController>();
  RxMap old_ad = {}.obs;

  RxBool uploading_ad = false.obs;

  Future upload_new_data() async {
    //
    if (title.text.trim().isNotEmpty &&
        description.text.trim().isNotEmpty &&
        price.text.trim().isNotEmpty &&
        GetUtils.isNum(price.text.trim())) {
      old_ad["name"] = title.text.trim().toString();
      old_ad["content"] = description.text.trim().toString();
      old_ad["price"] = price.text.trim().toString();
      old_ad.addAll(oneAdController.ad.value!.toJson());
      Get.back();
      await AdService.edit_ad_service(
          price.text.trim().toString(),
          title.text.trim().toString(),
          description.text.trim().toString(),
          old_ad["id"].toString());
    }
  }

  @override
  void onInit() {
    old_ad.value = Get.arguments[0];
    title.text = Get.arguments[0]["name"].toString();
    description.text = Get.arguments[0]["content"].toString();
    price.text = Get.arguments[0]["price"].toString();
    print(old_ad);
    super.onInit();
  }
}
