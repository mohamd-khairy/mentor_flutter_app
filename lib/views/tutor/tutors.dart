
import 'package:flutter/material.dart';
import 'package:mentor/controllers/auth/auth.dart';
import 'package:mentor/controllers/mentor/mentor.dart';
import 'package:mentor/views/auth/login.dart';
import 'package:mentor/views/class/classes.dart';
import 'package:mentor/views/home.dart';
import 'package:mentor/views/tutor/details.dart';

class TutorsPage extends StatefulWidget{
  
  TutorsPageState createState() => TutorsPageState();

}

class TutorsPageState extends State<TutorsPage>
  with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();

  TabController controller;

  final auth = new Auth();
  final mentor = new Mentor();

  @override
  void initState() {
    auth.read('name');
    mentor.mentors();
    super.initState();
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
      appBar: AppBar(
        title: Center(child: Text("Most Popular Tutors")),
        backgroundColor:  Color(getColorHexFromStr('#FDD148')),
        actions:<Widget>[
          _simplePopup()
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 50.0),
                  Image.asset('assets/images/1.png'),
                  SizedBox(height: 10.0,),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.yellow,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.search),
        backgroundColor:  Color(getColorHexFromStr('#FDD148')),
        onPressed: () {
          _search();
          // Navigator.pushReplacementNamed(context, "/logout");
        },
      ),
      body: Column(children: <Widget>[
        Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Most Popular',
                  style: TextStyle(
                    fontFamily: 'Opensans',
                    fontSize: 20.0,
                  )),
              Icon(Icons.more_horiz, color: Colors.black)
            ],
          ),
        ),
      ),
        Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Container(
          height: MediaQuery.of(context).size.height-200,

          child: FutureBuilder<List>(
            builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context , int index){ 
                            if(snapshot.data[index]['profile'] != null && snapshot.data[index]['topics'] != null){
                              return _buildCard(snapshot.data[index]['id'],snapshot.data[index]['name'] ?? " ",snapshot.data[index]['topics']['category']['name'] ?? " ", "${snapshot.data[index]['rate']}", "${snapshot.data[index]['profile']['photo']}");
                            }
                          });
                  }else if(snapshot.hasError) {
                    return Center( child: Text(snapshot.error));
                  }
                  return Center( child: CircularProgressIndicator(),);

                  
            },
            future: mentor.mentors(),
          ),
        ),
      )
      ],),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.yellow,
          tabs:<Widget>[
            InkWell(
              onTap: (){
                print(this.runtimeType);
                Navigator.of(context).push (
                  MaterialPageRoute(builder: (BuildContext context) => MyHomePage(name: auth.name))
                );
              },
              child: Tab(icon: Icon(Icons.home, color: (this.runtimeType.toString() == "MyHomePageState")? Colors.yellow:Colors.grey))),
            InkWell(
              onTap: (){ 
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => TutorsPage())
                );
              },
              child: Tab(icon: Icon(Icons.person_outline, color:(this.runtimeType.toString() == "TutorsPageState")? Colors.yellow:Colors.grey))),
            InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => ClassesPage())
                );
              },
              child: Tab(icon: Icon(Icons.class_, color: (this.runtimeType.toString() == "ClassesPageState")? Colors.yellow:Colors.grey))),
            Tab(icon: Icon(Icons.event_seat, color: (this.runtimeType.toString() == "ClassesPage")? Colors.yellow:Colors.grey))
          ],
        ),
      ),
    );
  }

  Widget _simplePopup() => PopupMenuButton(
    onSelected: (value) {
      if(value == 'Logout'){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage())
        );
      }
    },
    itemBuilder: (BuildContext context) =>
    <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          child: const Text('Logout'), value: 'Logout'
        ),
    ],
  );

  void _search() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Find tutor")),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Tutor Name",
                      hintText: "Please Enter name",
                      icon: Icon(Icons.person)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Category",
                      hintText: "Please Enter category",
                      icon: Icon(Icons.category)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Topic",
                      hintText: "Please Enter topic",
                      icon: Icon(Icons.title)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {},
                      ),
                      RaisedButton(
                        child: Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        );
      }
    );
  }

  _buildCard(id,String title,String category, String rating, String imgPath) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DetailPage(id:id)));
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: 275.0,
                width: MediaQuery.of(context).size.width,
                child: Image.network(imgPath, fit: BoxFit.cover),
              ),
              //make the shade a bit deeper.
              Container(
                height: 275.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.black.withOpacity(0.4)),
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black.withOpacity(0.2)),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.white, size: 12.0),
                          SizedBox(width: 5.0),
                          Text(
                            rating,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width-200),
                    Text(
                      'More',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Opensans'),
                    ),
                    SizedBox(width: 7.0),
                    //this should be an iconbutton in a real app.
                    Icon(Icons.arrow_drop_down, color: Colors.white, size: 25.0)
                  ],
                ),
              ),
              Positioned(
                top: 190.0,
                left: 10.0,
                child: Container(
                  width: 200.0,
                  child: Text(title,
                      style: TextStyle(
                          fontFamily: 'Opensans',
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Positioned(
                  top: 225.0,
                  left: 10.0,
                  child: Row(children: [
                    Text(category ?? "no category yet",
                        style: TextStyle(
                            fontFamily: 'Opensans',
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: MediaQuery.of(context).size.width-220),
                    Stack(
                      children: <Widget>[
                        Container(height: 40.0, width: 100.0),
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                  image: AssetImage('assets/profilepic.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          left: 30.0,
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white),
                            child: Center(
                              child: Text('+17..',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black)),
                            ),
                          ),
                        )
                      ],
                    )
                  ]))
            ],
          ),
        ));
  }
}



            