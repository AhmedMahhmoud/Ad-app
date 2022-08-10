import 'package:ads_app/controllers/offers/offers_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AllOffersWidgets {
  //
  //

  static offer_category_horiztontial_list(
      BuildContext context, RxList list, OffersController offersController) {
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
                  offersController.selected_category.value == item["id"],
                  offersController,
                  index));
            }),
      ),
    );
  }

  static one_item_category(
      Map item, bool selected, OffersController offersController, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: InkWell(
        onTap: () {
          offersController.updateCategory(item, index);
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

  static all_offer_grid_view(List list, OffersController offersController) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 3.w),
      child: GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          physics: ScrollPhysics(parent: ScrollPhysics()),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 3.w),
          itemBuilder: (BuildContext context, int index) {
            Map item = list[index];
            return InkWell(
              onTap: () {
                offersController.viewAd(item, context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(3.w),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: black.withOpacity(0.2))
                    ]),
                child: buildNetworkImage(context, item["image"], 3.w, 3.w, 3.w,
                    3.w, 2, 2, BoxFit.cover),
              ),
            );
          }),
    );
  }
}
