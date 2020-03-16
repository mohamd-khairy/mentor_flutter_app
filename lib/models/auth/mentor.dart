class UserMentor {
  final int rate;
  final String name;
  final String photo;
  final String city;
  final String country;

  UserMentor({this.name,
  this.rate,
  this.city,
  this.country,
  this.photo});

  factory UserMentor.fromJson(Map json) {
    return UserMentor(
      photo: json['profile']['photo'],
      city: json['profile']['city'],
      country: json['profile']['country'],
      rate: json['rate'],
      name: json['name']
    );
  }
}