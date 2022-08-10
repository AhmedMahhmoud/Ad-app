import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:get/get.dart';

class MyAdsController extends GetxController {
  RxInt whichTypeToShow = 1.obs;
  RxBool loading = false.obs;
  RxList pending = [].obs;
  RxList active = [].obs;
  RxList refused = [].obs;

  Future getMyAds() async {
    loading.value = true;
    Map data = await AdService.get_my_ads_service();
    pending.clear();
    refused.clear();
    active.clear();

    pending.addAll(data["pending"]);
    active.addAll(data["active"]);
    refused.addAll(data["refused"]);
    loading.value = false;
  }

  @override
  void onInit() {
    getMyAds();
    super.onInit();
  }
}
