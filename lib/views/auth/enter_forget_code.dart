import 'package:ads_app/controllers/auth/auth_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/auth/auth_widgets.dart';
import 'package:ads_app/views/auth/change_password.dart';
import 'package:ads_app/views/auth/register.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EnterForgetCode extends StatefulWidget {
  const EnterForgetCode({Key? key}) : super(key: key);

  @override
  State<EnterForgetCode> createState() => _EnterForgetCodeState();
}

class _EnterForgetCodeState extends State<EnterForgetCode> {
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
                    SharedWidgets.pageHeader(context, "auth12".tr, true),
                    Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Center(
                        child: SharedWidgets.logo(),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.w, bottom: 2.w, left: 5.w, right: 5.w),
                      child: gTextW("auth11".tr, black, TextAlign.start, 1, 3.5,
                          FontWeight.normal),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: 5.w, bottom: 15.w, left: 5.w, right: 5.w),
                        child: Center(
                          child: AuthWidgets.codeEnterForVerification(
                              authController.enterCode),
                        )),
                    InkWell(
                      child: AuthWidgets.submitButton("addad6".tr, context),
                      onTap: () {
                        authController.codeIsCorrect(context);
                      },
                    ),

                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 3.w,
                    //     vertical: 10.w,
                    //   ),
                    //   child: Center(
                    //     child: gTextW(
                    //         "إعادة الإرسال (30 : 00)",
                    //         black.withOpacity(0.6),
                    //         TextAlign.center,
                    //         1,
                    //         3.2,
                    //         FontWeight.normal),
                    //   ),
                    // ),
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
