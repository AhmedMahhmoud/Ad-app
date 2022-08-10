import 'package:ads_app/controllers/home/search_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/home/home_widgets.dart';
import 'package:ads_app/views/more/ads/ads_widgets.dart';
import 'package:ads_app/views/one_ad/one_ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchController searchController = Get.put(SearchController());
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
                          height: 20.w,
                          width: dw(context),
                        ),
                        Obx(
                          () => searchController.loading.value
                              ? Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: Center(
                                      child: SpinKitSpinningCircle(
                                    color: maincolor1,
                                    size: 8.w,
                                  )),
                                )
                              : Obx(
                                  () => searchController.is_searched.value &&
                                          searchController.ads.length == 0
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.w,
                                          ),
                                          child: Center(
                                            child: gTextW(
                                                "جرب كلمات أخري . . .",
                                                maincolor1,
                                                TextAlign.center,
                                                1,
                                                3,
                                                FontWeight.bold),
                                          ),
                                        )
                                      : Obx(
                                          () => searchController.ads.length == 0
                                              ? SizedBox()
                                              : Padding(
                                                  padding: EdgeInsets.all(2.w),
                                                  child: GridView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          searchController
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
                                                            searchController
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
                                                                searchController
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
              Container(
                height: 20.w,
                width: dw(context),
                color: white,
                child: HomeWidgets.search_header(context, searchController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
