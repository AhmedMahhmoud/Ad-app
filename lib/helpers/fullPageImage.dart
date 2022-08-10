// import 'package:ads_app/helpers/globalWidget.dart';
// import 'package:flutter/material.dart';

// import 'constants.dart';
// import 'navigateMethods.dart';

// class FullPageImage extends StatelessWidget {
//   final String image;
//   final String tag;

//   const FullPageImage(this.image, this.tag);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: InkWell(
//       onTap: () {
//         navigateBack(context);
//       },
//       child: Hero(
//         tag: this.tag,
//         child: Container(
//           width: dw(context),
//           height: dh(context),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(color: black),
//           child: buildNetworkImage(context, image, 0, 0, 0, 0, dh(context),
//               dw(context), BoxFit.scaleDown),
//         ),
//       ),
//     ));
//   }
// }
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'navigateMethods.dart';

class FullPageImage extends StatefulWidget {
  final List images;

  const FullPageImage(this.images);

  @override
  State<FullPageImage> createState() => _FullPageImageState();
}

class _FullPageImageState extends State<FullPageImage> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Container(
          height: dh(context),
          width: dw(context),
          color: white,
          child: PageView(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              children: widget.images.map((e) {
                return InkWell(
                  onTap: () {
                    navigateBack(context);
                  },
                  child: Hero(
                    tag: e,
                    child: Container(
                      width: dw(context),
                      height: dh(context),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: black),
                      child: buildNetworkImage(context, e, 0, 0, 0, 0,
                          dh(context), dw(context), BoxFit.scaleDown),
                    ),
                  ),
                );
              }).toList()),
        ));
  }
}
