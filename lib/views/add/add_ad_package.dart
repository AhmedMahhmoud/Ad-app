import 'package:ads_app/controllers/add_ad/add_ad_controller.dart';
import 'package:ads_app/controllers/more/wallet_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/add/add_ad_filters.dart';
import 'package:ads_app/views/add/add_ad_widget.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddAdPackage extends StatefulWidget {
  const AddAdPackage({Key? key}) : super(key: key);

  @override
  State<AddAdPackage> createState() => _AddAdPackageState();
}

class _AddAdPackageState extends State<AddAdPackage> {
  AddAdController addAdController = Get.find<AddAdController>();
  WalletController walletController = Get.put(WalletController());

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: Duration(milliseconds: 800),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 200.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    SharedWidgets.pageHeader(context, "addad9".tr, true),
                    //
                    //
                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: gTextW("addad10".tr, black, TextAlign.start, 1, 4,
                          FontWeight.bold),
                    ),
                    //
                    //
                    Obx(
                      () => walletController.loading.value
                          ? SpinKitCircle(
                              color: maincolor1,
                              size: 7.w,
                            )
                          : ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(parent: ScrollPhysics()),
                              children: [
                                Obx(() => AddAdWidget.one_package(
                                        true,
                                        addAdController.atHome.value,
                                        "addad11".tr,
                                        walletController
                                            .walletMap["main section"],
                                        (value) {
                                      addAdController.atHome.value = value;
                                    })),
                                Obx(() => AddAdWidget.one_package(
                                        true,
                                        addAdController.atCategory.value,
                                        "addad12".tr,
                                        walletController
                                            .walletMap["advertisement page"],
                                        (value) {
                                      addAdController.atCategory.value = value;
                                    })),
                                Obx(() => AddAdWidget.one_package(
                                    false,
                                    true,
                                    "addad13".tr,
                                    walletController.walletMap["ads cost"],
                                    (value) {})),
                              ],
                            ),
                    ),

                    //
                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: gTextW("addad14".tr, black, TextAlign.start, 1, 4,
                          FontWeight.bold),
                    ),

                    Obx(
                      () => walletController.loading.value
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(
                                      5.w,
                                    ),
                                    border: Border.all(
                                        width: 2,
                                        color: black.withOpacity(0.3))),
                                child: Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        ScrollPhysics(parent: ScrollPhysics()),
                                    children: [
                                      Obx(
                                        () => AddAdWidget.final_price_row(
                                            "addad15".tr,
                                            addAdController
                                                .get_total_price(
                                                    walletController)
                                                .value
                                                .toString()),
                                      ),
                                      Obx(
                                        () =>
                                            walletController.walletMap.length ==
                                                    0
                                                ? SizedBox()
                                                : AddAdWidget.final_price_row(
                                                    "addad16".tr,
                                                    walletController
                                                        .walletMap["user_money"]
                                                        .toString()),
                                      ),
                                      Obx(
                                        () => double.parse(walletController
                                                    .walletMap["user_money"]
                                                    .toString()) <
                                                addAdController
                                                    .get_total_price(
                                                        walletController)
                                                    .value
                                            ? AddAdWidget.final_price_row(
                                                "addad17".tr,
                                                (addAdController
                                                            .get_total_price(
                                                                walletController)
                                                            .value -
                                                        double.parse(
                                                            walletController
                                                                .walletMap[
                                                                    "user_money"]
                                                                .toString()))
                                                    .toString())
                                            : SizedBox(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(2.w),
                                        child: Divider(
                                          color: black.withOpacity(0.6),
                                        ),
                                      ),
                                      Obx(
                                        () => AddAdWidget.agree_to_terms(
                                            addAdController.agree.value,
                                            (vlaue) {
                                          addAdController.agree.value = vlaue;
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                    //

                    //
                    //
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.w),
                      child: InkWell(
                        onTap: () {
                          addAdController.uploadOrCharge(
                              context, addAdController, walletController);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: maincolor1,
                              borderRadius: BorderRadius.circular(5.w)),
                          height: 12.w,
                          width: dw(context),
                          child: Center(
                            child: gTextW("addad18".tr, white, TextAlign.center,
                                1, 4, FontWeight.bold),
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
