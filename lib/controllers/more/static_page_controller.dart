import 'package:ads_app/services/tabs/more/static_page_service.dart';
import 'package:get/get.dart';

class StaticPageController extends GetxController {
  RxBool loading = false.obs;
  RxString pageData = "".obs;
  RxString title = "".obs;

  Future getStaticPage(String pageId) async {
    loading.value = true;
    pageData.value = await StaticPageSrevice.get_page_service(pageId);
    loading.value = false;
  }

  @override
  void onInit() {
    getStaticPage(Get.arguments[0]);
    print(Get.arguments);
    title.value = Get.arguments[1];
    // TODO: implement onInit
    super.onInit();
  }
}
