import 'dart:io';

import 'package:ads_app/controllers/global_actions_controller.dart';
import 'package:ads_app/controllers/more/wallet_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:ads_app/services/tabs/more/wallet_service.dart';
import 'package:ads_app/services/tabs/offers/offer_service.dart';
import 'package:ads_app/views/add/add_ad_filters.dart';
import 'package:ads_app/views/add/add_ad_package.dart';
import 'package:ads_app/views/add/add_ad_widget.dart';
import 'package:ads_app/views/more/wallet/charge_wallet.dart';
import 'package:ads_app/views/offer/one_offer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OffersController extends GetxController {
  RxMap currentOffer = {}.obs;
  RxBool loading = false.obs;
  RxBool loading_cat_data = true.obs;
  RxList<Map> offers_cat = <Map>[].obs;
  RxList current_offers = [].obs;
  RxList<List> offers__cats_lists = <List>[].obs;
  RxInt selected_category = 0.obs;
  RxInt selected_category_index = 0.obs;

  Future get_offers_cats() async {
    loading.value = true;
    List data = await OffersService.get_offers_cats_service();
    offers_cat.clear();
    for (var item in data) {
      offers_cat.add(item);
    }
    updateCategory(offers_cat[0], 0);
    loading.value = false;
  }

  Future get_category_data(Map cat) async {
    loading_cat_data.value = true;

    List data = await OffersService.get_cats_data_service(
        cat["id"].toString(), cat["type"].toString());
    offers__cats_lists.add(data);
    current_offers.clear();
    current_offers.addAll(data);
    loading_cat_data.value = false;
  }

  Future updateCategory(Map cat, int index) async {
    selected_category.value = cat["id"];
    selected_category_index.value = cat["id"];
    get_category_data(cat);
  }

  Future viewAd(Map item, BuildContext context) async {
    await assignFirst(item);
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        fullscreenDialog: true,
        transitionDuration: Duration(microseconds: 500),
        pageBuilder: (BuildContext context, _, __) => OneOfferView()));
  }

  assignFirst(Map item) async {
    currentOffer.value = item;
  }

  @override
  void onInit() {
    get_offers_cats();
    //
    super.onInit();
  }
}
