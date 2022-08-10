import 'package:ads_app/controllers/home/filter_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/home/home_widgets.dart';
import 'package:ads_app/views/more/ads/ads_widgets.dart';
import 'package:ads_app/views/one_ad/one_ad.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Filter extends StatefulWidget {
  final String title;
  const Filter(this.title);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  FilterController filterController = Get.put(FilterController());
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
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 0.w),
                                      child: InkWell(
                                        onTap: () {
                                          filterController.showFilter.value =
                                              !filterController
                                                  .showFilter.value;
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
                          () => filterController.loading.value
                              ? Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: Center(
                                      child: SpinKitSpinningCircle(
                                    color: maincolor1,
                                    size: 8.w,
                                  )),
                                )
                              : Obx(
                                  () => filterController.is_searched.value &&
                                          filterController.ads.length == 0
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.w,
                                          ),
                                          child: Center(
                                            child: gTextW(
                                                "جرب خيارات أخري",
                                                maincolor1,
                                                TextAlign.center,
                                                1,
                                                3,
                                                FontWeight.bold),
                                          ),
                                        )
                                      : Obx(
                                          () => filterController.ads.length == 0
                                              ? SizedBox()
                                              : Padding(
                                                  padding: EdgeInsets.all(2.w),
                                                  child: GridView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          filterController
                                                              .ads.length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              childAspectRatio:
                                                                  0.55,
                                                              crossAxisSpacing:
                                                                  1.w),
                                                      physics: ScrollPhysics(
                                                          parent:
                                                              ScrollPhysics()),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        Map item =
                                                            filterController
                                                                .ads[index];
                                                        return InkWell(
                                                          onTap: () {
                                                            Get.to(
                                                              OneAd(
                                                                  id: item["id"]
                                                                      .toString()),
                                                              arguments: [
                                                                item["id"]
                                                                    .toString()
                                                              ],
                                                              transition:
                                                                  Transition
                                                                      .upToDown,
                                                              curve: Curves
                                                                  .easeInOut,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                            )?.then((value) {
                                                              if (value !=
                                                                  null) {
                                                                filterController
                                                                    .ads
                                                                    .removeAt(
                                                                        index);
                                                              }
                                                            });
                                                          },
                                                          child:
                                                              AdsWidgets.one_ad(
                                                                  context,
                                                                  true,
                                                                  item,
                                                                  false),
                                                        );
                                                      }),
                                                ),
                                        ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() => filterController.showFilter.value
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 30.w,
                      child: Container(
                        //
                        child: ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(parent: ScrollPhysics()),
                          scrollDirection: Axis.vertical,
                          children: [
                            //
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7.w, vertical: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      filterController.showFilter.value = false;
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 7.w,
                                      color: maincolor1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 0.w),
                              child: Container(
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0.w),
                                    child: HomeWidgets.search_field_for_filter(
                                        context, filterController)),
                                height: 11.w,
                                width: dw(context) - 22.w,
                                decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(3.w),
                                ),
                              ),
                            ),
                            //
                            //
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 3.w),
                              child: Container(
                                width: dw(context),
                                height: 25.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(3.w),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //
                                            gTextW(
                                                "السعر",
                                                black,
                                                TextAlign.start,
                                                1,
                                                3.2,
                                                FontWeight.bold),
                                            gTextW(
                                                "K.D",
                                                black,
                                                TextAlign.start,
                                                1,
                                                3.2,
                                                FontWeight.bold),
                                            //
                                            //
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            //
                                            gTextW("من", black, TextAlign.start,
                                                1, 3.2, FontWeight.bold),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            //
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0.w,
                                                  vertical: 0.w),
                                              child: Container(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.w),
                                                    child: HomeWidgets
                                                        .search_field_price_form_to(
                                                            context,
                                                            filterController,
                                                            filterController
                                                                .from)),
                                                height: 11.w,
                                                width: dw(context) / 3.5,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          Colors.grey.shade300),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w),
                                                ),
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),

                                            gTextW(
                                                "إلى",
                                                black,
                                                TextAlign.start,
                                                1,
                                                3.2,
                                                FontWeight.bold),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 0.w,
                                                  vertical: 0.w),
                                              child: Container(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.w),
                                                    child: HomeWidgets
                                                        .search_field_price_form_to(
                                                            context,
                                                            filterController,
                                                            filterController
                                                                .to)),
                                                height: 11.w,
                                                width: dw(context) / 3.5,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          Colors.grey.shade300),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w),
                                                ),
                                              ),
                                            ),
                                            //
                                            //
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5.w),
                                ),
                                width: dw(context),
                                height: 25.w,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 2.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //
                                      gTextW("الترتيب", black, TextAlign.start,
                                          1, 3, FontWeight.bold),
                                      SizedBox(
                                        height: 2.w,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //
                                          InkWell(
                                            onTap: () {
                                              //
                                              filterController.order.value =
                                                  "latest";
                                            },
                                            child: Obx(
                                              () => Container(
                                                height: 10.w,
                                                width: dw(context) / 4,
                                                decoration: BoxDecoration(
                                                  color: filterController
                                                              .order.value ==
                                                          "latest"
                                                      ? maincolor1
                                                      : white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w),
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                                child: Center(
                                                  child: gTextW(
                                                      "الأحدث",
                                                      filterController.order
                                                                  .value ==
                                                              "latest"
                                                          ? white
                                                          : black,
                                                      TextAlign.center,
                                                      1,
                                                      2.5,
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //
                                              filterController.order.value =
                                                  "lawPrice";
                                            },
                                            child: Obx(
                                              () => Container(
                                                height: 10.w,
                                                width: dw(context) / 4,
                                                decoration: BoxDecoration(
                                                  color: filterController
                                                              .order.value ==
                                                          "lawPrice"
                                                      ? maincolor1
                                                      : white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w),
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                                child: Center(
                                                  child: gTextW(
                                                      "السعر الأقل أولا",
                                                      filterController.order
                                                                  .value ==
                                                              "lawPrice"
                                                          ? white
                                                          : black,
                                                      TextAlign.center,
                                                      1,
                                                      2.5,
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              filterController.order.value =
                                                  "highPrice";
                                            },
                                            child: Obx(
                                              () => Container(
                                                height: 10.w,
                                                width: dw(context) / 4,
                                                decoration: BoxDecoration(
                                                  color: filterController
                                                              .order.value ==
                                                          "highPrice"
                                                      ? maincolor1
                                                      : white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w),
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                                child: Center(
                                                  child: gTextW(
                                                      "السعر الأعلي أولا",
                                                      filterController.order
                                                                  .value ==
                                                              "highPrice"
                                                          ? white
                                                          : black,
                                                      TextAlign.center,
                                                      1,
                                                      2.5,
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //
                                        ],
                                      ),
                                      //
                                      //
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                            //
                            Obx(
                              () => filterController.loadingFilter.value
                                  ? SpinKitSpinningCircle(
                                      color: maincolor1,
                                      size: 7.w,
                                    )
                                  : Obx(
                                      () => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 3.w),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              color: Colors.grey.shade200),
                                          child: Padding(
                                            padding: EdgeInsets.all(1.w),
                                            child: ListView.builder(
                                                physics: ScrollPhysics(
                                                    parent: ScrollPhysics()),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: filterController
                                                    .filtersList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  Map filter = filterController
                                                      .filtersList[index];

                                                  return Obx(() => HomeWidgets
                                                          .buildOneDropdownForFilterResults(
                                                              filterController,
                                                              filterController
                                                                      .filtersMapsHints[
                                                                  index],
                                                              filter["values"],
                                                              context, (item) {
                                                        filterController
                                                                    .filtersList[
                                                                index][
                                                            "filter_value_id"] = item[
                                                                "id"]
                                                            .toString();
                                                        filterController
                                                            .filtersMapsSelected
                                                            .removeAt(index);

                                                        filterController
                                                            .filtersMapsSelected
                                                            .insert(
                                                                index,
                                                                Map.from(item)
                                                                    .obs);
                                                        if (filterController
                                                                .indexSelectedInFilter
                                                                .indexOf(
                                                                    index) ==
                                                            -1) {
                                                          filterController
                                                              .indexSelectedInFilter
                                                              .add(index);
                                                        }
                                                        filterController
                                                            .filtersMapsHints
                                                            .removeAt(index);
                                                        filterController
                                                            .filtersMapsHints
                                                            .insert(
                                                                index,
                                                                RxString(item[
                                                                    "name"]));
                                                      }));
                                                }),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(6.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      filterController.search();
                                    },
                                    child: Container(
                                      height: 13.w,
                                      width: dw(context) / 3,
                                      decoration: BoxDecoration(
                                        color: maincolor1,
                                        borderRadius:
                                            BorderRadius.circular(3.w),
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade300),
                                      ),
                                      child: Center(
                                        child: gTextW(
                                            "تطبيق",
                                            white,
                                            TextAlign.center,
                                            1,
                                            3,
                                            FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => filterController.clearAll(),
                                    child: Container(
                                      height: 13.w,
                                      width: dw(context) / 3,
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(3.w),
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade300),
                                      ),
                                      child: Center(
                                        child: gTextW(
                                            "مسح الكل",
                                            maincolor1,
                                            TextAlign.center,
                                            1,
                                            3,
                                            FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.w),
                                topRight: Radius.circular(15.w))),
                        height: dh(context) / 1.2,
                        width: dw(context),
                      ),
                    )
                  : SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
