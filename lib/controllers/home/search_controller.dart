import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:ads_app/services/tabs/home/home_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxBool loading = false.obs;
  RxList ads = [].obs;
  RxBool has_text = false.obs;
  TextEditingController searchField = TextEditingController();
  RxBool is_searched = false.obs;

  Future search() async {
    loading.value = true;
    List data =
        await AdService.search_with_word_service(searchField.text.trim());
    ads.clear();
    ads.addAll(data);
    loading.value = false;
  }

  onSubmit() async {
    if (has_text.value) {
      search();
    }
  }

  onChange(String value) async {
    if (value.length > 0) {
      has_text.value = true;
    } else {
      has_text.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
