import 'package:ads_app/controllers/auth/auth_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/auth/auth_widgets.dart';
import 'package:ads_app/views/auth/enter_forget_code.dart';
import 'package:ads_app/views/auth/register.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                    SharedWidgets.pageHeader(context, "auth15".tr, true),
                    Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Center(
                        child: SharedWidgets.logo(),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      child: Center(
                        child: gTextW("auth14".tr, black.withOpacity(0.6),
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
                            authController.forgetCodePhone, context)),
                    Obx(
                      () => authController.loadingforget.value
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
                                authController.sendForget();

                                //  navigateForward(EnterForgetCode(), Transition.downToUp, Curves.easeInOut, 500, []);
                              },
                              child: AuthWidgets.submitButton(
                                  "addad6".tr, context),
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
