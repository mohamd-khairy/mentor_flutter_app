class Request {
  String name;
  String title;
  String created_at;
  String image;
  String days;
  String type;

  Request(
      {this.created_at,
      this.image,
      this.title,
      this.name,
      this.days,
      this.type});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      name: json['user_recieve']['name'].toString(),
      title: json['title'].toString(),
      days: json['day_ids'].join(',').toString(),
      image: json['user_recieve']['profile']['photo'].toString(),
      created_at: json['created_at'].toString(),
      type: json['session_type'].toString(),
    );
  }
}
