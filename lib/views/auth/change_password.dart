import 'package:ads_app/controllers/auth/auth_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/auth/auth_widgets.dart';
import 'package:ads_app/views/auth/forget_password.dart';
import 'package:ads_app/views/auth/register.dart';
import 'package:ads_app/views/four_tabs.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
                    SharedWidgets.pageHeader(context, "auth10".tr, true),
                    Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Center(
                        child: SharedWidgets.logo(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.w),
                      child: Center(
                        child: gTextW("auth9".tr, black, TextAlign.center, 1, 5,
                            FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      child: Center(
                        child: gTextW("auth8".tr, black.withOpacity(0.5),
                            TextAlign.center, 1, 3.2, FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth7".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth6".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: 1.w, bottom: 2.w, left: 5.w, right: 5.w),
                        child: AuthWidgets.passwordField(context,
                            authController, authController.newPassword)),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth5".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: 1.w, bottom: 2.w, left: 5.w, right: 5.w),
                        child: AuthWidgets.passwordField(context,
                            authController, authController.newPasswordConfirm)),
                    InkWell(
                      child: AuthWidgets.submitButton("auth4".tr, context),
                      onTap: () {
                        navigateForward(FourTabs(), Transition.downToUp,
                            Curves.easeInOut, 500, []);
                      },
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
