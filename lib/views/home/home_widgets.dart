import 'package:ads_app/controllers/home/filter_controller.dart';
import 'package:ads_app/controllers/home/home_controller.dart';
import 'package:ads_app/controllers/home/search_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/home/categories.dart';
import 'package:ads_app/views/home/search.dart';
import 'package:ads_app/views/home/sub_categories.dart';
import 'package:ads_app/views/more/ads/ads_widgets.dart';
import 'package:ads_app/views/one_ad/one_ad.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeWidgets {
  static sub_category_horiztontial_list_last_page(
      BuildContext context, RxList list, HomeController homeController) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.w,
      ),
      child: Container(
        height: 10.w,
        width: dw(context),
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            physics: ScrollPhysics(parent: ScrollPhysics()),
            itemBuilder: (BuildContext context, int index) {
              Map item = list[index];
              return Obx(() => one_item_category(
                  item,
                  homeController.selected_sub_category.value == item["id"],
                  homeController,
                  index));
            }),
      ),
    );
  }

  static one_item_category(
      Map item, bool selected, HomeController homeController, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: InkWell(
        onTap: () {
          print("mahmouddddddddddddddddddddddd");
          homeController.selected_sub_category.value =
              int.parse(item["id"].toString());
          homeController.getlastCategoryAds(item["id"].toString(),
              item["type"].toString() != "null" ? item["type"] : "1");
        },
        child: Container(
          decoration: BoxDecoration(
            color: selected ? maincolor1 : white,
            borderRadius: BorderRadius.circular(2.w),
            border: Border.all(width: 1, color: maincolor1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.w),
            child: Center(
              child: gTextW(
                  item["name"].toString(),
                  selected ? white : maincolor1,
                  TextAlign.center,
                  1,
                  3.3,
                  FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  static home_header(
    BuildContext context,
  ) {
    return Container(
      height: 22.w,
      width: dw(context),
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            height: 22.w,
            child: SharedWidgets.pageHeaderBGImage(context),
          ),
          Positioned(
            right: 5.w,
            bottom: 5.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: Center(
                child: Image.asset(
                  "assets/images/logo.jpeg",
                  alignment: Alignment.bottomCenter,
                  height: 17.w,
                  width: 17.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Positioned(
            right: 25.w,
            left: 5.w,
            bottom: 5.w,
            child: InkWell(
              onTap: () {
                navigateForward(
                    Search(), Transition.fadeIn, Curves.easeInOut, 500, []);
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      gTextW("home2".tr, black.withOpacity(0.3),
                          TextAlign.start, 1, 3, FontWeight.bold),
                      Icon(
                        Icons.search,
                        size: 6.w,
                        color: black.withOpacity(0.3),
                      )
                    ],
                  ),
                ),
                height: 10.w,
                width: dw(context),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static search_header(
    BuildContext context,
    SearchController searchController,
  ) {
    return Container(
      height: 22.w,
      width: dw(context),
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            height: 22.w,
            child: SharedWidgets.pageHeaderBGImage(context),
          ),
          Positioned(
            right: 5.w,
            bottom: 2.w,
            left: 5.w,
            child: SizedBox(
              width: dw(context),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      navigateBack(context);
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      size: 7.w,
                      color: white,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Container(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.w),
                        child: search_field(context, searchController)),
                    height: 10.w,
                    width: dw(context) - 22.w,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(100.w),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


 

  static buildOneDropdown(HomeController homeController, RxString currenthint,
      List items, BuildContext context, Function actionOnChnage) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Padding(
              padding:
                  EdgeInsets.only(top: 1.w, left: 5.w, right: 5.w, bottom: 1.w),
              child: DropdownButton(
                isExpanded: true,
                elevation: 0,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 8.w,
                  color: black,
                ),
                dropdownColor: white,
                underline: SizedBox(),
                hint: Obx(() => gTextW(currenthint.value.toString(), black,
                    TextAlign.start, 1, 3.3, FontWeight.bold)),
                items: items.map((item) {
                  return DropdownMenuItem(
                      value: item,
                      child: gTextW(item["name"].toString(), black,
                          TextAlign.start, 1, 3.5, FontWeight.bold));
                }).toList(),
                onChanged: (item) => actionOnChnage(item),
              ))),
    );
  }

  static categories_list(BuildContext context, HomeController homeController) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Container(
        height: 36.w,
        width: dw(context),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: dw(context),
                height: 7.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      gTextW("home1".tr, black, TextAlign.start, 1, 3.8,
                          FontWeight.bold),
                      InkWell(
                        onTap: () {
                          navigateForward(Categories(), Transition.fadeIn,
                              Curves.easeInOut, 500, []);
                        },
                        child: gTextW("home3".tr, black.withOpacity(0.5),
                            TextAlign.start, 1, 2.8, FontWeight.bold),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              width: dw(context),
              height: 28.w,
              child: ListView.builder(
                  physics: ScrollPhysics(parent: ScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map item = homeController.categories[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 3.w),
                      child: InkWell(
                        onTap: () {
                          homeController.insidePages.clear();
                          homeController.currentSubName.value = item["name"];
                          homeController.currentMainCategoryId.value =
                              item["id"].toString();
                          homeController.categoryTreeCount.value =
                              int.parse(item["count_tree"].toString());
                          homeController.getSubCategory(
                              item["id"].toString(),
                              false,
                              item["name"],
                              item["type"].toString() != "null"
                                  ? item["type"]
                                  : "1");
                          navigateForward(SubCategories(), Transition.fadeIn,
                              Curves.easeInOut, 500, []);
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 1.w),
                                child: Container(
                                  width: 20.w,
                                  child: buildNetworkImage(
                                      context,
                                      "${item['image']}",
                                      5.w,
                                      5.w,
                                      5.w,
                                      5.w,
                                      0,
                                      0,
                                      BoxFit.cover),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(3.w),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                            color: black.withOpacity(0.1))
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                              height: 8.w,
                              child: gTextW(
                                  "${item['name']}",
                                  Colors.black.withOpacity(0.6),
                                  TextAlign.center,
                                  1,
                                  2.8,
                                  FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  static categories_gridview(
      BuildContext context, HomeController homeController) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          physics: ScrollPhysics(parent: ScrollPhysics()),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: homeController.categories.length,
          itemBuilder: (BuildContext context, int index) {
            Map item = homeController.categories[index];
            return Padding(
              padding: EdgeInsets.only(top: 3.w),
              child: InkWell(
                onTap: () {
                  homeController.insidePages.clear();
                  homeController.currentSubName.value = item['name'];
                  homeController.currentMainCategoryId.value =
                      item["id"].toString();
                  homeController.categoryTreeCount.value =
                      int.parse(item["count_tree"].toString());
                  homeController.getSubCategory(
                      item["id"].toString(),
                      false,
                      item["name"],
                      item["type"].toString() != "null" ? item["type"] : "1");
                  navigateForward(SubCategories(), Transition.fadeIn,
                      Curves.easeInOut, 500, []);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.w),
                        child: Container(
                          width: 20.w,
                          child: buildNetworkImage(context, "${item['image']}",
                              0.w, 0.w, 0.w, 0.w, 0, 0, BoxFit.cover),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(3.w),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: black.withOpacity(0.1))
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.w,
                      height: 8.w,
                      child: gTextW(
                          "${item['name']}",
                          Colors.black.withOpacity(0.6),
                          TextAlign.center,
                          1,
                          2.8,
                          FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  static home_ads(
    BuildContext context,
    items,
    HomeController homeController,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: SizedBox(
        width: dw(context),
        height: items.length > 0 ? (dw(context) / 2.2) * 2 : 0,
        child: ListView.builder(
            physics: ScrollPhysics(parent: ScrollPhysics()),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              Map item = items[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                  width: dw(context) / 2.2,
                  height: (dw(context) / 2.2) * 2,
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
                          homeController.ads.removeWhere((element) =>
                              element["id"].toString() == value[1]);
                          homeController.current_sub_category_const_ads
                              .removeWhere((element) =>
                                  element["id"].toString() == value[1]);
                        }
                      });
                    },
                    child: AdsWidgets.one_ad(context, false, item, true),
                  ),
                ),
              );
            }),
      ),
    );
  }

  static last_page_ads(BuildContext context, items) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.55, crossAxisSpacing: 1.w),
          physics: ScrollPhysics(parent: ScrollPhysics()),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            Map item = items[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: InkWell(
                onTap: () {
                  print("mahmooooooooooooooooud");
                  print(item["id"].toString());
                  navigateForward(
                      OneAd(id: item["id"].toString()),
                      Transition.downToUp,
                      Curves.easeInOut,
                      500,
                      [item["id"].toString()]);
                },
                child: AdsWidgets.one_ad(context, false, item, item["consto"]),
              ),
            );
          }),
    );
  }

  static sub_categories_list_horizontial(
      BuildContext context, List items, HomeController homeController) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.w,
      ),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          physics: ScrollPhysics(parent: ScrollPhysics()),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            Map item = items[index];
            return Padding(
              padding: EdgeInsets.only(top: 3.w, left: 0.w, right: 0.w),
              child: InkWell(
                onTap: () {
                  print(
                      "salamaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1");

                  homeController.getSubCategory(
                      item["id"].toString(),
                      true,
                      item["name"],
                      item["type"].toString() != "null" ? item["type"] : "1");
                  navigateForward(SubCategories(), Transition.fadeIn,
                      Curves.easeInOut, 500, []);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.w),
                        child: Container(
                          width: 20.w,
                          child: buildNetworkImage(
                              context,
                              // note
                              // "https://images.pexels.com/photos/11741441/pexels-photo-11741441.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                              item["image"],
                              0.w,
                              0.w,
                              0.w,
                              0.w,
                              0,
                              0,
                              BoxFit.cover),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(3.w),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: black.withOpacity(0.1))
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.w,
                      height: 8.w,
                      child: gTextW(
                          "${item['name']}",
                          Colors.black.withOpacity(0.6),
                          TextAlign.center,
                          1,
                          2.8,
                          FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  static buildOneDropdownForFilterResults(
      FilterController filterController,
      RxString currenthint,
      List items,
      BuildContext context,
      Function actionOnChnage) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0.w,
      ),
      child: Padding(
          padding:
              EdgeInsets.only(top: 1.w, left: 5.w, right: 5.w, bottom: 1.w),
          child: DropdownButton(
            isExpanded: true,
            elevation: 0,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 8.w,
              color: black,
            ),
            dropdownColor: Colors.grey.shade200,
            underline: SizedBox(),
            hint: Obx(() => gTextW(currenthint.value.toString(), black,
                TextAlign.start, 1, 3.3, FontWeight.bold)),
            items: items.map((item) {
              return DropdownMenuItem(
                  value: item,
                  child: gTextW(item["name"].toString(), black, TextAlign.start,
                      1, 3.5, FontWeight.bold));
            }).toList(),
            onChanged: (item) => actionOnChnage(item),
          )),
    );
  }

  static home_one_horizontial_list(
      BuildContext context,
      HomeController homeController,
      Map list,
      String categoryIdToGetTreeCount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Container(
        height: 34.w,
        width: dw(context),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: dw(context),
                height: 6.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      gTextW("${list["name"]}", black, TextAlign.start, 1, 3.8,
                          FontWeight.bold),
                      InkWell(
                        onTap: () {
                          homeController.insidePages.clear();
                          homeController.currentSubName.value =
                              "${list["name"]}";
                          homeController
                              .setCategoryTreeCount(list["id"].toString());
                          homeController.getSubCategory(
                              list["id"].toString(),
                              false,
                              list["name"],
                              list["type"].toString() != "null"
                                  ? list["type"]
                                  : "1");
                          navigateForward(SubCategories(), Transition.fadeIn,
                              Curves.easeInOut, 500, []);
                        },
                        child: gTextW("home3".tr, black.withOpacity(0.5),
                            TextAlign.start, 1, 2.8, FontWeight.bold),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              width: dw(context),
              height: 28.w,
              child: ListView.builder(
                  physics: ScrollPhysics(parent: ScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: list["subCategries"].length,
                  itemBuilder: (BuildContext context, int index) {
                    Map item = list["subCategries"][index];
                    return Padding(
                      padding: EdgeInsets.only(top: 3.w),
                      child: InkWell(
                        onTap: () {
                          homeController.insidePages.clear();
                          homeController.currentSubName.value = item["name"];
                          homeController.setCategoryTreeCount(
                            categoryIdToGetTreeCount,
                          );
                          homeController.getSubCategory(
                              item["id"].toString(),
                              true,
                              item["name"],
                              item["type"].toString() != "null"
                                  ? item["type"]
                                  : "1");
                          navigateForward(SubCategories(), Transition.fadeIn,
                              Curves.easeInOut, 500, []);
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 1.w),
                                child: Container(
                                  child: buildNetworkImage(
                                      context,
                                      "${item['image_path']}",
                                      0.w,
                                      0.w,
                                      0.w,
                                      0.w,
                                      0,
                                      0,
                                      BoxFit.cover),
                                  width: 18.w,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(3.w),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                            color: black.withOpacity(0.1))
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                              height: 8.w,
                              child: gTextW(
                                  "${item['name']}",
                                  Colors.black.withOpacity(0.6),
                                  TextAlign.center,
                                  1,
                                  2.8,
                                  FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  static search_field(
    BuildContext context,
    SearchController searchController,
  ) {
    return TextField(
      autofocus: true,
      onChanged: (value) => searchController.onChange(value),
      onSubmitted: (ss) => searchController.onSubmit(),
      style: TextStyle(
          fontSize: 3.5.w,
          color: maincolor1,
          fontWeight: FontWeight.normal,
          letterSpacing: 2),
      controller: searchController.searchField,
      cursorHeight: 7.w,
      cursorColor: Colors.grey,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 2.w),
          suffixIcon: Obx(
            () => searchController.has_text.value
                ? InkWell(
                    onTap: () {
                      searchController.has_text.value = false;
                      searchController.searchField.clear();
                    },
                    child: Icon(
                      Icons.clear,
                      size: 6.w,
                      color: maincolor1.withOpacity(0.7),
                    ),
                  )
                : SizedBox(),
          ),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "بحث . . . ",
          hintStyle: TextStyle(
            fontSize: 3.5.w,
            color: maincolor1.withOpacity(0.5),
            fontWeight: FontWeight.normal,
          )),
    );
  }

  static search_field_for_filter(
    BuildContext context,
    FilterController filterController,
  ) {
    return TextField(
      autofocus: false,
      onChanged: (value) => filterController.onChange(value),
      onSubmitted: (ss) => filterController.onSubmit(),
      style: TextStyle(
          fontSize: 3.5.w,
          color: maincolor1,
          fontWeight: FontWeight.normal,
          letterSpacing: 2),
      controller: filterController.searchField,
      cursorHeight: 7.w,
      cursorColor: Colors.grey,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 2.w),
          suffixIcon: Obx(
            () => filterController.has_text.value
                ? InkWell(
                    onTap: () {
                      filterController.has_text.value = false;
                      filterController.searchField.clear();
                    },
                    child: Icon(
                      Icons.clear,
                      size: 6.w,
                      color: maincolor1.withOpacity(0.7),
                    ),
                  )
                : SizedBox(),
          ),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "الإسم إن أردت . . . ",
          hintStyle: TextStyle(
            fontSize: 3.5.w,
            color: maincolor1.withOpacity(0.5),
            fontWeight: FontWeight.normal,
          )),
    );
  }

  static search_field_price_form_to(
      BuildContext context,
      FilterController filterController,
      TextEditingController textEditingController) {
    return TextField(
      autofocus: false,
      onChanged: (value) => filterController.onChange(value),
      onSubmitted: (ss) => filterController.onSubmit(),
      style: TextStyle(
          fontSize: 3.5.w,
          color: maincolor1,
          fontWeight: FontWeight.normal,
          letterSpacing: 2),
      controller: textEditingController,
      cursorHeight: 7.w,
      cursorColor: Colors.grey,
      keyboardType: TextInputType.phone,
      maxLines: 1,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 1.w, right: 1.w, bottom: 2.w),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "200",
          hintStyle: TextStyle(
            fontSize: 3.5.w,
            color: maincolor1.withOpacity(0.5),
            fontWeight: FontWeight.normal,
          )),
    );
  }
}
