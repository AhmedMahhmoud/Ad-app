import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/views/more/ads/ads_widgets.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class FavAds extends StatefulWidget {
  const FavAds({Key? key}) : super(key: key);

  @override
  State<FavAds> createState() => _FavAdsState();
}

class _FavAdsState extends State<FavAds> {
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
                    SharedWidgets.pageHeader(
                        context, "الإعلانات المفضلة", true),
                    SizedBox(
                        height: dh(context) - 50.w,
                        width: dw(context),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: GridView.builder(
                              itemCount: 100,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.5,
                                      crossAxisSpacing: 1.w),
                              physics: ScrollPhysics(parent: ScrollPhysics()),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return AdsWidgets.one_ad(
                                    context, false, {}, false);
                              }),
                        )),
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
