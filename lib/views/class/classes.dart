
import 'package:flutter/material.dart';
import 'package:mentor/views/auth/login.dart';
import 'package:mentor/views/home.dart';
import 'package:mentor/views/tutor/tutors.dart';

class ClassesPage extends StatefulWidget{
  
  ClassesPageState createState() => ClassesPageState();

}

class ClassesPageState extends State<ClassesPage>
  with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();

  TabController controller;

  @override
  void initState() {
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
        title: Center(child: Text("Most Popular Classes")),
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
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              itemCard('FinnNavian', 'assets/mountain.jpg', false),
              itemCard('FinnNavian', 'assets/kathmandu.jpg', true),
              itemCard('FinnNavian', 'assets/fishing.jpg', true)
            ],
          )
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.yellow,
          tabs:<Widget>[
            InkWell(
              onTap: (){
                print(this.runtimeType);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => MyHomePage())
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

  Widget itemCard(String title, String imgPath, bool isFavorite) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,//double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              width: 140.0,
              height: 150.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgPath), fit: BoxFit.cover)),
            ),
            SizedBox(width: 15.0),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width-335),
                    Material(
                      elevation: isFavorite ? 0.0 : 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 45.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: isFavorite
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.white),
                        child: Center(
                          child: isFavorite
                              ? Icon(Icons.favorite_border)
                              : Icon(Icons.favorite, color: Colors.red),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  width: MediaQuery.of(context).size.width-200,
                  child: Text(
                    'Scandinavian small sized double sofa imported full leather / Dale Italia oil wax leather black',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.grey,
                        fontSize: 13.0),
                  ),
                ),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    SizedBox(width: 35.0),
                    Container(
                      height: 45.0,
                      width: 50.0,
                      color: Color(getColorHexFromStr('#F9C335')),
                      child: Center(
                        child: Text(
                          '\$248',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      height: 45.0,
                      width: 100.0,
                      color: Color(getColorHexFromStr('#FEDD59')),
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}



            