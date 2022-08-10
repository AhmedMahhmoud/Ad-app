import 'package:ads_app/controllers/home/home_controller.dart';
import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:ads_app/services/tabs/home/home_services.dart';
import 'package:ads_app/views/add/add_ad.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  RxBool loading = false.obs;
  RxList ads = [].obs;
  RxBool has_text = false.obs;
  TextEditingController searchField = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  RxBool is_searched = false.obs;
  RxBool showFilter = true.obs;
  RxBool loadingFilter = false.obs;
  RxList filtersList = [].obs;
  RxList filtersMapsSelected = [].obs;
  RxList<RxString> filtersMapsHints = <RxString>[].obs;
  RxString order = "latest".obs;
  List indexSelectedInFilter = [];

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

  Future get_category_filter() async {
    loadingFilter.value = true;
    List data = await AdService.get_category_filters_service(
        homeController.currentMainCategoryId.value);
    filtersList.clear();
    filtersMapsHints.clear();
    filtersMapsSelected.clear();
    indexSelectedInFilter.clear();
    for (var item in data) {
      if (item["values"].length > 0) {
        Map dd = item;
        dd["filter_value_id"] = "";
        filtersList.add(item);
        filtersMapsSelected.add(item);
        filtersMapsHints.add(RxString(item["name"]));
      }
    }
    loadingFilter.value = false;
  }

  clearAll() async {
    searchField.clear();
    from.clear();
    to.clear();
    order.value = "latest";
    filtersMapsHints.clear();
    filtersMapsSelected.clear();
    indexSelectedInFilter.clear();
    for (var item in filtersList) {
      if (item["values"].length > 0) {
        Map dd = item;
        dd["filter_value_id"] = "";
        filtersMapsSelected.add(item);
        filtersMapsHints.add(RxString(item["name"]));
      }
    }
  }

  Future search() async {
    List filter_id = [];
    filter_id.clear();
    for (var item in indexSelectedInFilter) {
      filter_id.add(filtersMapsSelected.elementAt(item)["id"].toString());
    }
    loading.value = true;
    showFilter.value = false;
    List data = await AdService.search_with_filter_service(
        searchField.text.trim().length > 0 ? searchField.text.trim() : "",
        from.text.trim().length > 0 ? from.text.trim() : "",
        to.text.trim().length > 0 ? to.text.trim() : "",
        order.value,
        filter_id);
    ads.clear();
    ads.addAll(data);
    loading.value = false;
  }

  @override
  void onInit() {
    get_category_filter();
    super.onInit();
  }
}
