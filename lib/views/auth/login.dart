import 'package:ads_app/controllers/auth/auth_controller.dart';
import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/auth/auth_widgets.dart';
import 'package:ads_app/views/auth/forget_password.dart';
import 'package:ads_app/views/auth/register.dart';
import 'package:ads_app/views/four_tabs.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  final bool goBack;
  const Login(this.goBack);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthController authController = Get.put(AuthController());
  FourTabsController fourTabsController = Get.put(FourTabsController());
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
                    SharedWidgets.pageHeader(
                        context, "auth16".tr, widget.goBack),
                    Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Center(
                        child: SharedWidgets.logo(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.w),
                      child: Center(
                        child: gTextW("auth17".tr, black, TextAlign.center, 1,
                            5, FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      child: Center(
                        child: gTextW("auth17".tr, black.withOpacity(0.5),
                            TextAlign.center, 1, 3.2, FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth13".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: 1.w, bottom: 2.w, left: 5.w, right: 5.w),
                        child: AuthWidgets.phoneField(
                            authController.loginPhone, context)),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth18".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: 1.w, bottom: 2.w, left: 5.w, right: 5.w),
                        child: AuthWidgets.passwordField(context,
                            authController, authController.loginPassword)),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 2.w, bottom: 2.w, left: 5.w, right: 5.w),
                          child: InkWell(
                            onTap: () {
                              navigateForward(ForgetPassword(),
                                  Transition.fadeIn, Curves.easeInOut, 500, []);
                            },
                            child: gTextW("auth20".tr, black.withOpacity(0.5),
                                TextAlign.start, 1, 3.5, FontWeight.normal),
                          )),
                    ),
                    Obx(
                      () => authController.loadingLogin.value
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
                                authController.login();
                              },
                              child: AuthWidgets.submitButton(
                                  "auth16".tr, context),
                            ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: InkWell(
                        onTap: () {
                          navigateForward(Registration(), Transition.fadeIn,
                              Curves.easeInOut, 500, []);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            gTextW("auth21".tr, black.withOpacity(0.5),
                                TextAlign.center, 1, 3.5, FontWeight.normal),
                            SizedBox(
                              width: 2.w,
                            ),
                            gTextW("auth22".tr, maincolor1, TextAlign.center, 1,
                                3.5, FontWeight.normal),
                          ],
                        ),
                      ),
                    ),
                    Obx(() => fourTabsController.skipped.value
                        ? SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(
                                top: 10.w, bottom: 5.w, left: 5.w, right: 5.w),
                            child: InkWell(
                              onTap: () {
                                fourTabsController.skipped.value = true;
                                fourTabsController.skipAndNotFirstTime();
                                navigateForward(FourTabs(), Transition.fadeIn,
                                    Curves.easeInOut, 500, []);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    size: 7.w,
                                    color: maincolor1,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  gTextW(
                                      "auth23".tr,
                                      maincolor1,
                                      TextAlign.center,
                                      1,
                                      3.5,
                                      FontWeight.normal),
                                ],
                              ),
                            ),
                          ))

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
