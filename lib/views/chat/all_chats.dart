import 'package:ads_app/controllers/chat/all_chats_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/chat/one_chat.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AllChats extends StatefulWidget {
  const AllChats({Key? key}) : super(key: key);

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  AllChatsController allChatsController = Get.put(AllChatsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: RefreshIndicator(
          onRefresh: () async {
            allChatsController.getMyChats();
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
                      SharedWidgets.pageHeader(context, "chat1".tr, false),
                      Container(
                        height: dh(context) - 30.w,
                        width: dw(context),
                        color: Colors.transparent,
                        child: Obx(
                              () => allChatsController.loadingChats.value
                              ? Center(
                            child: SpinKitCircle(
                              color: maincolor1,
                              size: 10.w,
                            ),
                          )
                              : ListView.builder(
                            physics:
                            ScrollPhysics(parent: ScrollPhysics()),
                            scrollDirection: Axis.vertical,
                            itemCount:
                            allChatsController.all_chats.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              Map outSideMessageModel =
                              allChatsController.all_chats[index];

                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w,
                                    right: 5.w,
                                    top: 2.w,
                                    bottom: 10 == ++index ? 20.w : 2.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(100.w)),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.w),
                                    child: ListTile(
                                      onTap: () {
                                        allChatsController.getOneChatMessages(
                                            "${outSideMessageModel["id"]}");
                                        allChatsController.reciverMap
                                            .value = outSideMessageModel;
                                        navigateForward(
                                            OneChat(),
                                            Transition.fadeIn,
                                            Curves.easeInOut,
                                            500,
                                            [outSideMessageModel]);
                                      },
                                      contentPadding: EdgeInsets.all(0),
                                      title: gTextW(
                                          "${outSideMessageModel["name"]}",
                                          maincolor1,
                                          TextAlign.start,
                                          1,
                                          3.5,
                                          FontWeight.bold),
                                      subtitle: gTextW(
                                          "${outSideMessageModel["message"]}",
                                          black.withOpacity(0.7),
                                          TextAlign.start,
                                          1,
                                          3,
                                          FontWeight.bold),
                                      trailing: Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 5.w),
                                        child: gTextW(
                                            "${outSideMessageModel["times"]}",
                                            black.withOpacity(0.5),
                                            TextAlign.start,
                                            1,
                                            2.5,
                                            FontWeight.bold),
                                      ),
                                      leading: buildNetworkImage(
                                          context,
                                          "${outSideMessageModel["image"]}",
                                          100.w,
                                          100.w,
                                          100.w,
                                          100.w,
                                          13.w,
                                          13.w,
                                          BoxFit.cover),
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

//
//
//
