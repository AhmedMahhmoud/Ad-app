import 'package:ads_app/controllers/chat/all_chats_controller.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/services/sharedServices.dart';
import 'package:dio/dio.dart';

import '../../../models/notification_model.dart';

class ChatServices {
  static Future<List> get_all_chats_service() async {
    List all_users = [];

    try {
      await Dio()
          .get(
        "$apiBaseUrl/getMessage",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': "Bearer ${fourTabsController.userMap["token"]}"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          for (Map user in response.data["users"]) {
            all_users.add(user);
          }
          return all_users;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return all_users;
  }

  static Future<List<NotificationModel>> get_all_Notifications() async {
    final res = await Dio().get(
      "$apiBaseUrl/getMessage",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': "Bearer ${fourTabsController.userMap["token"]}"
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (res.statusCode == 500) {
      throw "يوجد مشكلة بالسيرفر,حاول لاحقا";
    }
    if (res.statusCode != 200) {
      throw "يوجد مشكلة بالسيرفر,حاول لاحقا";
    }

    return (res.data['notifications'] as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
  }

  static Future<List> delete_my_account_service() async {
    List all_users = [];

    try {
      await Dio().get(
        "https://sevenkuwait.com/api/deleteAccount",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': "Bearer ${fourTabsController.userMap["token"]}"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
    } catch (e) {
      return [];
    }

    return all_users;
  }

  static Future<List> get_one_chat_service(String id) async {
    List all_messages = [];

    try {
      await Dio()
          .get(
        "$apiBaseUrl/getMessage/$id",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': "Bearer ${fourTabsController.userMap["token"]}"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        print(response.data);
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          for (Map message in response.data["messages"]) {
            all_messages.add(message);
          }
          return all_messages;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return all_messages;
  }

  static Future sendTextMessageService(
      String body, AllChatsController allChatsController, String to) async {
    print(to);
    allChatsController.messageController.clear();
    allChatsController.one_chat_messages.insert(0, {
      "to": to,
      "from": fourTabsController.userMap["id"],
      "message": body,
      "updated_at": DateTime.now().toString(),
      "created_at": DateTime.now().toString(),
      "id": "fuck"
    });
    bool done = false;

    try {
      await Dio().post("$apiBaseUrl/addMessage",
          options: Options(
            headers: {
              "Content-Type": "application/json",
              'Authorization': "Bearer ${fourTabsController.userMap["token"]}"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
          data: {"to": to, "message": body}).then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return 0;
        } else if (response.statusCode == 200) {
          allChatsController.one_chat_messages
              .removeWhere((element) => element["id"] == "fuck");
          allChatsController.one_chat_messages.insert(0, response.data["data"]);
          int index = allChatsController.all_chats
              .lastIndexWhere((element) => element["id"].toString() == to);

          if (index != -1) {
            Map dd = allChatsController.all_chats[index];
            dd["message"] = response.data["data"]["message"];
            allChatsController.all_chats.removeAt(index);
            allChatsController.all_chats.insert(index, dd);
          }

          return 0;
        } else {
          return 0;
        }
      }).catchError((Object o) {
        return 0;
      });
    } catch (e) {
      return 0;
    }

    return 0;
  }

  static Future delete_text_message_service(String id) async {
    try {
      await Dio().post(
        "$apiBaseUrl/deleteMessage/$id",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            'Authorization': "Bearer ${fourTabsController.userMap["token"]}"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
    } catch (e) {
      return 0;
    }

    return 0;
  }
}
