import 'package:ads_app/controllers/add_ad/add_ad_controller.dart';
import 'package:ads_app/controllers/add_ad/edit_ad_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/add/add_ad_widget.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditAd extends StatefulWidget {
  const EditAd({Key? key}) : super(key: key);

  @override
  State<EditAd> createState() => _EditAdState();
}

class _EditAdState extends State<EditAd> {
  EditAdController editAdController = Get.put(EditAdController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: SizedBox(
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
                    verticalOffset: 200.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    SharedWidgets.pageHeader(context, "تعديل الإعلان", true),
                    //

                    SizedBox(
                      height: 5.w,
                    ),

                    AddAdWidget.buildOneField(
                        editAdController,
                        context,
                        "addad2".tr,
                        editAdController.title,
                        TextInputType.text,
                        1,
                        ""),
                    SizedBox(
                      height: 5.w,
                    ),

                    AddAdWidget.buildOneField(
                      editAdController,
                      context,
                      "addad3".tr,
                      editAdController.price,
                      TextInputType.number,
                      1,
                      "addad4".tr,
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    AddAdWidget.buildOneField(
                        editAdController,
                        context,
                        "addad5".tr,
                        editAdController.description,
                        TextInputType.text,
                        5,
                        ""),
                    //
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.w),
                      child: InkWell(
                        onTap: () {
                          editAdController.upload_new_data();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: maincolor1,
                              borderRadius: BorderRadius.circular(5.w)),
                          height: 12.w,
                          width: dw(context),
                          child: Center(
                            child: gTextW("تأكيد", white, TextAlign.center, 1,
                                4, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                    //
                    SizedBox(
                      height: 20.w,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
