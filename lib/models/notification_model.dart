class NotificationModel {
  final String title;
  final String message;

  const NotificationModel({
    required this.title,
    required this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      message: json['message'],
    );
  }
}
