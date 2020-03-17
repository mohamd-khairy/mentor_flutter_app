class UserMentor {
  final int rate;
  final String name;
  final String photo;
  final String city;
  final String country;
  final String topic;
  final String subject;

  UserMentor({this.name,
  this.rate,
  this.city,
  this.country,
  this.topic,
  this.subject,
  this.photo});

  factory UserMentor.fromJson(Map json) {
    return UserMentor(
      photo: json['profile']['photo'] ?? " ",
      city: json['profile']['city'] ?? " ",
      country: json['profile']['country'] ?? " ",
      topic: json['topics']['topic'] ?? " ",
      subject: json['topics']['subject'] ?? " ",
      rate: json['rate'] ?? "0",
      name: json['name'] ?? " "
    );
  }
}