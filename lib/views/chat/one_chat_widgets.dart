import 'package:ads_app/controllers/chat/all_chats_controller.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ads_app/helpers/constants.dart';

class OneChatScreenWidgets {
  static appBar(BuildContext context, AllChatsController allChatsController) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      height: 14.w,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  navigateBack(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 7.w,
                  color: white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: white)),
                  child: buildNetworkImage(
                      context,
                      allChatsController.reciverMap["image"],
                      100.w,
                      100.w,
                      100.w,
                      100.w,
                      11.w,
                      11.w,
                      BoxFit.cover),
                ),
              ),
              gTextW(allChatsController.reciverMap["name"], white,
                  TextAlign.start, 2, 3.8, FontWeight.bold),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: maincolor1,
        ),
        height: 14.w,
        width: dw(context),
      ),
    );
  }

  static messageBox(Map inSideMessageModel, BuildContext context, int index,
      AllChatsController allChatsController) {
    bool isMine =
        inSideMessageModel["from"] == fourTabsController.userMap["id"];

    return textMessage(
        inSideMessageModel, index, isMine, context, allChatsController);
  }

  //

  static show_delete_dialog(
    BuildContext context,
    AllChatsController allChatsController,
  ) {
    return InkWell(
      onTap: () => allChatsController.show_delete_message.value = false,
      child: Container(
        height: dh(context),
        width: dw(context),
        color: black.withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: dw(context),
                  height: dw(context) / 3,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: gTextW("حذف الرسالة ؟", black, TextAlign.center,
                            1, 3.3, FontWeight.bold),
                      )),
                      Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                allChatsController.delete_message_from_chat();
                              },
                              child: Container(
                                height: 10.w,
                                width: dw(context) / 4,
                                decoration: BoxDecoration(
                                    color: maincolor1,
                                    border:
                                        Border.all(width: 1, color: maincolor1),
                                    borderRadius: BorderRadius.circular(3.w)),
                                child: Center(
                                  child: gTextW(
                                      "more10".tr,
                                      white,
                                      TextAlign.center,
                                      1,
                                      3.8,
                                      FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              onTap: () => allChatsController
                                  .show_delete_message.value = false,
                              child: Container(
                                height: 10.w,
                                width: dw(context) / 4,
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(width: 1, color: black),
                                    borderRadius: BorderRadius.circular(3.w)),
                                child: Center(
                                  child: gTextW(
                                      "more11".tr,
                                      black,
                                      TextAlign.center,
                                      1,
                                      3.8,
                                      FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static textMessage(Map inSideMessageModel, int index, bool isMine,
      BuildContext context, AllChatsController allChatsController) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
        child: InkWell(
          onLongPress: () async {
            print(index);
            if (isMine) {
              if (allChatsController.one_chat_messages.length > 1) {
                allChatsController.previous_message =
                    allChatsController.one_chat_messages[index + 1];
              }
              allChatsController.delete_message = inSideMessageModel;
              allChatsController.show_delete_message.value = true;
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: isMine ? white : Colors.blueAccent.shade400,
                borderRadius: BorderRadius.circular(2.w)),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: dw(context) * (2 / 3),
              ),
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.5.w, horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: isMine
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      gTextW(
                          inSideMessageModel["message"],
                          isMine ? Colors.black.withOpacity(0.8) : white,
                          isMine ? TextAlign.end : TextAlign.start,
                          1000,
                          3.5,
                          FontWeight.bold),
                      SizedBox(
                        height: 1.w,
                      ),
                      gTextW(
                          inSideMessageModel["created_at"],
                          isMine
                              ? Colors.black.withOpacity(0.3)
                              : white.withOpacity(0.6),
                          isMine ? TextAlign.end : TextAlign.start,
                          1000,
                          2.5,
                          FontWeight.bold),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  static messagesList(
      BuildContext context, AllChatsController allChatsController) {
    return Positioned(
      bottom: 18.w,
      top: 14.w,
      left: 0,
      right: 0,
      child: Container(
        height: dh(context),
        width: dw(context),
        color: Colors.transparent,
        child: Obx(
          () => allChatsController.loadingOneChat.value
              ? Center(
                  child: SpinKitCircle(
                    color: maincolor1,
                    size: 10.w,
                  ),
                )
              : Obx(
                  () => ListView.builder(
                    reverse: true,
                    physics: ScrollPhysics(parent: ScrollPhysics()),
                    scrollDirection: Axis.vertical,
                    itemCount: allChatsController.one_chat_messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map inSideMessageModel =
                          allChatsController.one_chat_messages[index];
                      return messageBox(inSideMessageModel, context, index,
                          allChatsController);
                    },
                  ),
                ),
        ),
      ),
    );
  }

  static messageTextField(
      BuildContext context, AllChatsController allChatsController) {
    return Positioned(
      bottom: 2.w,
      left: 5.w,
      right: 16.w,
      child: Container(
          decoration: BoxDecoration(
              color: maincolor1, borderRadius: BorderRadius.circular(10.w)),
          width: dw(context) - 20.w,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: dh(context) / 4,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: allChatsController.messageController,
                maxLines: null,
                style: TextStyle(
                    color: white, fontSize: 3.5.w, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                cursorColor: white,
                cursorHeight: 7.w,
                obscureText: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.w),
                    border: InputBorder.none,
                    hintText: "chat2".tr,
                    hintStyle: TextStyle(
                        color: white,
                        fontSize: 3.5.w,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )),
    );
  }

  static footer(BuildContext context, AllChatsController allChatsController) {
    return Positioned(
      bottom: 0.w,
      right: 0,
      left: 0,
      height: 16.w,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        height: 16.w,
        width: dw(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // send new message
                  allChatsController.sendTextMessage(allChatsController);
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: maincolor1, shape: BoxShape.circle),
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Center(
                        child: Icon(
                          Icons.send,
                          size: 6.5.w,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
