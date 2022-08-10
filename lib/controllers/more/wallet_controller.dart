import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:ads_app/services/tabs/more/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';

class WalletController extends GetxController {
  //
  RxBool loading = false.obs;
  RxBool loadingCharge = false.obs;
  RxMap walletMap = {}.obs;
  TextEditingController amountController = TextEditingController();
  RxString totalToAdd = "0.0".obs;
  RxInt paymentMethod = 1.obs;
  int paymentMethodId = 0;

  Future getWalletData() async {
    loading.value = true;
    Map data = await WalletService.get_wallet_service();
    walletMap.clear();
    walletMap.value = data;
    loading.value = false;
  }

  Future charge_wallet() async {
    loadingCharge.value = true;
    Map data = await WalletService.charge_wallet_service(
        totalToAdd.value, paymentMethodId.toString());
    paymentMethodId = 0;
    paymentMethod.value = 1;
    totalToAdd.value = "0.0";
    loadingCharge.value = false;
  }

  void initiatePayment(BuildContext context) {
    if (double.parse(totalToAdd.value) > 0.0) {
      final String mAPIKey =
          "rdihYRkPQ1922NG2QYRtq4U69NUHxteS-Jn1p2E3B9odNxhmphbGltcL-5E97l1KqveeTnQjfJ1lTPT7DygVd6glt-gj0DhonHgZ5Qe7QFQyuBrqnYycuMR3perDo6cmwzmcEhgwem8vngjbWH8MhVn3Lehfln-d9V4yO7SEkIWaHKt9fZTNSg71kbcTV1xQv8OHTdwoWzjgCYy7FwZQLsgsdAYeQ0gM51Y-HMzwprOzVE1CAl4gHuFmK0_18n_UIBULQzzWp6fijBjFWjLh-WdQRjvgWnamfTv2hLcNQ_Zxc1VzFFdcyK7_YJxsP9t4KTJl1Ip3mEfDAnklx_uM5KBc8a256RZfGFoCrVIsKP-R4LpMSN1haIojw8ZApeabH0s5FK0kAEelmicdIIx3XB2HhcROrxVzQmwMkM4z88gOyFIauNxgeJcqvvDhCS1KAsM5U3N34TvyNuDHipdHhlpOHUgw72vgJLaa-DlmAPGv_mhYH8yzWK7dDd-MMTPGMCZ9bDuYdX8U0X0oPLgDjZAb1lGVsaCk1D8UB4OGP5-90ik78W_-6-N-OVyX8YcXxTbmVQlYhEr1Er4DqHEP3SyCphj1sT02C6N_M22NsxOeVBIUgNByUtvttntTG9VZ3Pt07g29C-B0egzCKg9LJMpmnNjOjtteSiwGl4WZTbemJj8NP-USVIzN7m1kI32Y-KWUltDTg8bjl59BN6x6_urtRlFYM1MR6xWpAqAHHafQEeERSjz6GSh2tfxxaEKLTPYzTw";
      MFSDK.init(mAPIKey, MFCountry.KUWAIT, MFEnvironment.LIVE);

      MFSDK.setUpAppBar(
        title: "Payment",
        titleColor: white, // Color(0xFFFFFFFF)
        backgroundColor: maincolor1, // Color(0xFF000000)
        isShowAppBar: true,
      ); // For Android platform only

      var request = new MFInitiatePaymentRequest(
          double.parse(totalToAdd.value), MFCurrencyISO.KUWAIT_KWD);

      MFSDK.initiatePayment(
          request,
          MFAPILanguage.EN,
          (MFResult<MFInitiatePaymentResponse> result) =>
              {resultActions(result, context)});
    } else {
      buildToast("اكتب المبلغ المراد شحنه");
    }
  }

  resultActions(MFResult mfResult, BuildContext context) async {
    int paymentMethodId = paymentMethod.value == 1
        ? mfResult.response?.paymentMethods![0].paymentMethodId
        : mfResult.response?.paymentMethods![1].paymentMethodId;

    if (mfResult.isSuccess()) {
      executeRegularPayment(
        paymentMethodId,
        context,
        totalToAdd.value,
      );
    } else {
      mfResult.error?.message;
    }
    //
  }

/*
    Execute Regular Payment
   */
  Future executeRegularPayment(
      int paymentMethodId, BuildContext context, String amount) async {
    var request =
        new MFExecutePaymentRequest(paymentMethodId, double.parse(amount));
    request.suppliers = List.of([
      Supplier(
          supplierCode: 18,
          invoiceShare: double.parse(amount),
          proposedShare: null)
    ]);

    // MFSDK.executePayment(context, request, MFAPILanguage.EN,
    //     (String invoiceId, MFResult<MFPaymentStatusResponse> result) async {
    //   if (result.isSuccess()) {
    //     buildToast("تم الدفع بنجاح");
    //     Get.back();
    //     await charge_wallet();
    //     await getWalletData();
    //     if (Get.arguments[1]) {
    //       navigateBack(context);
    //     }
    //   } else {
    //     buildToast("لم يكتمل الدفع للأسف");
    //   }
    // });
  }

  @override
  void onInit() {
    getWalletData();
    super.onInit();
  }
}
