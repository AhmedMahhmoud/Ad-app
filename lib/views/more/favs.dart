import 'dart:convert';

import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/views/more/ads/ads_widgets.dart';
import 'package:ads_app/views/one_ad/one_ad.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Favs extends StatefulWidget {
  const Favs({Key? key}) : super(key: key);

  @override
  State<Favs> createState() => _FavsState();
}

class _FavsState extends State<Favs> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: AnimationConfiguration.toStaggeredList(
                  duration: Duration(milliseconds: 800),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 200.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    SharedWidgets.pageHeader(context, "more32".tr, true),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: Obx(
                        () => GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.55,
                                    crossAxisSpacing: 1.w),
                            physics: ScrollPhysics(parent: ScrollPhysics()),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: fourTabsController.favs.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map item =
                                  json.decode(fourTabsController.favs[index]);
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      OneAd(id: item["id"].toString()),
                                      arguments: [item["id"].toString()],
                                      transition: Transition.upToDown,
                                      curve: Curves.easeInOut,
                                      duration: Duration(milliseconds: 500),
                                    )?.then((value) {
                                      if (value != null) {
                                        fourTabsController.favs.removeAt(index);
                                      }
                                    });
                                  },
                                  child: AdsWidgets.one_ad(
                                      context, false, item, false),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 25.w,
                    )
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
