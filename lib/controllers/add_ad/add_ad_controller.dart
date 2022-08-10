import 'dart:io';

import 'package:ads_app/controllers/global_actions_controller.dart';
import 'package:ads_app/controllers/more/wallet_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:ads_app/services/tabs/more/wallet_service.dart';
import 'package:ads_app/views/add/add_ad_filters.dart';
import 'package:ads_app/views/add/add_ad_package.dart';
import 'package:ads_app/views/add/add_ad_widget.dart';
import 'package:ads_app/views/more/wallet/charge_wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddAdController extends GetxController {
  Rx<File> mainImage = File("null").obs;
  RxList<File> otherImages = <File>[].obs;
  RxMap government = {"name": "المحافظة"}.obs;
  RxMap region = {"name": "المنطقة"}.obs;
  RxMap mainCategory = {"name": "الفئة"}.obs;
  RxString currentGov = "المحافظة".obs;
  RxString currentRegion = "المنطقة".obs;
  RxString currentMain = "الفئة".obs;
  RxList insideCategoriesList = [].obs;
  RxList insideCategoriesMapsSelected = [].obs;
  RxList<RxString> insideCategoriesMapsHints = <RxString>[].obs;
  RxBool showRegion = false.obs;
  RxBool loading = false.obs;
  RxList<Map> govs = <Map>[].obs;
  RxList<Map> regs = <Map>[].obs;
  RxList<Map> mainCategories = <Map>[].obs;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  int categoriesTreeCount = 0;
  // filters page
  // filters page
  RxBool loadingFilters = false.obs;
  RxList filtersList = [].obs;
  RxList filtersMapsSelected = [].obs;
  RxList<RxString> filtersMapsHints = <RxString>[].obs;

  // RxMap packageMap = {}.obs;
  RxBool atHome = false.obs;
  RxBool atCategory = false.obs;
  RxBool agree = false.obs;
  RxBool showLocations = false.obs;

  //
  //
  //
  //
  //

  goToFiltersPage() async {
    if (mainImage.value.path == "null") {
      return buildToast("أضف صورة الإعلان أولا");
    }
    if (government.length == 1 && mainCategory["need_country"] == 1) {
      return buildToast("إختر المحافظة أولا");
    }
    if (region.length == 1 && mainCategory["need_country"] == 1) {
      return buildToast("إختر المنطقة أولا");
    }
    if (mainCategory.length == 1) {
      return buildToast("إختر الفئةأولا");
    }
    if (title.text.trim().length == 0) {
      return buildToast("أضف عنوان أولا");
    }
    if (description.text.trim().length == 0) {
      return buildToast("أضف وصف أولا");
    }

    if (insideCategoriesList.length < (categoriesTreeCount - 1)) {
      return buildToast("إختر القسم الداخلي أولا");
    }
    get_category_filter();
    navigateForward(
        AdFilters(), Transition.downToUp, Curves.easeInOut, 500, []);
  }

  goToPackagePage() async {
    for (var item in filtersList) {
      if (item["values"].length == 0) {
        if (item["valueOfInput"].length == 0) {
          return buildToast("من فضلك إملأ الفراغات كلها");
        }
      } else {
        if (item["filter_value_id"].length == 0) {
          return buildToast("من فضلك أكمل الإختيارات");
        }
      }
    }

    navigateForward(
        AddAdPackage(), Transition.downToUp, Curves.easeInOut, 500, []);
  }

  Future edit_photo(File mediaFile, BuildContext context, bool main) async {
    var theEditedFile =
        await GlobalActionsController.editImageSaveToGalleryReturnFileOrNull(
            context, mediaFile.path);
    if (theEditedFile != null) {
      if (main) {
        mainImage.value = File(theEditedFile.path);
      } else {
        int index = otherImages.lastIndexOf(mediaFile);
        File ff =
            otherImages.lastWhere((element) => element.path == mediaFile.path);
        otherImages.removeAt(index);
        otherImages.insert(index, File(theEditedFile.path));
      }
    }
  }

  uploadOrCharge(BuildContext context, AddAdController adController,
      WalletController walletController) async {
    if (agree.value == false) {
      return buildToast("يجب الموفقة على الشروط والأحكام أولا");
    }
    if (double.parse(walletController.walletMap["user_money"]) <
        get_total_price(walletController).value) {
      AddAdWidget.not_enough_money(
          context,
          (get_total_price(walletController).value -
                  double.parse(walletController.walletMap["user_money"]))
              .toString(),
          adController,
          walletController);
      return;
    }
    List options = [];

    for (var item in filtersList) {
      options.add({
        "filter_id": item["id"],
        "filter_value_id":
            item["values"].length > 0 ? item["filter_value_id"] : "",
        "title": item["values"].length > 0 ? "" : item["valueOfInput"],
      });
    }
    AdService.add_ad_service(
        (insideCategoriesMapsSelected[insideCategoriesMapsSelected.length - 1]
                ["id"])
            .toString(),
        region["id"].toString(),
        price.text.trim().length > 0 ? price.text.trim() : "0",
        title.text.trim(),
        description.text.trim(),
        get_total_price(walletController).toString(),
        (double.parse(walletController.walletMap["user_money"].toString()) -
                get_total_price(walletController).value)
            .toString(),
        mainImage.value,
        otherImages,
        options,
        true,
        atCategory.value,
        atHome.value);
    buildToast("جاري رفع إعلانك");
    navigateBack(context);
    navigateBack(context);
    navigateBack(context);
  }

  chargeAndBack(BuildContext context, WalletController walletController) {
    navigateBack(context);
    walletController.amountController.text = double.parse(
            (get_total_price(walletController).value +
                    double.parse(walletController.walletMap["user_money"]))
                .toString())
        .toString();
    walletController.totalToAdd.value = double.parse(
            (get_total_price(walletController).value +
                    double.parse(walletController.walletMap["user_money"]))
                .toString())
        .toString();
    navigateForward(
        ChargeWallet(), Transition.downToUp, Curves.easeInOut, 500, []);
  }

  Future get_govs() async {
    loading.value = true;
    List data = await AdService.get_govs_service();
    govs.clear();
    regs.clear();
    for (var item in data) {
      govs.add(item);
    }
    loading.value = false;
  }

  Future get_main_category() async {
    var data = await AdService.get_main_category_service();
    mainCategories.clear();
    for (var item in data) {
      mainCategories.add(item);
    }
  }

  Future removeTheLowerCats(bool firstOne, int index, Map item) async {
    if (firstOne) {
      insideCategoriesList.clear();
      insideCategoriesMapsSelected.clear();
      insideCategoriesMapsHints.clear();
    } else {
      if (index < insideCategoriesList.length - 1) {
        insideCategoriesList.removeRange(
            index + 1, insideCategoriesList.length);
        insideCategoriesMapsSelected.removeRange(
            index + 1, insideCategoriesMapsSelected.length);
        insideCategoriesMapsHints.removeRange(
            index + 1, insideCategoriesMapsHints.length);
      }
    }
  }

  Future get_inside_category(
      String id, bool firstOne, int index, Map item) async {
    await removeTheLowerCats(firstOne, index, item);
    List data = await AdService.get_inside_category_service(id);
    if (firstOne) {
      categoriesTreeCount = int.parse(item["count_tree"].toString());
    }
    if (data.length > 0) {
      insideCategoriesList.add(data);
      insideCategoriesMapsSelected.add(data[0]);
      insideCategoriesMapsHints.add(RxString(data[0]["name"]));
    }
  }

  Future get_category_filter() async {
    loadingFilters.value = true;
    List data = await AdService.get_category_filters_service(
        mainCategory["id"].toString());
    filtersList.clear();
    filtersMapsHints.clear();
    filtersMapsSelected.clear();
    for (var item in data) {
      if (item["values"].length > 0) {
        Map dd = item;
        dd["filter_value_id"] = "";
        filtersList.add(item);
        filtersMapsSelected.add(item);
        filtersMapsHints.add(RxString(item["name"]));
      } else {
        Map dd = item;
        dd["valueOfInput"] = "";

        filtersList.add(dd);
        filtersMapsSelected.add(dd);
        filtersMapsHints.add(RxString(dd["name"]));
      }
    }
    loadingFilters.value = false;
  }

  checkToLoadNextCategory(bool firstOne, int index, Map item) async {
    if (firstOne) {
      if (item["need_country"].toString() == 1.toString()) {
        get_govs();
        showLocations.value = true;
      } else {
        showLocations.value = false;
        regs.clear();
        govs.clear();
      }
      get_inside_category(item["id"].toString(), firstOne, index, item);
    } else {
      get_inside_category(item["id"].toString(), firstOne, index, item);
    }
  }

  RxDouble get_total_price(WalletController walletController) {
    double final_price = 0.0;
    if (walletController.walletMap.length > 0) {
      final_price +=
          double.parse(walletController.walletMap["ads cost"].toString());
      final_price += atHome.value
          ? double.parse(walletController.walletMap["main section"].toString())
          : 0;
      final_price += atCategory.value
          ? double.parse(
              walletController.walletMap["advertisement page"].toString())
          : 0;
    }
    return RxDouble(final_price);
  }

  @override
  void onInit() {
    get_main_category();
    super.onInit();
  }
}
