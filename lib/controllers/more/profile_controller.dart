import 'dart:io';

import 'package:ads_app/controllers/global_actions_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/services/tabs/more/profile_service.dart';
import 'package:ads_app/services/tabs/more/wallet_service.dart';
import 'package:ads_app/views/add/pick_media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';

class ProfileController extends GetxController {
  //
  Rx<File> image = File("null").obs;
  RxBool loading = false.obs;
  RxMap profileMap = {}.obs;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  RxBool hidePassword = false.obs;
  //
  //
  Future edit_photo(File mediaFile, BuildContext context) async {
    var theEditedFile =
        await GlobalActionsController.editImageSaveToGalleryReturnFileOrNull(
            context, mediaFile.path);
    if (theEditedFile != null) {
      buildToast("جار تحديث صورتك الشخصية");
      await ProfileService.update_profile(
        File(theEditedFile.path),
        profileMap["info"]["name"],
        profileMap["info"]["phone"].substring(3),
      );
      image.value = File("null");
      getProfileData();

      // upload the new image and clean the image to File("null")
    }
  }

  updateData() async {
    buildToast("جار تحديث بياناتك");
    await ProfileService.update_profile(
      File("null"),
      name.text.trim(),
      phone.text.trim(),
    ).then((value) => getProfileData());
  }

  updatePassword() async {
    FocusNode().requestFocus();
    if (oldpassword.text.trim().isNotEmpty &&
        newpassword.text.trim().isNotEmpty &&
        (oldpassword.text.trim() != newpassword.text.trim())) {
      buildToast("جار تحديث  كلمة المرور");
      await ProfileService.update_password(
        oldpassword.text.trim(),
        newpassword.text.trim(),
      );
    }
  }

  Future edit(
    BuildContext context,
  ) async {
    Get.to(PickMedia(), arguments: [true, true])?.then(
      (value) {
        if (value is File) {
          image.value = value;
          edit_photo(value, context);
        }
      },
    );
  }

  Future getProfileData() async {
    loading.value = true;
    Map data = await ProfileService.get_profile_service();
    profileMap.clear();
    profileMap.value = data;
    name.text = data["info"]["name"];
    phone.text = data["info"]["phone"].toString().substring(3);
    oldpassword.clear();
    newpassword.clear();
    image.value = File("null");
    loading.value = false;
  }

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }
}
