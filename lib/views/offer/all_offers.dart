import 'package:ads_app/controllers/offers/offers_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/more/ads/fav_ads.dart';
import 'package:ads_app/views/more/ads/last_seen_ads.dart';
import 'package:ads_app/views/more/ads/my_ads.dart';
import 'package:ads_app/views/more/more_widgets.dart';
import 'package:ads_app/views/offer/all_offers_widgets.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AllOffers extends StatefulWidget {
  const AllOffers({Key? key}) : super(key: key);

  @override
  State<AllOffers> createState() => _AllOffersState();
}

class _AllOffersState extends State<AllOffers> {
  //
  //
  OffersController offersController = Get.put(OffersController());
  //
  //
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
                    SharedWidgets.pageHeader(context, "home5".tr, false),
                    Obx(() => offersController.loading.value
                        ? Padding(
                            padding: EdgeInsets.all(5.w),
                            child: SpinKitCircle(
                              color: maincolor1,
                              size: 7.w,
                            ))
                        : AllOffersWidgets.offer_category_horiztontial_list(
                            context,
                            offersController.offers_cat,
                            offersController)),
                    Obx(
                      () => offersController.loading_cat_data.value
                          ? Padding(
                              padding: EdgeInsets.all(5.w),
                              child: SpinKitCircle(
                                color: maincolor1,
                                size: 7.w,
                              ))
                          : AllOffersWidgets.all_offer_grid_view(
                              offersController.current_offers,
                              offersController),
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
