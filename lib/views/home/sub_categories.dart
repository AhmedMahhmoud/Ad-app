import 'package:ads_app/controllers/home/home_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/home/filter.dart';
import 'package:ads_app/views/home/filter_government.dart';
import 'package:ads_app/views/home/home_widgets.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SubCategories extends StatefulWidget {
  const SubCategories({Key? key}) : super(key: key);

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          homeController.goBack();
          return false;
        },
        child: Scaffold(
          backgroundColor: maincolor3,
          body: SizedBox(
            width: dw(context),
            height: dh(context),
            child: Obx(
              () => homeController.loadingSubCategory.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.w),
                      child: Center(
                        child: SpinKitCircle(
                          color: maincolor1,
                          size: 8.w,
                        ),
                      ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              homeController.goBack();
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
                                          gTextW(
                                              homeController
                                                  .currentSubName.value,
                                              white,
                                              TextAlign.start,
                                              1,
                                              4,
                                              FontWeight.bold),
                                          Expanded(child: SizedBox()),
                                          Obx(() => homeController
                                                      .categoryTreeCount
                                                      .value ==
                                                  homeController
                                                          .insidePages.length +
                                                      1
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5.w),
                                                  child: InkWell(
                                                    onTap: () {
                                                      homeController.get_govs();
                                                      navigateForward(
                                                          FilterGovernment(
                                                              homeController
                                                                  .currentSubName
                                                                  .value),
                                                          Transition
                                                              .leftToRight,
                                                          Curves.easeInOut,
                                                          500,
                                                          []);
                                                    },
                                                    child: gTextW(
                                                        "المحافظات",
                                                        white,
                                                        TextAlign.center,
                                                        1,
                                                        4,
                                                        FontWeight.bold),
                                                  ))
                                              : SizedBox()),

                                          ///////
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.w),
                                            child: InkWell(
                                              onTap: () {
                                                navigateForward(
                                                    Filter(homeController
                                                        .currentSubName.value),
                                                    Transition.fadeIn,
                                                    Curves.easeInOut,
                                                    500,
                                                    [
                                                      homeController
                                                          .currentSubCategory[
                                                              "id"]
                                                          .toString()
                                                    ]);
                                              },
                                              child: Icon(
                                                Icons.filter_alt_outlined,
                                                size: 8.w,
                                                color: white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //
                              //
                              Obx(
                                () => homeController.categoryTreeCount.value ==
                                        homeController.insidePages.length + 1
                                    ? HomeWidgets
                                        .sub_category_horiztontial_list_last_page(
                                            context,
                                            homeController
                                                .current_sub_category_subCategories,
                                            homeController)
                                    : homeController.currentSubBanner.value
                                                .length ==
                                            0
                                        ? SizedBox()
                                        : SizedBox(
                                            height: dw(context) / 1.5,
                                            width: dw(context),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w,
                                                    vertical: 2.w),
                                                child: Obx(
                                                  () => buildNetworkImage(
                                                      context,
                                                      homeController
                                                          .currentSubBanner
                                                          .value,
                                                      3.w,
                                                      3.w,
                                                      3.w,
                                                      3.w,
                                                      dw(context) / 1.5,
                                                      dw(context),
                                                      BoxFit.cover),
                                                ))),
                              ),

                              //
                              //

                              Obx(() {
                                return homeController
                                                .current_sub_category_subCategories
                                                .length ==
                                            0 ||
                                        homeController
                                                .categoryTreeCount.value ==
                                            homeController.insidePages.length +
                                                1
                                    ? SizedBox()
                                    : Obx(
                                        () => HomeWidgets
                                            .sub_categories_list_horizontial(
                                                context,
                                                homeController
                                                    .current_sub_category_subCategories,
                                                homeController),
                                      );
                              }),
                              // ads from home
                              Obx(() => homeController
                                              .current_sub_category_const_ads
                                              .length ==
                                          0 ||
                                      homeController.categoryTreeCount.value ==
                                          homeController.insidePages.length + 1
                                  ? SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: gTextW(
                                              "home4".tr,
                                              black,
                                              TextAlign.start,
                                              1,
                                              3.5,
                                              FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              Obx(() => homeController.loading.value ||
                                      homeController.categoryTreeCount.value ==
                                          homeController.insidePages.length + 1
                                  ? SizedBox()
                                  : HomeWidgets.home_ads(
                                      context,
                                      homeController
                                          .current_sub_category_const_ads,
                                      homeController,
                                    )),
                              Obx(() =>
                                  homeController.categoryTreeCount.value ==
                                          homeController.insidePages.length + 1
                                      ? homeController.loadingLastPageAds.value
                                          ? SpinKitSpinningCircle(
                                              color: maincolor1,
                                              size: 8.w,
                                            )
                                          : HomeWidgets.last_page_ads(context,
                                              homeController.lastPagesAdsToShow)
                                      : SizedBox()),
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
        ),
      ),
    );
  }
}
