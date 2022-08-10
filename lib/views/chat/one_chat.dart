import 'package:ads_app/controllers/chat/all_chats_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/chat/one_chat_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
//
class OneChat extends StatefulWidget {
  const OneChat({Key? key}) : super(key: key);

  @override
  State<OneChat> createState() => _OneChatState();
}

class _OneChatState extends State<OneChat> {
  final AllChatsController allChatsController = Get.find<AllChatsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: dh(context),
        width: dw(context),
        color: maincolor1.withOpacity(0.2),
        child: Stack(
          children: [
            // Messages
            OneChatScreenWidgets.messagesList(context, allChatsController),

            // header
            OneChatScreenWidgets.appBar(context, allChatsController),
            // OneChatScreenWidgets.appBarMore(),
            // footer
            OneChatScreenWidgets.footer(context, allChatsController),
            OneChatScreenWidgets.messageTextField(context, allChatsController),
            //

            Material(
                color: Colors.transparent,
                child: Obx(() => allChatsController.show_delete_message.value
                    ? OneChatScreenWidgets.show_delete_dialog(
                        context, allChatsController)
                    : SizedBox()))
          ],
        ),
      )),
    );
  }
}
//
//
