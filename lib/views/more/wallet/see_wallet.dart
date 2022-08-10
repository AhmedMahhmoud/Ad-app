import 'package:ads_app/controllers/more/more_controller.dart';
import 'package:ads_app/controllers/more/wallet_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/more/ads/fav_ads.dart';
import 'package:ads_app/views/more/ads/last_seen_ads.dart';
import 'package:ads_app/views/more/ads/my_ads.dart';
import 'package:ads_app/views/more/ads/static_page.dart';
import 'package:ads_app/views/more/more_widgets.dart';
import 'package:ads_app/views/more/wallet/charge_wallet.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SeeWallet extends StatefulWidget {
  const SeeWallet({Key? key}) : super(key: key);

  @override
  State<SeeWallet> createState() => _SeeWalletState();
}

class _SeeWalletState extends State<SeeWallet> {
  WalletController walletController = Get.put(WalletController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: maincolor3,
        body: SizedBox(
          width: dw(context),
          height: dh(context),
          child: Stack(
            children: [
              SingleChildScrollView(
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
                        SharedWidgets.pageHeader(context, "more15".tr, true),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.w, horizontal: 10.w),
                              child: gTextW("more16".tr, black, TextAlign.start,
                                  1, 4, FontWeight.normal),
                            ),
                          ],
                        ),
                        Obx(
                          () => walletController.loading.value
                              ? SpinKitSpinningCircle(
                                  color: maincolor1,
                                  size: 7.w,
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10.w, left: 10.w, right: 10.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: maincolor1.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(3.w),
                                    ),
                                    height: dw(context) / 2,
                                    width: dw(context),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.w, horizontal: 5.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 5.w,
                                                  ),
                                                  child: gTextW(
                                                      "more17".tr,
                                                      black,
                                                      TextAlign.start,
                                                      1,
                                                      4,
                                                      FontWeight.bold),
                                                ),
                                                gTextW(
                                                    "k.D ${walletController.walletMap["user_money"]}",
                                                    maincolor1,
                                                    TextAlign.start,
                                                    1,
                                                    4,
                                                    FontWeight.bold),
                                                Expanded(child: SizedBox()),
                                                InkWell(
                                                  onTap: () {
                                                    navigateForward(
                                                        ChargeWallet(),
                                                        Transition.leftToRight,
                                                        Curves.easeInOut,
                                                        500, []);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.arrow_back,
                                                        size: 5.w,
                                                        color: maincolor1,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    2.w),
                                                        child: gTextW(
                                                            "more12".tr,
                                                            maincolor1,
                                                            TextAlign.start,
                                                            1,
                                                            3.5,
                                                            FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            flex: 2,
                                          ),
                                          Expanded(
                                            child: Center(
                                                child: Image.asset(
                                                    "assets/images/wallet_1.png",
                                                    fit: BoxFit.scaleDown)),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                        Obx(
                          () => walletController.loading.value
                              ? SizedBox()
                              : Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.w, horizontal: 10.w),
                                      child: gTextW(
                                          "عدد الإعلانات النشطة : ${walletController.walletMap["active_ads"]}",
                                          black,
                                          TextAlign.start,
                                          1,
                                          4,
                                          FontWeight.normal),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: 20.w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
