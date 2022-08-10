import 'package:ads_app/controllers/more/last_seen_controller.dart';
import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:ads_app/services/tabs/home/home_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  LastSeenController lastSeenController = Get.put(LastSeenController());
  RxBool loading = false.obs;
  RxBool loadingLastPageAds = false.obs;
  RxList slider = [].obs;
  RxList categories = [].obs;
  RxList secondCat1 = [].obs;
  RxList secondCat2 = [].obs;
  RxList ads = [].obs;
  RxList current_sub_category_const_ads = [].obs;
  RxList current_sub_category_ads = [].obs;
  RxList current_sub_category_subCategories = [].obs;
  RxInt selected_sub_category = 0.obs;

  RxList lastPagesCatsId = [].obs;
  RxList lastPagesCatsListOfAds = [].obs;
  RxList lastPagesAdsToShow = [].obs;

  RxString currentSubName = "".obs;
  RxString currentMainCategoryId = "".obs;
  RxString currentSubBanner = "".obs;
  RxMap currentSubCategory = {}.obs;
  RxBool loadingSubCategory = false.obs;
  RxList<Map> insidePages = <Map>[].obs;
  RxInt categoryTreeCount = 0.obs;
  //
  RxBool loading_governments = false.obs;
  RxBool loading_governments_ads = false.obs;
  RxMap government = {"name": "المحافظة"}.obs;
  RxMap region = {"name": "المنطقة"}.obs;
  RxList<Map> govs = <Map>[].obs;
  RxList<Map> regs = <Map>[].obs;
  RxString currentGov = "المحافظة".obs;
  RxString currentRegion = "المنطقة".obs;
  RxBool showRegion = false.obs;
  RxList ads_of_governments = [].obs;

  //
  //
  Future get_govs() async {
    loading_governments.value = true;
    List data = await AdService.get_govs_service();
    govs.clear();
    regs.clear();
    for (var item in data) {
      govs.add(item);
    }
    loading_governments.value = false;
  }

  //
  //
  Future getHomeData() async {
    loading.value = true;
    Map data = await HomeServices.get_home_service();
    slider.clear();
    slider.addAll(data["sliders"]);
    categories.clear();
    categories.addAll(data["categories"]);
    secondCat1.clear();
    secondCat2.clear();
    if (data["secondCat"].length > 2) {
      for (var i = 0; i < data["secondCat"].length; i++) {
        if (i < 2) {
          secondCat1.add(data["secondCat"][i]);
        } else {
          secondCat2.add(data["secondCat"][i]);
        }
      }
    } else {
      secondCat1.addAll(data["secondCat"]);
    }
    ads.clear();
    ads.addAll(data["ads"]);
    loading.value = false;
  }

  Future getSubCategory(
      String id, bool addToInsidePage, String name, String type) async {
    loadingSubCategory.value = true;
    currentSubName.value = name;
    Map data = await HomeServices.get_sub_category_service(id, type);
    if (data.length > 0) {
      if (addToInsidePage) {
        insidePages.add(data);
      }
      currentSubCategory.value = data;
      current_sub_category_ads.clear();
      current_sub_category_ads.addAll(data["ads"]);
      current_sub_category_subCategories.clear();
      current_sub_category_subCategories.addAll(data["subCategories"]);
      if (current_sub_category_subCategories.length > 0 &&
          categoryTreeCount.value != insidePages.length + 1) {
        current_sub_category_subCategories.removeAt(0);
      } else {
        selected_sub_category.value =
            int.parse(current_sub_category_subCategories[0]["id"].toString());
        getlastCategoryAds(
            current_sub_category_subCategories[0]["id"].toString(),
            current_sub_category_subCategories[0]["type"].toString() != "null"
                ? current_sub_category_subCategories[0]["type"]
                : "1");
      }
      current_sub_category_const_ads.clear();
      current_sub_category_const_ads.addAll(data["const_ads"]);
    }

    loadingSubCategory.value = false;
  }

  Future getlastCategoryAds(String id, String type) async {
    if (lastPagesCatsId.indexOf(id) == -1) {
      loadingLastPageAds.value = true;
      Map data = await HomeServices.get_sub_category_service(id, type);
      if (data.length > 0) {
        List allAds = [];
        for (var item in data["const_ads"]) {
          item["consto"] = true;
          allAds.add(item);
        }
        for (var item in data["ads"]) {
          item["consto"] = false;
          allAds.add(item);
        }
        lastPagesCatsId.add(id);
        lastPagesCatsListOfAds.addAll([allAds]);
        lastPagesAdsToShow.clear();
        lastPagesAdsToShow.addAll(allAds);
      }
      loadingLastPageAds.value = false;
    } else {
      int index = lastPagesCatsId.indexOf(id);
      List ads = lastPagesCatsListOfAds[index];
      lastPagesAdsToShow.clear();
      lastPagesAdsToShow.addAll(ads);
    }
  }

  Future get_govs_ads() async {
    loading_governments_ads.value = true;
    Map data = await HomeServices.get_govs_ads_service_service(
        selected_sub_category.value.toString(),
        government["id"].toString(),
        region["id"].toString());
    print(government);
    print(region);
    print(data);
    if (data.length > 0) {
      List allAds = [];
      allAds.addAll(data["ads"]);
      ads_of_governments.clear();
      ads_of_governments.addAll(allAds);
    }
    loading_governments_ads.value = false;
  }

  goBack() {
    lastPagesAdsToShow.clear();
    lastPagesCatsId.clear();
    lastPagesCatsListOfAds.clear();
    if (insidePages.length > 0) {
      insidePages.removeLast();
    }
    if (insidePages.length > 0) {
      Map page = insidePages.last;
      current_sub_category_ads.clear();
      current_sub_category_ads.addAll(page["ads"]);
      current_sub_category_subCategories.clear();
      current_sub_category_subCategories.addAll(page["subCategories"]);

      current_sub_category_subCategories.removeAt(0);

      current_sub_category_const_ads.clear();
      current_sub_category_const_ads.addAll(page["const_ads"]);
    } else {
      Get.back();
    }
  }

  setCategoryTreeCount(
    String id,
  ) {
    Map cat =
        categories.firstWhere((element) => element["id"].toString() == id);
    categoryTreeCount.value = int.parse(cat["count_tree"].toString());
    currentMainCategoryId.value = id;
  }

  @override
  void onInit() {
    getHomeData();

    super.onInit();
  }
}
