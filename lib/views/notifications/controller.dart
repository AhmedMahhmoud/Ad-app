import 'dart:developer';

import 'package:get/get.dart';

import '../../helpers/globalWidget.dart';
import '../../models/notification_model.dart';
import '../../services/tabs/chat/chat_services.dart';

class NotificationController extends GetxController{
  final notifications = <NotificationModel>[].obs;
  RxBool loadingChats = false.obs;
  Future<void> getAllNotifications()async{
    try{
      notifications.clear();
      loadingChats.value = true;
      notifications.addAll(await ChatServices.get_all_Notifications());
    }catch(e,st){
      log(e.toString());
      log(st.toString());
      buildToast(e.toString());
    }finally{
      loadingChats.value = false;
    }
  }

  @override
  void onInit() {
    getAllNotifications();
    super.onInit();
  }
}