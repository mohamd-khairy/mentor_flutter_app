class RequestUpcoming {
  String name;
  String title;
  String created_at;
  String image;
  String days;
  String type;
  String start_at;
  String join_url;

  RequestUpcoming(
      {this.created_at,
      this.image,
      this.title,
      this.name,
      this.days,
      this.join_url,
      this.start_at,
      this.type});

  factory RequestUpcoming.fromJson(Map<String, dynamic> json) {
    return RequestUpcoming(
      name: json['session']['user_give']['name'].toString() ?? "",
      title: json['session']['title'].toString() ?? "",
      days: json['session']['day_ids'].join(',').toString() ?? "",
      image: json['session']['user_give']['profile']['photo'].toString() ?? "",
      created_at: json['session']['created_at'].toString() ?? "",
      type: json['session']['session_type'].toString() ?? "",
      join_url: json['session']['join_url'].toString() ?? "",
      start_at: json['session']['start_at'].toString() ?? "",
    );
  }
}
