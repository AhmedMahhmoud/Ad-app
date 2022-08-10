import 'package:ads_app/controllers/four_tabs_controller.dart';
import 'package:ads_app/controllers/more/last_seen_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/add/add_ad.dart';
import 'package:ads_app/views/auth/login.dart';
import 'package:ads_app/views/four_tabs_widgets.dart';
import 'package:ads_app/views/more/ads/ads_widgets.dart';
import 'package:ads_app/views/one_ad/one_ad.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LastSeen extends StatefulWidget {
  const LastSeen({Key? key}) : super(key: key);

  @override
  State<LastSeen> createState() => _LastSeenState();
}

class _LastSeenState extends State<LastSeen> {
  LastSeenController lastSeenController = Get.put(LastSeenController());
  FourTabsController fourTabsController = Get.find<FourTabsController>();

  @override
  void initState() {
    // TODO: implement initState
    lastSeenController.getMyAds();
    super.initState();
  }

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
                () => lastSeenController.loading.value
                    ? SpinKitCircle(
                        color: maincolor1,
                        size: 8.w,
                      )
                    : SingleChildScrollView(
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
                                SharedWidgets.pageHeader(
                                    context, "ما تم مشاهدته مؤخرا", true),
                                SizedBox(
                                    height: dh(context),
                                    width: dw(context),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      child: GridView.builder(
                                          itemCount:
                                              lastSeenController.ads.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 0.5,
                                                  crossAxisSpacing: 1.w),
                                          physics: ScrollPhysics(
                                              parent: ScrollPhysics()),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                                onTap: () {
                                                  navigateForward(
                                                      OneAd(
                                                          id: lastSeenController
                                                              .ads[index]["id"]
                                                              .toString()),
                                                      Transition.downToUp,
                                                      Curves.easeInOut,
                                                      500,
                                                      [
                                                        lastSeenController
                                                            .ads[index]["id"]
                                                            .toString()
                                                      ]);
                                                },
                                                child: AdsWidgets.one_ad(
                                                    context,
                                                    false,
                                                    lastSeenController
                                                        .ads[index],
                                                    false));
                                          }),
                                    )),
                                SizedBox(
                                  height: 30.w,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              buildTheRealNavBar(
                  context,
                  fourTabsController.persistentTabController,
                  fourTabsController,
                  true),
              Positioned(
                bottom: 10.w,
                left: (dw(context) / 2) - 7.5.w,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      navigateBack(context);

                      navigateForward(
                          fourTabsController.isLogin.value
                              ? AddAd()
                              : Login(true),
                          Transition.downToUp,
                          Curves.easeInOut,
                          500,
                          []);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: maincolor1, shape: BoxShape.circle),
                      width: 15.w,
                      height: 15.w,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 8.w,
                          color: white,
                        ),
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
