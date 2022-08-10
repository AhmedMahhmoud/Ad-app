import 'package:ads_app/controllers/home/home_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/home/home_widgets.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  HomeController homeController = Get.find<HomeController>();

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
                    HomeWidgets.home_slider(
                      context,
                      homeController,
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
