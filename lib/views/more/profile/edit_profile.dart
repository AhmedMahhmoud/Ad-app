import 'dart:io';

import 'package:ads_app/controllers/more/profile_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/fullPageImage.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/services/tabs/more/profile_service.dart';
import 'package:ads_app/views/add/pick_media.dart';
import 'package:ads_app/views/auth/auth_widgets.dart';
import 'package:ads_app/views/more/profile/profile_widgets.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

//
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: SizedBox(
          width: dw(context),
          height: dh(context),
          child: Stack(
            children: [
              Obx(
                () => profileController.loading.value
                    ? Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Center(
                            child: SpinKitCircle(
                          color: maincolor1,
                          size: 10.w,
                        )))
                    : SingleChildScrollView(
                        physics: ScrollPhysics(parent: ScrollPhysics()),
                        child: AnimationLimiter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: AnimationConfiguration.toStaggeredList(
                              duration: Duration(milliseconds: 800),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                horizontalOffset: 200.0,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                              children: [
                                SharedWidgets.pageHeader(
                                    context, "more23".tr, true),
                                Center(
                                  child: Obx(
                                    () =>
                                        profileController.profileMap.length > 0
                                            ? ProfileWidgets.profile_image(
                                                profileController
                                                    .profileMap["info"]["photo"]
                                                    .toString(),
                                                profileController,
                                                context)
                                            : SizedBox(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 5.w,
                                      bottom: 2.w,
                                      left: 5.w,
                                      right: 5.w),
                                  child: gTextW(
                                      "auth27".tr,
                                      black,
                                      TextAlign.start,
                                      1,
                                      3.5,
                                      FontWeight.normal),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 1.w,
                                        bottom: 2.w,
                                        left: 5.w,
                                        right: 5.w),
                                    child: AuthWidgets.nameField(
                                        profileController.name, context)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 5.w,
                                      bottom: 2.w,
                                      left: 5.w,
                                      right: 5.w),
                                  child: gTextW(
                                      "auth28".tr,
                                      black,
                                      TextAlign.start,
                                      1,
                                      3.5,
                                      FontWeight.normal),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 1.w,
                                        bottom: 2.w,
                                        left: 5.w,
                                        right: 5.w),
                                    child: AuthWidgets.phoneField(
                                        profileController.phone, context)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 10.w),
                                  child: InkWell(
                                    onTap: () async {
                                      profileController.updateData();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: maincolor1,
                                          borderRadius:
                                              BorderRadius.circular(5.w)),
                                      height: 12.w,
                                      width: dw(context),
                                      child: Center(
                                        child: gTextW(
                                            "more23".tr,
                                            white,
                                            TextAlign.center,
                                            1,
                                            4,
                                            FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.w,
                                      bottom: 2.w,
                                      left: 5.w,
                                      right: 5.w),
                                  child: gTextW(
                                      "auth29".tr,
                                      black,
                                      TextAlign.start,
                                      1,
                                      3.5,
                                      FontWeight.normal),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 1.w,
                                        bottom: 2.w,
                                        left: 5.w,
                                        right: 5.w),
                                    child: ProfileWidgets.passwordField(
                                        context,
                                        profileController,
                                        profileController.oldpassword,
                                        "more24".tr)),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 1.w,
                                        bottom: 2.w,
                                        left: 5.w,
                                        right: 5.w),
                                    child: ProfileWidgets.passwordField(
                                        context,
                                        profileController,
                                        profileController.newpassword,
                                        "more31".tr)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 10.w),
                                  child: InkWell(
                                    onTap: () async {
                                      profileController.updatePassword();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: maincolor1,
                                          borderRadius:
                                              BorderRadius.circular(5.w)),
                                      height: 12.w,
                                      width: dw(context),
                                      child: Center(
                                        child: gTextW(
                                            "more31".tr,
                                            white,
                                            TextAlign.center,
                                            1,
                                            4,
                                            FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.w,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
