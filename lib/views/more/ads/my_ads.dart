import 'package:ads_app/controllers/more/my_ads_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/more/ads/ads_widgets.dart';
import 'package:ads_app/views/one_ad/one_ad.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MyAds extends StatefulWidget {
  const MyAds({Key? key}) : super(key: key);

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  final MyAdsController myAdsController = Get.put(MyAdsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: Obx(
          () => myAdsController.loading.value
              ? Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Center(
                    child: SpinKitSpinningCircle(
                      color: maincolor1,
                      size: 8.w,
                    ),
                  ),
                )
              : SizedBox(
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
                            SharedWidgets.pageHeader(
                                context, "more25".tr, true),
                            Obx(
                              () => myAdsController.active.length == 0 &&
                                      myAdsController.pending.length == 0 &&
                                      myAdsController.refused.length == 0
                                  ? SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 5.w, top: 3.w),
                                      child: Container(
                                        width: dw(context),
                                        color: white,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Obx(() => AdsWidgets
                                                  .status_title_to_show(
                                                      myAdsController
                                                              .whichTypeToShow
                                                              .value ==
                                                          1,
                                                      "more26".tr,
                                                      1,
                                                      myAdsController)),
                                              Obx(() => AdsWidgets
                                                  .status_title_to_show(
                                                      myAdsController
                                                              .whichTypeToShow
                                                              .value ==
                                                          2,
                                                      "more27".tr,
                                                      2,
                                                      myAdsController)),
                                              Obx(() => AdsWidgets
                                                  .status_title_to_show(
                                                      myAdsController
                                                              .whichTypeToShow
                                                              .value ==
                                                          3,
                                                      "more28".tr,
                                                      3,
                                                      myAdsController)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            //
                            SizedBox(
                                height: dh(context) - 50.w,
                                width: dw(context),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Obx(
                                    () => GridView.builder(
                                        itemCount: myAdsController
                                                    .whichTypeToShow.value ==
                                                1
                                            ? myAdsController.pending.length
                                            : myAdsController.whichTypeToShow
                                                        .value ==
                                                    2
                                                ? myAdsController.active.length
                                                : myAdsController
                                                    .refused.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 0.55,
                                                crossAxisSpacing: 1.w),
                                        physics: ScrollPhysics(
                                            parent: ScrollPhysics()),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Map item = myAdsController
                                                      .whichTypeToShow.value ==
                                                  1
                                              ? myAdsController.pending[index]
                                              : myAdsController.whichTypeToShow
                                                          .value ==
                                                      2
                                                  ? myAdsController
                                                      .active[index]
                                                  : myAdsController
                                                      .refused[index];
                                          return Stack(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    OneAd(
                                                        id: item["id"]
                                                            .toString()),
                                                    arguments: [
                                                      item["id"].toString()
                                                    ],
                                                    transition:
                                                        Transition.upToDown,
                                                    curve: Curves.easeInOut,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                  )?.then((value) {
                                                    print(value[0]);
                                                    if (value != null) {
                                                      myAdsController
                                                                  .whichTypeToShow
                                                                  .value ==
                                                              1
                                                          ? myAdsController
                                                              .pending
                                                              .removeAt(index)
                                                          : myAdsController
                                                                      .whichTypeToShow
                                                                      .value ==
                                                                  2
                                                              ? myAdsController
                                                                  .active
                                                                  .removeAt(
                                                                      index)
                                                              : myAdsController
                                                                  .refused
                                                                  .removeAt(
                                                                      index);
                                                    }
                                                  });
                                                },
                                                child: AdsWidgets.one_ad(
                                                    context, true, item, false),
                                              ),
                                              Obx(() => myAdsController
                                                          .whichTypeToShow
                                                          .value ==
                                                      1
                                                  ? Container(
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.timer_outlined,
                                                          size: 20.w,
                                                          color: maincolor1
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                    )
                                                  : myAdsController
                                                              .whichTypeToShow
                                                              .value ==
                                                          3
                                                      ? Container(
                                                          color: white
                                                              .withOpacity(0.5),
                                                          child: Center(
                                                              child: Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.w)),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          3.w,
                                                                      vertical:
                                                                          1.w),
                                                              child: gTextW(
                                                                  "more29".tr,
                                                                  white,
                                                                  TextAlign
                                                                      .center,
                                                                  1,
                                                                  3.5,
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          )),
                                                        )
                                                      : SizedBox()),
                                            ],
                                          );
                                        }),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
