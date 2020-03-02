import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  
  String baseUrl = "https://infinite-atoll-41509.herokuapp.com/api/v1/";

  var status;

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
        print(user['access_token']);
        _save(user['access_token']);
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
      final value= prefs.get(key) ?? 0;
      print(value);
    }

 }