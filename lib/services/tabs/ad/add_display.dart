import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class DisplayAd {
  static Future<void> displayAd(phone) async {
    if (Platform.isAndroid) {
      var whatsappUrl =
          "whatsapp://send?phone=${phone}&text=من فضلك أود التواصل بخصوص هذا الإعلان";
      await canLaunch(whatsappUrl)
          ? launch(whatsappUrl)
          : print(
              "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
    } else {
      final url =
          "https://api.whatsapp.com/send?phone=$phone&text=من فضلك أود التواصل بخصوص هذا الإعلان";

      final uri = Uri.encodeFull(url);

      if (await canLaunchUrl(Uri.parse(uri))) {
        await launchUrl(Uri.parse(uri));
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
