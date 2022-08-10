import 'package:ads_app/controllers/one_ad_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/views/one_ad/one_ad_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OneAd extends StatelessWidget {
  final String id;
  OneAd({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oneAdController = Get.put(OneAdController(id));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: maincolor3,
        body: RefreshIndicator(
          onRefresh: oneAdController.getMyAds,
          child: Container(
            height: dh(context),
            width: dw(context),
            child: Stack(
              children: [
                Obx(
                  () => oneAdController.loading.value
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.w),
                            child: SpinKitSpinningCircle(
                              color: maincolor1,
                              size: 10.w,
                            ),
                          ),
                        )
                      : oneAdController.ad.value == null
                          ? Center(
                              child: Text('لا يوجد اعلان بهذا الرقم'),
                            )
                          : Stack(
                              children: [
                                SizedBox(
                                  width: dw(context),
                                  height: dh(context),
                                  child: SingleChildScrollView(
                                    physics:
                                        ScrollPhysics(parent: ScrollPhysics()),
                                    child: AnimationLimiter(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: AnimationConfiguration
                                            .toStaggeredList(
                                          duration: Duration(milliseconds: 800),
                                          childAnimationBuilder: (widget) =>
                                              SlideAnimation(
                                            horizontalOffset: 200.0,
                                            child: FadeInAnimation(
                                              child: widget,
                                            ),
                                          ),
                                          children: [
                                            // slider
                                            OneAdWidgets.header(
                                                context, oneAdController),
                                            OneAdWidgets.seller(
                                                context, oneAdController),
                                            OneAdWidgets.time_location(
                                                context, oneAdController),
                                            OneAdWidgets.options(
                                                context, oneAdController),
                                            OneAdWidgets.description(
                                                context, oneAdController),
                                            // slider
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.w),
                                                  child: gTextW(
                                                      "التعليقات",
                                                      maincolor1,
                                                      TextAlign.start,
                                                      1,
                                                      3.5,
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Obx(() => oneAdController
                                                        .comments.length >
                                                    0
                                                ? ListView.builder(
                                                    physics: ScrollPhysics(
                                                        parent:
                                                            ScrollPhysics()),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: oneAdController
                                                        .comments.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      Map comment =
                                                          oneAdController
                                                              .comments[index];
                                                      return Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 0.5.w,
                                                                horizontal:
                                                                    7.w),
                                                        child: Container(
                                                          width: dw(context),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.w),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .black12),
                                                          ),
                                                          child: ListTile(
                                                            trailing: gTextW(
                                                                comment[
                                                                    "times"],
                                                                black
                                                                    .withOpacity(
                                                                        0.6),
                                                                TextAlign.start,
                                                                1,
                                                                2.6,
                                                                FontWeight
                                                                    .bold),
                                                            title: gTextW(
                                                                comment[
                                                                    "user_id"],
                                                                black,
                                                                TextAlign.start,
                                                                1,
                                                                3.8,
                                                                FontWeight
                                                                    .bold),
                                                            subtitle: gTextW(
                                                                comment[
                                                                    "comment"],
                                                                maincolor1,
                                                                TextAlign.start,
                                                                100,
                                                                3.3,
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                        ),
                                                      );
                                                    })
                                                : SizedBox()),
                                            Obx(
                                              () => fourTabsController
                                                          .isLogin.value ==
                                                      false
                                                  ? SizedBox()
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w,
                                                              vertical: 5.w),
                                                      child: Container(
                                                        height: 16.w,
                                                        width: dw(context),
                                                        decoration: BoxDecoration(
                                                            color: white,
                                                            border: Border.all(
                                                                width: 1,
                                                                color:
                                                                    maincolor1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.w)),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      2.w,
                                                                  vertical:
                                                                      1.w),
                                                          child: TextField(
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              fontSize: 4.w,
                                                              color: black
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                            controller:
                                                                oneAdController
                                                                    .comment,
                                                            cursorHeight: 7.w,
                                                            cursorColor:
                                                                Colors.grey,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    errorBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    enabledBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    focusedBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    disabledBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    focusedErrorBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "أضف تعليقا هنا",
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          3.5.w,
                                                                      color: black
                                                                          .withOpacity(
                                                                              0.3),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    )),
                                                          ),
                                                        ),
                                                      )),
                                            ),
                                            Obx(
                                              () => fourTabsController
                                                          .isLogin.value ==
                                                      false
                                                  ? SizedBox()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 6.w),
                                                      child: InkWell(
                                                        onTap: () {
                                                          //
                                                          oneAdController
                                                              .send_ads_comment();
                                                          //
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                            child: gTextW(
                                                                "أضف تعليق",
                                                                white,
                                                                TextAlign
                                                                    .center,
                                                                1,
                                                                3.5,
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          width:
                                                              dw(context) / 2,
                                                          height: 13.w,
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    blurRadius:
                                                                        2,
                                                                    spreadRadius:
                                                                        2,
                                                                    color: maincolor1
                                                                        .withOpacity(
                                                                            0.5))
                                                              ],
                                                              color: maincolor1,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.w)),
                                                        ),
                                                      ),
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
                                //

                                OneAdWidgets.bottom_bar(oneAdController),
                                Obx(() => oneAdController.showDeleteDialog.value
                                    ? OneAdWidgets.show_delete_dialog(
                                        context, oneAdController)
                                    : SizedBox()),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(onPressed: oneAdController.getMyAds,child: Icon(Icons.add,),),
      ),
    );
  }
}
