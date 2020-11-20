import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentor/models/request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CSession {
  String baseUrl = "https://infinite-atoll-41509.herokuapp.com/api/v1/";

  Future<List<Request>> pending_sessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.get('id') ?? 0;
    var token = prefs.get('token') ?? 0;
    var msg;

    var response = await http.get(
        baseUrl + 'session?status=pending&user_recieve_id=' + id,
        headers: {"Authorization": "Bearer " + token});

    var status = response.statusCode;

    if (status == 200) {
      var responseJson = json.decode(response.body);

      msg = json.decode(response.body)['message'];

      return (responseJson['data'] as List)
          .map((p) => Request.fromJson(p))
          .toList();
    } else {
      msg = json.decode(response.body)['message'];
    }
  }
}
