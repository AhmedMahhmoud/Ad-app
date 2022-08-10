import 'package:ads_app/controllers/more/wallet_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/views/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WalletWidgets {
  static newAmoutToPay(
      WalletController walletController, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        height: 12.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            color: white,
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: black.withOpacity(0.1),
              )
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SharedWidgets.sharedTextField(
                      context,
                      walletController.amountController,
                      "more18".tr,
                      black,
                      TextInputType.number, (value) {
                walletController.totalToAdd.value = value.toString();
              }, 1, "")),
              gTextW(
                  "addad4".tr, black, TextAlign.start, 1, 3.5, FontWeight.bold),
            ],
          ),
        ),
      ),
    );
  }

  static choosePaymentMethod(
      WalletController walletController, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w, left: 5.w),
      child: Obx(
        () => ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(parent: ScrollPhysics()),
          scrollDirection: Axis.vertical,
          children: [
            paymentMethodItem(
                context,
                walletController,
                "more19".tr,
                "assets/images/wallet_3.png",
                walletController.paymentMethod.value == 1,
                1),
            paymentMethodItem(
                context,
                walletController,
                "more20".tr,
                "assets/images/wallet_4.png",
                walletController.paymentMethod.value == 2,
                2),
            paymentMethodItem(
                context,
                walletController,
                "more21".tr,
                "assets/images/wallet_5.png",
                walletController.paymentMethod.value == 3,
                3),
          ],
        ),
      ),
    );
  }

  static paymentMethodItem(
      BuildContext context,
      WalletController walletController,
      String title,
      String imagePath,
      bool selected,
      int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.w),
      child: Container(
        height: 12.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            color: selected ? white : black.withOpacity(0.05),
            border: Border.all(
                width: 1,
                color: selected ? maincolor1 : black.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: black.withOpacity(0.05),
              )
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: InkWell(
            onTap: () {
              walletController.paymentMethod.value = index;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gTextW(title, black, TextAlign.start, 1, 4, FontWeight.bold),
                Image.asset(
                  imagePath,
                  height: 10.w,
                  width: 10.w,
                  fit: BoxFit.scaleDown,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static payButton(BuildContext context, WalletController walletController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 11.w,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(width: 1, color: maincolor1),
              ),
              child: Obx(
                () => Center(
                  child: gTextW(
                      "K.D ${walletController.totalToAdd.value.length > 0 ? walletController.totalToAdd.value : 0.0}",
                      black,
                      TextAlign.center,
                      1,
                      4,
                      FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          InkWell(
            onTap: () {
              walletController.initiatePayment(
                context,
              );
            },
            child: Container(
              height: 11.w,
              width: dw(context) / 3.5,
              decoration: BoxDecoration(
                color: maincolor1,
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(width: 1, color: maincolor1),
              ),
              child: Center(
                child: gTextW("more22".tr, white, TextAlign.center, 1, 4,
                    FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
