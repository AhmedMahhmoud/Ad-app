import 'package:ads_app/controllers/home/home_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/home/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: RefreshIndicator(
          onRefresh: () async {
            homeController.getHomeData();
          },
          child: SizedBox(
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
                      HomeWidgets.home_header(context),
                      Obx(() => homeController.loading.value
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: 15.w,
                              ),
                              child: Center(
                                child: SpinKitCircle(
                                  color: maincolor1,
                                  size: 10.w,
                                ),
                              ),
                            )
                          : Obx(
                              () => homeController.slider.length == 0
                                  ? SizedBox()
                                  : HomeWidgets.home_slider(
                                      context, homeController),
                            )),
                      Obx(
                        () => homeController.loading.value
                            ? SizedBox()
                            : HomeWidgets.categories_list(
                                context, homeController),
                      ),
                      Obx(
                        () => homeController.loading.value
                            ? SizedBox()
                            : ListView.builder(
                                itemCount: homeController.secondCat1.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(parent: ScrollPhysics()),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  Map item = homeController.secondCat1[index];
                                  return item["subCategries"].length == 0
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              bottom: index == 9 ? 30.w : 0),
                                          child: HomeWidgets
                                              .home_one_horizontial_list(
                                                  context,
                                                  homeController,
                                                  item,
                                                  item["id"].toString()));
                                },
                              ),
                      ),
                      Obx(
                        () => homeController.loading.value
                            ? SizedBox()
                            : ListView.builder(
                                itemCount: homeController.secondCat2.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(parent: ScrollPhysics()),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  Map item = homeController.secondCat2[index];
                                  return item["subCategries"].length == 0
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              bottom: index == 9 ? 30.w : 0),
                                          child: HomeWidgets
                                              .home_one_horizontial_list(
                                                  context,
                                                  homeController,
                                                  item,
                                                  item["id"].toString()));
                                },
                              ),
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
      ),
    );
  }
}
