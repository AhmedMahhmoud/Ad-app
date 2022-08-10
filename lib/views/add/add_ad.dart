import 'package:ads_app/controllers/add_ad/add_ad_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/add/add_ad_widget.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddAd extends StatefulWidget {
  const AddAd({Key? key}) : super(key: key);

  @override
  State<AddAd> createState() => _AddAdState();
}

class _AddAdState extends State<AddAd> {
  AddAdController addAdController = Get.put(AddAdController());

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
                    SharedWidgets.pageHeader(context, "addad1".tr, true),
                    AddAdWidget.buttonsToAdd(context, addAdController),
                    AddAdWidget.post_image_list(context, addAdController),
                    //

                    SizedBox(
                      height: 5.w,
                    ),
                    Obx(() => addAdController.mainCategories.length == 0
                        ? SizedBox()
                        : Obx(() => AddAdWidget.buildOneDropdown(
                                addAdController,
                                addAdController.currentMain,
                                addAdController.mainCategories,
                                context, (item) {
                              addAdController.mainCategory = Map.from(item).obs;
                              addAdController.currentMain.value = item["name"];
                              addAdController.checkToLoadNextCategory(
                                  true, 22, item);
                            }))),
                    Obx(
                      () => SizedBox(
                        height: addAdController.govs.length == 0 ? 0 : 5.w,
                      ),
                    ),
                    //

                    Obx(() => addAdController.govs.length == 0
                        ? SizedBox()
                        : Obx(() => addAdController.showLocations.value
                            ? AddAdWidget.buildOneDropdown(
                                addAdController,
                                addAdController.currentGov,
                                addAdController.govs,
                                context, (item) {
                                addAdController.government = Map.from(item).obs;
                                addAdController.currentGov.value = item["name"];
                                addAdController.showRegion.value = true;
                              })
                            : SizedBox())),

                    Obx(() => addAdController.showRegion.value
                        ? SizedBox(
                            height: 5.w,
                          )
                        : SizedBox()),
                    Obx(() => !addAdController.showRegion.value
                        ? SizedBox()
                        : Obx(() => addAdController.showLocations.value
                            ? AddAdWidget.buildOneDropdown(
                                addAdController,
                                addAdController.currentRegion,
                                addAdController.government["regions"],
                                context, (item) {
                                addAdController.region = Map.from(item).obs;
                                addAdController.currentRegion.value =
                                    item["name"];
                              })
                            : SizedBox())),
                    SizedBox(
                      height: 5.w,
                    ),

                    Obx(
                      () => ListView.builder(
                          physics: ScrollPhysics(parent: ScrollPhysics()),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              addAdController.insideCategoriesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            List items =
                                addAdController.insideCategoriesList[index];

                            return Obx(() => Padding(
                                  padding: EdgeInsets.only(bottom: 5.w),
                                  child: AddAdWidget.buildOneDropdown(
                                      addAdController,
                                      addAdController
                                          .insideCategoriesMapsHints[index],
                                      items,
                                      context, (item) {
                                    addAdController.insideCategoriesMapsSelected
                                        .removeAt(index);

                                    addAdController.insideCategoriesMapsSelected
                                        .insert(index, Map.from(item).obs);
                                    addAdController.insideCategoriesMapsHints
                                        .removeAt(index);
                                    addAdController.insideCategoriesMapsHints
                                        .insert(index, RxString(item["name"]));
                                    addAdController.checkToLoadNextCategory(
                                        false, index, item);
                                  }),
                                ));
                          }),
                    ),

                    AddAdWidget.buildOneField(
                        addAdController,
                        context,
                        "addad2".tr,
                        addAdController.title,
                        TextInputType.text,
                        1,
                        ""),
                    SizedBox(
                      height: 5.w,
                    ),

                    AddAdWidget.buildOneField(
                      addAdController,
                      context,
                      "addad3".tr,
                      addAdController.price,
                      TextInputType.number,
                      1,
                      "addad4".tr,
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    AddAdWidget.buildOneField(
                        addAdController,
                        context,
                        "addad5".tr,
                        addAdController.description,
                        TextInputType.text,
                        5,
                        ""),
                    //
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.w),
                      child: InkWell(
                        onTap: () {
                          addAdController.goToFiltersPage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: maincolor1,
                              borderRadius: BorderRadius.circular(5.w)),
                          height: 12.w,
                          width: dw(context),
                          child: Center(
                            child: gTextW("addad6".tr, white, TextAlign.center,
                                1, 4, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                    //
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
