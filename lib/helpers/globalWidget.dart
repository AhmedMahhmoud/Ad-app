import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'constants.dart';

buildNetworkImage(
    BuildContext context,
    String url,
    double topRightBorder,
    double topLeftBorder,
    double bottomRightBorder,
    double bottomLeftBorder,
    double height,
    double width,
    BoxFit boxFit) {
  return url.length == 0 ||
          url.toLowerCase().contains('hiec') ||
          url.toLowerCase().contains('hief') ||
          (!url.toLowerCase().contains('png') &&
              !url.toLowerCase().contains('jpg'))
      ? (Icon(
          Icons.image,
          size: 10.w,
          color: maincolor1,
        ))
      : ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightBorder),
            bottomRight: Radius.circular(bottomRightBorder),
            topLeft: Radius.circular(topLeftBorder),
            bottomLeft: Radius.circular(bottomLeftBorder),
          ),
          child: height == 0
              ? CachedNetworkImage(
                  imageUrl: url,
                  fit: boxFit,
                  // height: height,
                  // width: width,
                  repeat: ImageRepeat.noRepeat,
                  useOldImageOnUrlChange: false,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: (CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: maincolor1,
                    )),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: maincolor1,
                    size: 10.w,
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: url,
                  fit: boxFit,
                  height: height,
                  width: width,
                  repeat: ImageRepeat.noRepeat,
                  useOldImageOnUrlChange: false,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: (CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: maincolor1,
                    )),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: maincolor1,
                    size: 10.w,
                  ),
                ),
        );
}

buildNetworkImageWithoutCache(
    BuildContext context,
    String url,
    double topRightBorder,
    double topLeftBorder,
    double bottomRightBorder,
    double bottomLeftBorder,
    double height,
    double width,
    BoxFit boxFit) {
  return url.length == 0 ||
          url.toLowerCase().contains('hiec') ||
          url.toLowerCase().contains('hief') ||
          (!url.toLowerCase().contains('png') &&
              !url.toLowerCase().contains('jpg'))
      ? (Icon(
          Icons.image,
          size: 10.w,
          color: maincolor1,
        ))
      : ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightBorder),
            bottomRight: Radius.circular(bottomRightBorder),
            topLeft: Radius.circular(topLeftBorder),
            bottomLeft: Radius.circular(bottomLeftBorder),
          ),
          child: Image.network(
            url,
            width: double.infinity,
            height: height,
            fit: boxFit,
            cacheWidth: 200,
            cacheHeight: 200,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.error,
                color: maincolor1,
                size: 10.w,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                  child: (CircularProgressIndicator(
                color: maincolor1,
              )));
            },
          ));
}

buildToast(String title) {
  return Fluttertoast.showToast(
    msg: title,
    backgroundColor: black,
    fontSize: 18,
    gravity: ToastGravity.BOTTOM,
    textColor: white,
    toastLength: Toast.LENGTH_SHORT,
  );
}

buildSuccessDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
  return AwesomeDialog(
      dialogBackgroundColor: white,
      btnOkColor: Colors.transparent,
      btnCancelColor: Colors.transparent,
      btnCancel: SizedBox(),
      btnOk: SizedBox(),
      context: context,
      showCloseIcon: false,
      useRootNavigator: true,
      isDense: true,
      dismissOnTouchOutside: true,
      autoHide: Duration(seconds: 3),
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      body: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5)),
            color: black,
          ),
          child: Center(
            child: gTextW(
              "تم بنجاح",
              white,
              TextAlign.start,
              1,
              16,
              FontWeight.bold,
            ),
          )))
    ..show();
}
