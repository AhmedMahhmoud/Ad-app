import 'package:ads_app/services/tabs/chat/chat_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AllChatsController extends GetxController {
  RxBool loadingChats = false.obs;
  RxBool loadingOneChat = false.obs;
  RxList all_chats = [].obs;
  RxList one_chat_messages = [].obs;
  RxMap reciverMap = {}.obs;
  RxBool show_delete_message = false.obs;
  Map previous_message = {};
  Map delete_message = {};
  TextEditingController messageController = TextEditingController();

  Future getMyChats() async {
    loadingChats.value = true;
    List chats = await ChatServices.get_all_chats_service();
    all_chats.clear();
    for (var chat in chats) {
      all_chats.add(chat);
    }
    loadingChats.value = false;
  }

  Future getOneChatMessages(String userId) async {
    loadingOneChat.value = true;
    List chats = await ChatServices.get_one_chat_service(userId);

    one_chat_messages.clear();
    for (var chat in chats) {
      one_chat_messages.add(chat);
    }
    loadingOneChat.value = false;
  }

  Future sendTextMessage(
      AllChatsController allChatsController,
      ) async {
    if (messageController.text.trim().isNotEmpty) {
      await ChatServices.sendTextMessageService(messageController.text.trim(),
          allChatsController, reciverMap["id"].toString());
    }
  }

  Future delete_message_from_chat() async {
    show_delete_message.value = false;
    one_chat_messages.removeWhere(
            (element) => delete_message["Message_id"] == element["Message_id"]);
    await ChatServices.delete_text_message_service(
        delete_message["Message_id"].toString());
    int index = all_chats.lastIndexWhere(
            (element) => element["id"].toString() == reciverMap["id"].toString());
    if (index != -1) {
      Map ss = all_chats[index];
      ss["message"] =
      previous_message.length > 0 ? previous_message["message"] : "";
      all_chats.removeAt(index);
      all_chats.insert(index, ss);
    }
  }

  @override
  void onInit() {
    getMyChats();
    super.onInit();
  }
}
