import 'package:flutter/material.dart';
import 'package:mentor/controllers/auth/auth.dart';
import 'package:mentor/views/auth/login.dart';
import 'package:mentor/views/home.dart';

class RegisterPage extends StatefulWidget{

  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>{

  final TextEditingController _firstNameController = new TextEditingController();
  final TextEditingController _secondNameController = new TextEditingController();
  final TextEditingController _mobileController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  var auth = new Auth();
  
   _register(){
    setState(() {
      if(_firstNameController.text.trim().toLowerCase().isNotEmpty &&
      _secondNameController.text.trim().toLowerCase().isNotEmpty &&
      _mobileController.text.trim().isNotEmpty &&
      _emailController.text.trim().toLowerCase().isNotEmpty &&
       _passwordController.text.trim().isNotEmpty){

        auth.register(
          _firstNameController.text.trim().toLowerCase(),
          _secondNameController.text.trim().toLowerCase(),
          _mobileController.text.trim(),
          _emailController.text.trim().toLowerCase(),
          _passwordController.text.trim()

         ).whenComplete((){

          if(auth.status == 200){


            _showDialog( "Success" ,auth.msg);

            
          }else{
            _showDialog( "Failed" , auth.msg);
          }
        });
      }else{
        _showDialog( "Failed" ,auth.msg);
      }
    });
  }

  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Color(getColorHexFromStr('#FDD148')),
        body:ListView(
        children:<Widget>[
          Container(
            height: 130.0,
            child: Center(
              child: Text("Register",
                style:TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:25.0 , right: 25.0),
            child: Container(
              // height: MediaQuery.of(context).size.height - 210.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:30.0,right: 60.0,left:40.0),
                    child: TextField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 2.0)),
                        hintText: "First Name",
                        icon: Icon(Icons.person , color: Colors.yellow),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0,right: 60.0,left:40.0),
                    child: TextField(
                      controller: _secondNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 2.0)),
                        hintText: "Last Name",
                        icon: Icon(Icons.person , color: Colors.yellow),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0,right: 60.0,left:40.0),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 2.0)),
                        hintText: "email address",
                        icon: Icon(Icons.email , color: Colors.yellow),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0,right: 60.0,left:40.0),
                    child: TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 2.0)),
                        hintText: "Mobile Number",
                        icon: Icon(Icons.mobile_screen_share , color: Colors.yellow),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0,right: 60.0,left:40.0),
                    child: TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 2.0)),
                        hintText: "password",
                        icon: Icon(Icons.vpn_key , color: Colors.yellow),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:40.0,right: 30.0,left:30.0),
                    child: Container(
                      height: 50.0,
                      width: 250.0,
                      child: RaisedButton(
                        onPressed: (){
                          _register();
                        },
                        color: Color(getColorHexFromStr('#FDD148')),
                        child:  Text('Sign Up' ,
                          style:  TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0
                          )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:50.0 , bottom: 20.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width - 330,),
                        Text("Already a member ? "),
                         GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) => LoginPage())
                            );
                          },
                          child: Text("Login now",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] 
      )
    );
   }

  void _showDialog(status , msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(status),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => LoginPage())
                );
              },
            ),
          ],
        );
      },
    );
  }


}