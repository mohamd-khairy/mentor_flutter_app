import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentor/models/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  
  String baseUrl = "https://infinite-atoll-41509.herokuapp.com/api/v1/";

  var status;
  var name;

  login(email , password) async{

      Map data = {
        'email': "$email",
        'password': "$password"
      };

      var body = json.encode(data);

      var response = await http.post(baseUrl + 'auth/login',
            headers: {"Content-Type": "application/json","Accept": "application/json"},
            body: body
      );

      status = response.statusCode;

      if(status == 200){
        var user = json.decode(response.body);
        print(user);
        _save(user['access_token']);

      }
  }

  Future<User> me() async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token =  prefs.get('token') ?? 0;

      var response = await http.post(baseUrl + 'auth/me',
            headers: {"Authorization": "Bearer "+token}
      );

      status = response.statusCode;

      // print(json.decode(response.body));
      if(status == 200){
        final userData =  json.decode(response.body);
        name = userData['data']['name'];
        return  User.fromJson(userData);
      }
  }

    _save(String token) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = token;
      prefs.setString(key, value);
    }

    read() async{
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      return  prefs.get(key) ?? 0;
    }

 }