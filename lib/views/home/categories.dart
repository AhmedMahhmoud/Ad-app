import 'package:ads_app/controllers/home/home_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/home/home_widgets.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/globalWidget.dart';
import '../../services/tabs/ad/add_display.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  HomeController homeController = Get.find<HomeController>();
  int _current = 0;
  final CarouselController _controller = CarouselController();
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
                    SharedWidgets.pageHeader(context, "home1".tr, true),
                    Padding(
                      padding: EdgeInsets.only(top: 2.w, bottom: 5.w),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height / 4,
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Expanded(
                                child: CarouselSlider(
                                  carouselController: _controller,
                                  items: homeController.slider.map((item) {
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        child: InkWell(
                                            onTap: () async {
                                              DisplayAd.displayAd(
                                                  item['phone']);
                                            },
                                            child: buildNetworkImage(
                                                context,
                                                "${item['image']}",
                                                3.w,
                                                3.w,
                                                3.w,
                                                3.w,
                                                0,
                                                0,
                                                BoxFit.fill)));
                                  }).toList(),
                                  options: CarouselOptions(
                                    aspectRatio: 1.0,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: false,
                                    initialPage: 0,
                                    onPageChanged: (s, c) {
                                      setState(() {
                                        _current = s;
                                      });
                                    },
                                    pageSnapping: true,
                                    pauseAutoPlayOnManualNavigate: true,
                                    pauseAutoPlayInFiniteScroll: false,
                                    autoPlayInterval:
                                        const Duration(seconds: 5),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 1500),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                  ),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: homeController.slider
                                .asMap()
                                .entries
                                .map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 7.0,
                                  height: 7.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(_current == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ), // banner a category and sub category
                    Obx(
                      () => homeController.loading.value
                          ? SizedBox()
                          : HomeWidgets.categories_gridview(
                              context, homeController),
                    ),
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
    );
  }
}
