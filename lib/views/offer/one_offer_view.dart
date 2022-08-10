import 'package:ads_app/controllers/offers/offers_controller.dart';
import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/tabs/ad/add_display.dart';

class OneOfferView extends StatefulWidget {
  const OneOfferView({Key? key}) : super(key: key);

  @override
  State<OneOfferView> createState() => _OneOfferViewState();
}

class _OneOfferViewState extends State<OneOfferView> {
  //
  //
  OffersController offersController = Get.find<OffersController>();
  //
  //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawerScrimColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          body: InkWell(
            onTap: () => Navigator.pop(
              context,
            ),
            child: Container(
              height: dh(context),
              width: dw(context),
              color: black.withOpacity(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: buildNetworkImage(
                        context,
                        offersController.currentOffer["image"],
                        0,
                        0,
                        0,
                        0,
                        dw(context),
                        dw(context),
                        BoxFit.cover),
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            await launch(
                                'tel:${offersController.currentOffer["phone"]}');
                          },
                          child: Container(
                            height: 10.w,
                            width: 15.w,
                            decoration: BoxDecoration(
                              color: maincolor1,
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.phone,
                                size: 6.w,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dw(context) / 4,
                        ),
                        InkWell(
                          onTap: () async {
                            DisplayAd.displayAd(
                                offersController.currentOffer["phone"]);
                          },
                          child: Container(
                            height: 10.w,
                            width: 15.w,
                            decoration: BoxDecoration(
                              color: maincolor1,
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.whatsapp,
                                size: 6.w,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
