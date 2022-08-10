import 'dart:io';
import 'dart:typed_data';

import 'package:ads_app/controllers/add_ad/add_ad_controller.dart';
import 'package:ads_app/controllers/global_actions_controller.dart';
import 'package:ads_app/controllers/more/profile_controller.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PickMediaController extends GetxController {
  RxList<Map<String, dynamic>> listOfSelectedFiles = <Map<String, dynamic>>[].obs;
  RxBool profile = false.obs;
  RxBool singleFile = true.obs;
  //

  //the nextAction
  Future nextAction(BuildContext context) async {
    if (profile.value) {
      Navigator.pop(context, File(listOfSelectedFiles[0]["path"]));
    } else {
      AddAdController addAdController = Get.find<AddAdController>();

      if (singleFile.value) {
        addAdController.mainImage.value = File(listOfSelectedFiles[0]["path"]);
      } else {
        for (var item in listOfSelectedFiles) {
          addAdController.otherImages.add(File(item["path"]));
        }
      }
      navigateBack(context);
    }
  }
  //

  @override
  void onInit() {
    singleFile.value = Get.arguments[0];
    profile.value = Get.arguments[1];
    super.onInit();
  }
}
