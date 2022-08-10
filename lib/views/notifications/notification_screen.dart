import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/constants.dart';
import '../shared/shared_widgets.dart';
import 'controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getAllNotifications();
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
                      SharedWidgets.pageHeader(context, "notifications".tr, false),
                      Container(
                        height: dh(context) - 20.w,
                        width: dw(context),
                        color: Colors.transparent,
                        child: Obx(
                              () => controller.loadingChats.value
                              ? Center(
                            child: SpinKitCircle(
                              color: maincolor1,
                              size: 10.w,
                            ),
                          )
                              : controller.notifications.isEmpty
                              ? Center(child: Text('لايوجد اشعارات'))
                              : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: controller
                                .notifications.length -1,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w,
                                    right: 5.w,
                                    top: 2.w,
                                    bottom:
                                    10 == ++index ? 20.w : 2.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(
                                          100.w)),
                                  child: Padding(
                                    padding: EdgeInsets.all(3.w),
                                    child: ListTile(
                                      onTap: () {
                                        // controller.getOneChatMessages(
                                        //     "${outSideMessageModel["id"]}");
                                        // controller.reciverMap
                                        //     .value = outSideMessageModel;
                                        // navigateForward(
                                        //     OneChat(),
                                        //     Transition.fadeIn,
                                        //     Curves.easeInOut,
                                        //     500,
                                        //     [outSideMessageModel]);
                                      },
                                      contentPadding:
                                      EdgeInsets.all(0),
                                      title: gTextW(
                                          "${controller.notifications[index].title}",
                                          maincolor1,
                                          TextAlign.start,
                                          1,
                                          3.5,
                                          FontWeight.bold),
                                      subtitle: gTextW(
                                          "${controller.notifications[index].message}",
                                          black.withOpacity(0.7),
                                          TextAlign.start,
                                          1,
                                          3,
                                          FontWeight.bold),
                                      // trailing: Padding(
                                      //   padding:
                                      //       EdgeInsets.only(bottom: 5.w),
                                      //   child: gTextW(
                                      //       "${outSideMessageModel["times"]}",
                                      //       black.withOpacity(0.5),
                                      //       TextAlign.start,
                                      //       1,
                                      //       2.5,
                                      //       FontWeight.bold),
                                      // ),
                                      // leading: buildNetworkImage(
                                      //     context,
                                      //     "${outSideMessageModel["image"]}",
                                      //     100.w,
                                      //     100.w,
                                      //     100.w,
                                      //     100.w,
                                      //     13.w,
                                      //     13.w,
                                      //     BoxFit.cover),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.w,
                        width: dw(context),
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
