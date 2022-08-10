import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GlobalActionsController {
  static Future<String?> getUUID() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      log(androidDeviceInfo.androidId.toString());

      return androidDeviceInfo.androidId; // unique ID on Android
    }
    return null;
  }

  static Future<bool> getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      return true;
    }
    return false;
  }

  static Future<Uint8List> readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);
    Uint8List bytes = Uint8List.fromList([]);
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
    }).catchError((onError) {});
    return bytes;
  }

  static Future<Uint8List?> compressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 1920,
      minHeight: 1280,
      quality: 50,
      rotate: 90,
    );

    return result;
  }

  static editImageSaveToGalleryReturnFileOrNull(
      BuildContext context, String filePath) async {
    var file = await GlobalActionsController.readFileByte(filePath);
    var path = await getExternalStorageDirectory();
    var editedImage = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImageEditor(
                savePath: path,
                image: file,
              )),
    );
    if (editedImage != null) {
      final directory = await getApplicationDocumentsDirectory();
      final File pathOfImage =
          await File('${directory.path}/${DateTime.now().toString()}.png')
              .create();
      await pathOfImage
          .writeAsBytes(editedImage)
          .then((value) => GallerySaver.saveImage(pathOfImage.path));

      return pathOfImage;
    }
    return null;
  }
}
