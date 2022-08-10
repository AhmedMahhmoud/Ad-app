import 'package:ads_app/controllers/more/static_page_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/more/ads/fav_ads.dart';
import 'package:ads_app/views/more/ads/last_seen_ads.dart';
import 'package:ads_app/views/more/ads/my_ads.dart';
import 'package:ads_app/views/more/more_widgets.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StaticPage extends StatefulWidget {
  const StaticPage({Key? key}) : super(key: key);

  @override
  State<StaticPage> createState() => _StaticPageState();
}

class _StaticPageState extends State<StaticPage> {
  StaticPageController staticPageController = Get.put(StaticPageController());
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
                    Obx(
                      () => SharedWidgets.pageHeader(
                          context, staticPageController.title.value, true),
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    SharedWidgets.logo(),

                    SizedBox(
                      height: 5.w,
                    ),
                    Obx(() => staticPageController.loading.value
                        ? Center(
                            child: SpinKitCircle(
                              color: maincolor1,
                              size: 10.w,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(5.w),
                            child: gTextW(
                                staticPageController.pageData.value,
                                black,
                                TextAlign.center,
                                10000,
                                3.5,
                                FontWeight.bold),
                          )),
                    // MoreWidgets.listButton(More(), "تواصل معنا"),
                    SizedBox(
                      height: 20.w,
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
