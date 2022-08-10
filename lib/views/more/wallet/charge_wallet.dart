import 'package:ads_app/controllers/more/more_controller.dart';
import 'package:ads_app/controllers/more/wallet_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/views/more/ads/fav_ads.dart';
import 'package:ads_app/views/more/ads/last_seen_ads.dart';
import 'package:ads_app/views/more/ads/my_ads.dart';
import 'package:ads_app/views/more/ads/static_page.dart';
import 'package:ads_app/views/more/more_widgets.dart';
import 'package:ads_app/views/more/wallet/wallet_widgets.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChargeWallet extends StatefulWidget {
  const ChargeWallet({Key? key}) : super(key: key);

  @override
  State<ChargeWallet> createState() => _ChargeWalletState();
}

class _ChargeWalletState extends State<ChargeWallet> {
  WalletController walletController = Get.find<WalletController>();
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: Duration(milliseconds: 800),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 200.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        SharedWidgets.pageHeader(context, "more12".tr, true),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10.w, left: 5.w, right: 5.w),
                          child: gTextW("more13".tr, black, TextAlign.start, 1,
                              4, FontWeight.bold),
                        ),
                        Container(
                          height: dw(context) / 2.5,
                          width: dw(context),
                          child: Image.asset(
                            "assets/images/wallet_2.png",
                            fit: BoxFit.fitHeight,
                            height: dh(context) / 2,
                            width: dw(context),
                          ),
                        ),

                        WalletWidgets.newAmoutToPay(walletController, context),

                        Padding(
                          padding:
                              EdgeInsets.only(top: 10.w, left: 5.w, right: 5.w),
                          child: gTextW("more14".tr, black, TextAlign.start, 1,
                              4, FontWeight.bold),
                        ),
                        //
                        //
                        WalletWidgets.choosePaymentMethod(
                            walletController, context),

                        //
                        //
                        WalletWidgets.payButton(context, walletController),
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
