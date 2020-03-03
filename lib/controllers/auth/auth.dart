import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentor/models/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  
  String baseUrl = "https://infinite-atoll-41509.herokuapp.com/api/v1/";

  var status;
  var name;
  var msg;

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
        _save('token',user['access_token']);
        msg = json.decode(response.body)['message'];

      }else{
        msg = json.decode(response.body)['message'];
      }
  }

  register(fname , sname ,mobile ,email , password) async{

      Map data = {
        'first_name': "$fname",
        'last_name': "$sname",
        'mobile': "$mobile",
        'email': "$email",
        'password': "$password"
      };

      var body = json.encode(data);

      var response = await http.post(baseUrl + 'auth/register',
            headers: {"Content-Type": "application/json","Accept": "application/json"},
            body: body
      );

      status = response.statusCode;

      if(status == 200){
        var data = json.decode(response.body);
        print(data);
        msg = json.decode(response.body)['message'];

        // _save('token',user['access_token']);

      }else{
        msg = json.decode(response.body)['message'];
      }
  }

  Future<User> me() async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token =  prefs.get('token') ?? 0;

      var response = await http.post(baseUrl + 'auth/me',
            headers: {"Authorization": "Bearer "+token}
      );

      status = response.statusCode;

       print(json.decode(response.body));
      if(status == 200){
        final userData =  json.decode(response.body);
        name = userData['data']['name'] ?? " ";
        _save('name', name);
        return  User.fromJson(userData);
      }
  }

    _save(String key ,String value) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }

    read(key) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      name =  prefs.get(key).toString();
    }

 }