import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentor/models/auth/classData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Classes {
  
  String baseUrl = "https://infinite-atoll-41509.herokuapp.com/api/v1/";

  var status;
  var name;
  var msg = " ";

  Future<List> classes() async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token =  prefs.get('token') ?? 0;

      var response = await http.get(baseUrl + 'class',
            headers: {"Authorization": "Bearer "+token}
      );

      status = response.statusCode;

      if(status == 200){
        // print(json.decode(response.body))['data'];

        msg =  json.decode(response.body)['message'];

        return json.decode(response.body)['data'];

      }else{
        msg =  json.decode(response.body)['message'];
      }
  }

  Future<ClassData> oneclass(id) async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token =  prefs.get('token') ?? 0;

      var response = await http.get(baseUrl + 'class/${id}',
            headers: {"Authorization": "Bearer "+token}
      );

      status = response.statusCode;

      if(status == 200){
        print(json.decode(response.body)['data']);

        msg =  json.decode(response.body)['message'];

        return ClassData.fromJson(json.decode(response.body)['data']);

      }else{
        msg =  json.decode(response.body)['message'];
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