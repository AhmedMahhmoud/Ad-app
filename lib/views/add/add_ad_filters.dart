import 'package:ads_app/controllers/add_ad/add_ad_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/add/add_ad_package.dart';
import 'package:ads_app/views/add/add_ad_widget.dart';
import 'package:ads_app/views/more/ads/ads_widgets.dart';
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

class AdFilters extends StatefulWidget {
  const AdFilters({Key? key}) : super(key: key);

  @override
  State<AdFilters> createState() => _AdFiltersState();
}

class _AdFiltersState extends State<AdFilters> {
  AddAdController addAdController = Get.find<AddAdController>();

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
                    verticalOffset: 200.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    SharedWidgets.pageHeader(context, "addad7".tr, true),
                    SizedBox(
                      height: 5.w,
                    ),
                    Obx(
                      () => addAdController.loadingFilters.value
                          ? SpinKitSpinningCircle(
                              color: maincolor1,
                              size: 7.w,
                            )
                          : Obx(
                              () => ListView.builder(
                                  physics:
                                      ScrollPhysics(parent: ScrollPhysics()),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: addAdController.filtersList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Map filter =
                                        addAdController.filtersList[index];

                                    return filter["values"].length == 0
                                        ? AddAdWidget.buildFilterTextField(
                                            addAdController, filter, context,
                                            (value) {
                                            addAdController.filtersList[index]
                                                ["valueOfInput"] = value;
                                            print(addAdController.filtersList);
                                          })
                                        : Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 5.w),
                                            child: Obx(() =>
                                                AddAdWidget.buildOneDropdown(
                                                    addAdController,
                                                    addAdController
                                                            .filtersMapsHints[
                                                        index],
                                                    filter["values"],
                                                    context, (item) {
                                                  addAdController.filtersList[
                                                              index]
                                                          ["filter_value_id"] =
                                                      item["id"].toString();
                                                  addAdController
                                                      .filtersMapsSelected
                                                      .removeAt(index);

                                                  addAdController
                                                      .filtersMapsSelected
                                                      .insert(index,
                                                          Map.from(item).obs);
                                                  addAdController
                                                      .filtersMapsHints
                                                      .removeAt(index);
                                                  addAdController
                                                      .filtersMapsHints
                                                      .insert(
                                                          index,
                                                          RxString(
                                                              item["name"]));
                                                })),
                                          );
                                  }),
                            ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.w),
                      child: InkWell(
                        onTap: () {
                          addAdController.goToPackagePage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: maincolor1,
                              borderRadius: BorderRadius.circular(5.w)),
                          height: 12.w,
                          width: dw(context),
                          child: Center(
                            child: gTextW("addad8".tr, white, TextAlign.center,
                                1, 4, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
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
