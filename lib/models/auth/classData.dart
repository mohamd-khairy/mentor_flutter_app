class ClassData {
  final String name;
  final String duration;
  final String subject;
  final String topic;
  final String photo;
  final String price;

  ClassData({this.name,
  this.duration,
  this.subject,
  this.topic,
  this.price,
  this.photo});

  factory ClassData.fromJson(Map json) {
    return ClassData(
      photo: json['photo'] == null || json['photo'] == "null" ? null : json['photo'],
      name: json['user']['name'] ?? " ",
      duration: json['session_duration'] ?? "0",
      topic: json['topic']['topic'] ?? " ",
      subject: json['topic']['subject'] ?? " ",
      price: json['session_price'] ?? "0"
    );
  }
}