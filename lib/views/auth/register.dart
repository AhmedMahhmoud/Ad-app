import 'package:ads_app/controllers/auth/auth_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/auth/auth_widgets.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: SizedBox(
          width: dw(context),
          height: dh(context),
          child: SingleChildScrollView(
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
                    //
                    SharedWidgets.pageHeader(context, "auth24".tr, true),
                    Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Center(
                        child: SharedWidgets.logo(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.w),
                      child: Center(
                        child: gTextW("auth25".tr, black, TextAlign.center, 1,
                            5, FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      child: Center(
                        child: gTextW("auth26".tr, black.withOpacity(0.5),
                            TextAlign.center, 2, 3.2, FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth27".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: 1.w, bottom: 2.w, left: 5.w, right: 5.w),
                        child: AuthWidgets.nameField(
                            authController.registerName, context)),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth28".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: 1.w, bottom: 2.w, left: 5.w, right: 5.w),
                        child: AuthWidgets.phoneField(
                            authController.registerPhone, context)),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth29".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: 1.w, bottom: 2.w, left: 5.w, right: 5.w),
                        child: AuthWidgets.passwordField(context,
                            authController, authController.registerPassword)),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth30".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: 1.w, bottom: 2.w, left: 5.w, right: 5.w),
                        child: AuthWidgets.passwordField(
                            context,
                            authController,
                            authController.registerPasswordConfirm)),

                    Obx(
                      () => authController.loadingRegister.value
                          ? Padding(
                              padding: EdgeInsets.only(top: 10.w, bottom: 5.w),
                              child: Center(
                                child: SpinKitWave(
                                  color: maincolor1,
                                  size: 8.w,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                authController.register();
                              },
                              child: AuthWidgets.submitButton(
                                  "auth31".tr, context),
                            ),
                    ),

                    //
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
