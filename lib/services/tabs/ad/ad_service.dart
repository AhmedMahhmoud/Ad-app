import 'dart:convert';
import 'dart:io';
import 'package:ads_app/helpers/globalWidget.dart';
import 'package:ads_app/services/auth/auth_services.dart';
import 'package:ads_app/services/sharedServices.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../models/ad.dart';

class AdService {
  static Future search_with_filter_service(String name, String first_price,
      String lastprice, String slug, List filter_id) async {
    List data = [];
    String options = "";
    for (var item in filter_id) {
      options += "&filter_id[]=$item";
    }
    print(
        "$apiBaseUrl/searchByFilter?name=$name&first_price=$first_price&lastprice=$lastprice&slug=$slug$options");
    try {
      await Dio()
          .get(
        "$apiBaseUrl/searchByFilter?name=$name&first_price=$first_price&lastprice=$lastprice&slug=$slug$options",
        options: Options(
          headers: {"lang": fourTabsController.lang.value},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          data = response.data["data"];
          return data;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return data;
  }

  static Future search_with_word_service(String name) async {
    List data = [];
    try {
      await Dio()
          .get(
        "$apiBaseUrl/searchByFilter?name=$name",
        options: Options(
          headers: {"lang": fourTabsController.lang.value},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          data = response.data["data"];
          return data;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return data;
  }

  static Future get_govs_service() async {
    List data = [];
    try {
      await Dio()
          .get(
        "$apiBaseUrl/governments",
        options: Options(
          headers: {"lang": fourTabsController.lang.value},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          data = response.data["data"];
          return data;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return data;
  }

  static Future get_my_ads_service() async {
    Map myAds = {};
    try {
      await Dio()
          .get(
        "$apiBaseUrl/myAds",
        options: Options(
          headers: {
            "lang": fourTabsController.lang.value,
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${fourTabsController.userMap["token"]}"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return {};
        } else if (response.statusCode == 200) {
          myAds = response.data["data"];
          return myAds;
        } else {
          return {};
        }
      }).catchError((Object o) {
        return {};
      });
    } catch (e) {
      return {};
    }

    return myAds;
  }

  static Future<AdModel> get_one_ad_service(String id, String uuid) async {
    Map ad = {};
    final res = await Dio().get(
      "$apiBaseUrl/ads/$id/details?mac_address=$uuid",
      options: Options(
        headers: {
          "lang": fourTabsController.lang.value,
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${fourTabsController.userMap["token"]}"
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (res.statusCode != 200) {
      throw "يوجد مشكلة بالسيرفر,حاول لاحقا";
    }

    return AdModel.fromJson(res.data['data']);
  }

  static Future get_one_ad_comments_service(String id) async {
    List comments = [];
    try {
      await Dio()
          .get(
        "$apiBaseUrl/comment?ads_id=$id",
        options: Options(
          headers: {
            "lang": fourTabsController.lang.value,
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${fourTabsController.userMap["token"]}"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return comments;
        } else if (response.statusCode == 200) {
          comments = response.data["data"];
          return comments;
        } else {
          return comments;
        }
      }).catchError((Object o) {
        return comments;
      });
    } catch (e) {
      return comments;
    }

    return comments;
  }

  static Future send_one_ad_comment_service(String text, String id) async {
    try {
      await Dio().post("$apiBaseUrl/comment",
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer ${fourTabsController.userMap["token"]}"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
          data: {"comment": text, "ads_id": id});
    } catch (e) {}
  }

  static Future<bool> delete_one_ad_service(String id) async {
    bool done = false;
    try {
      await Dio()
          .post(
        "$apiBaseUrl/deleteAds/$id",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${fourTabsController.userMap["token"]}"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        done = response.data["status"];
        return done;
      });
    } catch (e) {}
    return done;
  }

  static Future get_main_category_service() async {
    List data = [];
    try {
      await Dio()
          .get(
        "$apiBaseUrl/subCategories",
        options: Options(
          headers: {"lang": fourTabsController.lang.value},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        print(response.statusCode);
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          data = response.data["subCategories"];
          return data;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return data;
  }

  static Future get_uuid_history_service(String uuid) async {
    List data = [];
    try {
      await Dio()
          .get(
        "$apiBaseUrl/ads/history?mac_address=$uuid",
        options: Options(
          headers: {"lang": fourTabsController.lang.value},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        print(response.statusCode);
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          data = response.data["data"];
          return data;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return data;
  }

  static Future get_inside_category_service(String id) async {
    List data = [];
    try {
      await Dio()
          .get(
        "$apiBaseUrl/subCategories",
        queryParameters: {
          "id": id,
        },
        options: Options(
          headers: {
            "lang": fourTabsController.lang.value,
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          data = response.data["subCategories"];
          return data;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return data;
  }

  static Future get_category_filters_service(String id) async {
    List data = [];
    try {
      await Dio()
          .get(
        "$apiBaseUrl/filterCats",
        queryParameters: {
          "id": id,
        },
        options: Options(
          headers: {
            "lang": fourTabsController.lang.value,
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      )
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر,حاول لاحقا");
          return [];
        } else if (response.statusCode == 200) {
          data = response.data["filter"];
          return data;
        } else {
          return [];
        }
      }).catchError((Object o) {
        return [];
      });
    } catch (e) {
      return [];
    }

    return data;
  }

  static Future<bool> add_ad_service(
    String category_id,
    String region_id,
    String price,
    String name,
    String discrption,
    String total_price,
    String wallet,
    File image,
    List<File> files,
    List options,
    bool paid,
    bool advvertise_ads,
    bool main_ads,
  ) async {
    bool done = false;

    var formData = FormData();
    for (var file in files) {
      formData.files.addAll([
        MapEntry("file[]", await MultipartFile.fromFile(file.path)),
      ]);
    }
    formData.files.addAll([
      MapEntry(
          "image",
          await MultipartFile.fromFile(
            image.path,
            filename: image.path,
            contentType: MediaType("image", "jpg"),
          )),
    ]);

    formData.fields.addAll([
      MapEntry("main_ads", "${main_ads}"),
      MapEntry("advvertise_ads", "${advvertise_ads}"),
      MapEntry("paid", "${paid}"),
      MapEntry("category_id", "${category_id}"),
      MapEntry("region_id", "${region_id}"),
      MapEntry("price", "${price}"),
      MapEntry("name", "${name}"),
      MapEntry("discrption", "${discrption}"),
      MapEntry("total_price", "${total_price}"),
      MapEntry("wallet", "${wallet}"),
      MapEntry("options", json.encode(options)),
    ]);

    try {
      await Dio()
          .post("$apiBaseUrl/addAds",
              options: Options(
                headers: {
                  "Authorization":
                      "Bearer ${fourTabsController.userMap["token"]}"
                },
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                },
              ),
              data: formData)
          .then((Response response) {
        if (response.statusCode == 500) {
          buildToast("يوجد مشكلة بالسيرفر حاول لاحقا");
          done = false;
          return done;
        } else if (response.statusCode == 200) {
          buildToast("تم إضافة إعلانك بنجاح");

          done = true;
          return done;
        }
        return done;
      }).catchError((Object o) {
        buildToast("يوجد مشكلة بالسيرفر حاول لاحقا");
        print(o);

        return done;
      });
    } catch (e) {
      print(e);
      buildToast("يوجد مشكلة بالسيرفر حاول لاحقا");
      return done;
    }

    return done;
  }

  static Future<bool> edit_ad_service(
      String price, String name, String discrption, String id) async {
    bool done = false;

    try {
      await Dio().post("$apiBaseUrl/EditAds/$id",
          options: Options(
            headers: {
              "Authorization": "Bearer ${fourTabsController.userMap["token"]}"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
          data: {
            "name": name,
            "discrption": discrption,
            "price": price
          }).then((value) => print(value.data));
    } catch (e) {
      buildToast("يوجد مشكلة بالسيرفر حاول لاحقا");
      return done;
    }

    return done;
  }
}
