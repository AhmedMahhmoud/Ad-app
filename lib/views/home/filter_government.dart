import 'package:ads_app/controllers/home/filter_controller.dart';
import 'package:ads_app/controllers/home/home_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/add/add_ad_widget.dart';
import 'package:ads_app/views/home/home_widgets.dart';
import 'package:ads_app/views/more/ads/ads_widgets.dart';
import 'package:ads_app/views/one_ad/one_ad.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FilterGovernment extends StatefulWidget {
  final String title;
  const FilterGovernment(this.title);

  @override
  State<FilterGovernment> createState() => _FilterGovernmentState();
}

class _FilterGovernmentState extends State<FilterGovernment> {
  HomeController homeController = Get.put(HomeController());
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
              SingleChildScrollView(
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
                        SizedBox(
                          height: 22.w,
                          width: dw(context),
                          child: Stack(
                            children: [
                              SharedWidgets.pageHeaderBGImage(context),
                              Positioned(
                                bottom: 2.w,
                                left: 4.w,
                                right: 4.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        navigateBack(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 6.w,
                                        color: white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    gTextW(widget.title, white, TextAlign.start,
                                        1, 4, FontWeight.bold),
                                    Expanded(child: SizedBox()),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        //
                        SizedBox(
                          height: 5.w,
                        ),

                        //
                        Obx(() => homeController.loading_governments.value
                            ? Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Center(
                                    child: SpinKitSpinningCircle(
                                  color: maincolor1,
                                  size: 8.w,
                                )),
                              )
                            : Obx(() => homeController.govs.length == 0
                                ? SizedBox()
                                : HomeWidgets.buildOneDropdown(
                                    homeController,
                                    homeController.currentGov,
                                    homeController.govs,
                                    context, (item) {
                                    homeController.government =
                                        Map.from(item).obs;
                                    homeController.currentGov.value =
                                        item["name"];
                                    homeController.showRegion.value = true;
                                    homeController.showRegion.value = false;
                                    homeController.showRegion.value = true;
                                  }))),
                        SizedBox(
                          height: 5.w,
                        ),

                        Obx(() => !homeController.showRegion.value
                            ? SizedBox()
                            : HomeWidgets.buildOneDropdown(
                                homeController,
                                homeController.currentRegion,
                                homeController.government["regions"],
                                context, (item) {
                                homeController.region = Map.from(item).obs;
                                homeController.currentRegion.value =
                                    item["name"];
                                homeController.get_govs_ads();
                              })),
                        SizedBox(
                          height: 5.w,
                        ),

                        Obx(
                          () => homeController.loading_governments_ads.value
                              ? Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: Center(
                                      child: SpinKitSpinningCircle(
                                    color: maincolor1,
                                    size: 8.w,
                                  )),
                                )
                              : Obx(
                                  () => homeController
                                              .ads_of_governments.length ==
                                          0
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.all(2.w),
                                          child: GridView.builder(
                                              shrinkWrap: true,
                                              itemCount: homeController
                                                  .ads_of_governments.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 0.55,
                                                      crossAxisSpacing: 1.w),
                                              physics: ScrollPhysics(
                                                  parent: ScrollPhysics()),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                Map item = homeController
                                                    .ads_of_governments[index];
                                                return InkWell(
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
                                                      if (value != null) {
                                                        homeController
                                                            .ads_of_governments
                                                            .removeAt(index);
                                                      }
                                                    });
                                                  },
                                                  child: AdsWidgets.one_ad(
                                                      context,
                                                      true,
                                                      item,
                                                      false),
                                                );
                                              }),
                                        ),
                                ),
                        ),
                      ],
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
