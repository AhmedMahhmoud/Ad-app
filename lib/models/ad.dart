class AdModel {
  AdModel({
    required this.id,
    required this.name,
    required this.content,
    required this.image,
    required this.price,
    required this.data,
    required this.statusNumber,
    required this.isFavourite,
    required this.government,
    required this.region,
    required this.status,
    required this.sellerId,
    required this.seller,
    required this.imageSeller,
    required this.sellerPhone,
    this.details,
    required this.files,
  });

  final int id;
  final String name;
  final String content;
  final String image;
  final int price;
  final String data;
  final int statusNumber;
  final bool isFavourite;
  final String government;
  final String region;
  final String status;
  final int sellerId;
  final String seller;
  final String imageSeller;
  final String sellerPhone;
  final String? details;
  final List<Files> files;

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      name: json['name'],
      content: json['content'],
      image: json['image'],
      price: json['price'],
      data: json['data'],
      statusNumber: json['status_number'],
      isFavourite: json['is_favourite'],
      government: json['government'],
      region: json['region'],
      status: json['status'],
      sellerId: json['seller_id'],
      seller: json['seller'],
      imageSeller: json['imageSeller'],
      sellerPhone: json['seller_phone'],
      details: json['details'],
      files: (json['files'] as List).isEmpty
          ? []
          : List.from(json['files']).map((e) => Files.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['content'] = content;
    _data['image'] = image;
    _data['price'] = price;
    _data['data'] = data;
    _data['status_number'] = statusNumber;
    _data['is_favourite'] = isFavourite;
    _data['government'] = government;
    _data['region'] = region;
    _data['status'] = status;
    _data['seller_id'] = sellerId;
    _data['seller'] = seller;
    _data['imageSeller'] = imageSeller;
    _data['seller_phone'] = sellerPhone;
    _data['details'] = details;
    _data['files'] = files.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Files {
  Files({
    required this.id,
    required this.path,
  });

  final int id;
  final String path;

  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
      id: json['id'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['path'] = path;
    return _data;
  }
}
