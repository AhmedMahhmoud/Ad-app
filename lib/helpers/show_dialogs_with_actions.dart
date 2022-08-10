import 'package:ads_app/helpers/constants.dart';
import 'package:ads_app/helpers/navigateMethods.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class Dialogs_With_Actions {
  static Future show_first_opening_app(
    BuildContext context,
    String title,
    String iconPath,
    Color color,
  ) async {
    await showDialog(
        useRootNavigator: true,
        barrierColor: Colors.white70,
        useSafeArea: true,
        context: context,
        builder: (_) => FunkyOverlay(title, iconPath, color));
  }
}

class FunkyOverlay extends StatefulWidget {
  final String title;
  final String iconPath;
  final Color color;

  const FunkyOverlay(this.title, this.iconPath, this.color);

  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
            scale: scaleAnimation,
            child: Center(
              child: Container(
                height: dw(context) / 1.3,
                width: dw(context) / 1.3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: widget.color,
                      blurRadius: 1,
                      spreadRadius: 1,
                    )
                  ],
                  color: white,
                  borderRadius: BorderRadius.circular(10.w),
                  border: Border.all(color: widget.color, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Material(
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          child: InkWell(
                              onTap: () {
                                navigateBack(context);
                              },
                              child: Icon(
                                FontAwesomeIcons.timesCircle,
                                color: widget.color,
                                size: 7.w,
                              )),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          widget.iconPath,
                          alignment: Alignment.center,
                          height: dw(context) / 3,
                          width: dw(context) / 3,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Center(
                                child: gTextW(
                              widget.title,
                              white,
                              TextAlign.center,
                              5,
                              3.5,
                              FontWeight.bold,
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
