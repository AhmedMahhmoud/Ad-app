import 'package:flutter/material.dart';
import 'package:get/get.dart';

navigateForward(Widget page, Transition transition, Curve curve,
    int durationInMilliseconds, var arguments) {
  Get.to(
    page,
    arguments: arguments,
    transition: transition,
    curve: curve,
    duration: Duration(milliseconds: durationInMilliseconds),
  );
}

navigateBack(BuildContext context) {
  Get.back();
}

navigateForwardAndRemoveUntil(Widget page, Transition transition, Curve curve,
    int durationInMilliseconds) {
  Get.offAll(
    page,
    transition: transition,
    curve: curve,
    duration: Duration(milliseconds: durationInMilliseconds),
  );
}
