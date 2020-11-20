import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentor/models/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  String baseUrl = "https://infinite-atoll-41509.herokuapp.com/api/v1/";

  var status;
  var name;
  var id;
  var msg = " ";

  login(email, password) async {
    Map data = {'email': "$email", 'password': "$password"};

    var body = json.encode(data);

    var response = await http.post(baseUrl + 'auth/login',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: body);

    status = response.statusCode;

    if (status == 200) {
      var user = json.decode(response.body);
      print(user);
      _save('token', user['access_token']);
      msg = json.decode(response.body)['message'];
    } else {
      msg = json.decode(response.body)['message'];
    }
  }

  register(fname, sname, mobile, email, password) async {
    Map data = {
      'first_name': "$fname",
      'last_name': "$sname",
      'mobile': "$mobile",
      'email': "$email",
      'password': "$password"
    };

    var body = json.encode(data);

    var response = await http.post(baseUrl + 'auth/register',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: body);

    status = response.statusCode;

    if (status == 200) {
      var data = json.decode(response.body);
      print(data);
      msg = json.decode(response.body)['message'];
    } else if (status == 422) {
      json.decode(response.body)['errors'].forEach((k, v) {
        //the following print all the currency in
        print('$k,$v');
        msg = v.toString();
      });
    } else {
      msg = json.decode(response.body)['message'];
    }
  }

  Future<User> me() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token') ?? 0;

    var response = await http.post(baseUrl + 'auth/me',
        headers: {"Authorization": "Bearer " + token});

    status = response.statusCode;

    print(json.decode(response.body));
    if (status == 200) {
      final userData = json.decode(response.body);
      name = userData['data']['name'] ?? " ";
      id = userData['data']['id'] ?? " ";
      msg = json.decode(response.body)['message'];
      _save('name', name);
      _save('id', id.toString() ?? '');
      return User.fromJson(userData);
    } else {
      msg = json.decode(response.body)['message'];
    }
  }

  forgot(email) async {
    Map data = {
      'email': "$email",
    };

    var body = json.encode(data);

    var response = await http.post(baseUrl + 'auth/forget/password',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: body);

    status = response.statusCode;

    if (status == 200) {
      var res = json.decode(response.body);
      print(res);
      msg = json.decode(response.body)['message'];
    } else {
      msg = json.decode(response.body)['message'];
    }
  }

  reset(code, password) async {
    Map data = {'code': "$code", 'newPassword': "$password"};

    var body = json.encode(data);

    var response = await http.post(baseUrl + 'auth/reset/password',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: body);

    status = response.statusCode;

    if (status == 200) {
      var user = json.decode(response.body);
      print(user);
      msg = json.decode(response.body)['message'];
    } else {
      msg = json.decode(response.body)['message'];
    }
  }

  _save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  read(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.get(key).toString();
  }
}
