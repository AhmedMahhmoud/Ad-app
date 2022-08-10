import 'dart:async';

import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/controllers/notifications_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/auth/login.dart';
import 'package:ads_app/views/four_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FourTabsController fourTabsController = Get.find<FourTabsController>();

  @override
  void initState() {
    firebaseMessagingConfig(context);

    Timer(Duration(seconds: 2), () {
      navigateForward(
          fourTabsController.skipped.value ? FourTabs() : Login(false),
          Transition.fadeIn,
          Curves.easeInOut,
          500, []);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: dh(context),
        width: dw(context),
        color: white,
        child: Center(
          child: Image.asset(
            "assets/images/logo.jpeg",
            alignment: Alignment.bottomCenter,
            height: dw(context) / 3,
            width: dw(context) / 3,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    ));
  }
}
