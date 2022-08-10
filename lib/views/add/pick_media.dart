import 'dart:io';
import 'dart:typed_data';

import 'package:ads_app/controllers/pick_media_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:flutter/material.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PickMedia extends StatefulWidget {
  const PickMedia({Key? key}) : super(key: key);

  @override
  State<PickMedia> createState() => _PickMediaState();
}

class _PickMediaState extends State<PickMedia> {
  PickMediaController pickMediaController = Get.put(PickMediaController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: dh(context),
          width: dw(context),
          color: Colors.transparent,
          child: Obx(
            () => GalleryMediaPicker(
              pathList: (List<Map<String, dynamic>> path) {
                pickMediaController.listOfSelectedFiles.clear();
                pickMediaController.listOfSelectedFiles.addAll(path);
              },
              childAspectRatio: 0.6,
              crossAxisCount: 3,
              thumbnailQuality: 1000,
              thumbnailBoxFix: BoxFit.cover,
              singlePick: pickMediaController.singleFile.value,
              onlyImages: true,
              appBarColor: maincolor1,
              albumTextColor: white,
              appBarIconColor: white,
              appBarTextColor: white,
              albumDividerColor: black,
              albumBackGroundColor: maincolor1,
              gridViewBackgroundColor: Colors.grey[900]!,
              imageBackgroundColor: Colors.black,
              maxPickImages: 50,
              appBarHeight: 15.w,
              gridPadding: EdgeInsets.all(1.w),
              gridViewPhysics: ScrollPhysics(parent: ScrollPhysics()),
              appBarLeadingWidget: Container(
                height: 15.w,
                color: maincolor1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () =>
                            pickMediaController.listOfSelectedFiles.length == 0
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3.w, horizontal: 10.w),
                                    child: InkWell(
                                      onTap: () async {
                                        pickMediaController.nextAction(context);
                                      },
                                      child: Icon(
                                        Icons.check,
                                        color: white,
                                        size: 8.w,
                                      ),
                                    ),
                                  ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.w, horizontal: 0.w),
                        child: InkWell(
                          onTap: () => navigateBack(context),
                          child: Icon(
                            Icons.close,
                            color: white,
                            size: 8.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              selectedBackgroundColor: Colors.black,
              selectedCheckColor: Colors.black87,
              selectedCheckBackgroundColor: Colors.white10,
              // appBarHeight: 50.w,
            ),
          ),
        ),
      ),
    );
  }
}
