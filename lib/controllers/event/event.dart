import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mentor/models/event_model.dart';

class CEvent {
  Future<List<Event>> event_data() async {
    String baseUrl = "https://infinite-atoll-41509.herokuapp.com/api/v1/";

    var response = await http.get(baseUrl + 'online_event');

    var status = response.statusCode;

    var msg;

    if (status == 200) {
      var responseJson = json.decode(response.body);

      msg = json.decode(response.body)['message'];

      return (responseJson['data'] as List)
          .map((p) => Event.fromJson(p))
          .toList();
    } else {
      msg = json.decode(response.body)['message'];
    }
  }
}
