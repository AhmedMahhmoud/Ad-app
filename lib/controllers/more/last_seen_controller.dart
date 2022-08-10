import 'package:ads_app/controllers/global_actions_controller.dart';
import 'package:ads_app/services/tabs/ad/ad_service.dart';
import 'package:get/get.dart';

class LastSeenController extends GetxController {
  RxList ads = [].obs;
  RxBool loading = false.obs;

  Future getMyAds() async {
    loading.value = true;
    String? uuid = await GlobalActionsController.getUUID();
    print(uuid);
    List ads_data = await AdService.get_uuid_history_service(uuid!);
    print(ads_data.length);
    for (var item in ads_data) {
      ads.add(item);
    }
    loading.value = false;
  }

  @override
  void onInit() {
    getMyAds();
    super.onInit();
  }
}
