import 'package:flutter/material.dart';
import 'package:mentor/constant/color.dart';
import 'package:mentor/constant/text_style.dart';
import 'package:mentor/controllers/auth/auth.dart';
import 'package:mentor/utils/datetime_utils.dart';
import 'package:mentor/views/auth/login.dart';
import 'package:mentor/views/class/classes.dart';
import 'package:mentor/views/event/events.dart';
import 'package:mentor/views/tutor/tutors.dart';
import 'package:mentor/widgets/ui_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  final name;

  MyHomePage({this.name});
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  TabController controller;

  var auth = new Auth();

  _save(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  @override
  void initState() {
    auth.read('name');
    controller = new TabController(length: 4, vsync: this);
    super.initState();
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

  final selectedTab = {"num": 0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("MyMentor")),
        backgroundColor: Color(getColorHexFromStr('#FDD148')),
        actions: <Widget>[_simplePopup()],
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
                  SizedBox(
                    height: 10.0,
                  ),
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
        backgroundColor: Color(getColorHexFromStr('#FDD148')),
        onPressed: () {
          _search();
          // Navigator.pushReplacementNamed(context, "/logout");
        },
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: double.infinity,
                    color: Color(getColorHexFromStr('#FDD148')),
                  ),
                  Positioned(
                    bottom: 50.0,
                    right: 100.0,
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Color(getColorHexFromStr('#FEE16D'))
                              .withOpacity(0.4)),
                    ),
                  ),
                  Positioned(
                    bottom: 100.0,
                    left: 150.0,
                    child: Container(
                        height: 300.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.0),
                            color: Color(getColorHexFromStr('#FEE16D'))
                                .withOpacity(0.5))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 25.0),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Hello , ' + widget.name,
                          style: TextStyle(
                              fontFamily: 'Opensans',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'What do you want to buy?',
                          style: TextStyle(
                              fontFamily: 'Opensans',
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // SizedBox(height: 25.0),
                    ],
                  )
                ],
              ),
              Stack(
                children: <Widget>[
                  Material(
                      elevation: 1.0,
                      child: Container(height: 45.0, color: Colors.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          selectedTab["num"] = 0;
                          (context as Element).markNeedsBuild();
                        },
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color: (this.selectedTab['num'] == 0)
                              ? Color(getColorHexFromStr('#F9C335'))
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Pending',
                                  style: TextStyle(
                                      fontFamily: 'Opensans',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selectedTab["num"] = 1;
                          (context as Element).markNeedsBuild();
                        },
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color: (this.selectedTab['num'] == 1)
                              ? Color(getColorHexFromStr('#F9C335'))
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Upcoming',
                                  style: TextStyle(
                                      fontFamily: 'Opensans',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selectedTab["num"] = 2;
                          (context as Element).markNeedsBuild();
                        },
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color: (this.selectedTab['num'] == 2)
                              ? Color(getColorHexFromStr('#F9C335'))
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Classes',
                                  style: TextStyle(
                                      fontFamily: 'Opensans',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selectedTab["num"] = 3;
                          (context as Element).markNeedsBuild();
                        },
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color: (this.selectedTab['num'] == 3)
                              ? Color(getColorHexFromStr('#F9C335'))
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Sessions',
                                  style: TextStyle(
                                      fontFamily: 'Opensans',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  selectedTab['num'] == 0
                      ? Stack(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                UIHelper.horizontalSpace(20),
                                Text("Pending Requests", style: headerStyle),
                                Spacer(),
                                Icon(Icons.more_horiz),
                                UIHelper.horizontalSpace(26),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 50.0, left: 28.0),
                            child: Column(
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                              color: imgBG,
                                              width: 80,
                                              height: 100,
                                              child: Image.asset(
                                                  'assets/images/1.png')),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              UIHelper.verticalSpace(8),
                                              Text("Mohamed Khairy",
                                                  style: titleStyle),
                                              UIHelper.verticalSpace(8),
                                              Text("PHP Interview questions",
                                                  style: subtitleStyle),
                                              UIHelper.verticalSpace(8),
                                              Row(
                                                children: <Widget>[
                                                  Text("2020-01-01",
                                                      style: monthStyle),
                                                  UIHelper.horizontalSpace(10),
                                                  Text("10:00 - 12:00 PM",
                                                      style: subtitleStyle),
                                                ],
                                              ),
                                              UIHelper.verticalSpace(8),
                                              Row(
                                                children: <Widget>[
                                                  Icon(Icons.location_on,
                                                      size: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  UIHelper.horizontalSpace(8),
                                                  Text("Egypt / Cairo",
                                                      style: subtitleStyle),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                              color: imgBG,
                                              width: 80,
                                              height: 100,
                                              child: Image.asset(
                                                  'assets/images/1.png')),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              UIHelper.verticalSpace(8),
                                              Text("Mohamed Khairy",
                                                  style: titleStyle),
                                              UIHelper.verticalSpace(8),
                                              Text("PHP Interview questions",
                                                  style: subtitleStyle),
                                              UIHelper.verticalSpace(8),
                                              Row(
                                                children: <Widget>[
                                                  Text("2020-01-01",
                                                      style: monthStyle),
                                                  UIHelper.horizontalSpace(10),
                                                  Text("10:00 - 12:00 PM",
                                                      style: subtitleStyle),
                                                ],
                                              ),
                                              UIHelper.verticalSpace(8),
                                              Row(
                                                children: <Widget>[
                                                  Icon(Icons.location_on,
                                                      size: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  UIHelper.horizontalSpace(8),
                                                  Text("Egypt / Cairo",
                                                      style: subtitleStyle),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                              color: imgBG,
                                              width: 80,
                                              height: 100,
                                              child: Image.asset(
                                                  'assets/images/1.png')),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              UIHelper.verticalSpace(8),
                                              Text("Mohamed Khairy",
                                                  style: titleStyle),
                                              UIHelper.verticalSpace(8),
                                              Text("PHP Interview questions",
                                                  style: subtitleStyle),
                                              UIHelper.verticalSpace(8),
                                              Row(
                                                children: <Widget>[
                                                  Text("2020-01-01",
                                                      style: monthStyle),
                                                  UIHelper.horizontalSpace(10),
                                                  Text("10:00 - 12:00 PM",
                                                      style: subtitleStyle),
                                                ],
                                              ),
                                              UIHelper.verticalSpace(8),
                                              Row(
                                                children: <Widget>[
                                                  Icon(Icons.location_on,
                                                      size: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  UIHelper.horizontalSpace(8),
                                                  Text("Egypt / Cairo",
                                                      style: subtitleStyle),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                              color: imgBG,
                                              width: 80,
                                              height: 100,
                                              child: Image.asset(
                                                  'assets/images/1.png')),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              UIHelper.verticalSpace(8),
                                              Text("Mohamed Khairy",
                                                  style: titleStyle),
                                              UIHelper.verticalSpace(8),
                                              Text("PHP Interview questions",
                                                  style: subtitleStyle),
                                              UIHelper.verticalSpace(8),
                                              Row(
                                                children: <Widget>[
                                                  Text("2020-01-01",
                                                      style: monthStyle),
                                                  UIHelper.horizontalSpace(10),
                                                  Text("10:00 - 12:00 PM",
                                                      style: subtitleStyle),
                                                ],
                                              ),
                                              UIHelper.verticalSpace(8),
                                              Row(
                                                children: <Widget>[
                                                  Icon(Icons.location_on,
                                                      size: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  UIHelper.horizontalSpace(8),
                                                  Text("Egypt / Cairo",
                                                      style: subtitleStyle),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])
                      : selectedTab['num'] == 1
                          ? Text("Upcoming")
                          : selectedTab['num'] == 2
                              ? Text("Classes")
                              : selectedTab['num'] == 3
                                  ? Text("Sessions")
                                  : Text("some thing wrong")
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.yellow,
          tabs: <Widget>[
            InkWell(
                onTap: () {
                  // print(this.runtimeType);
                  auth.read('name');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MyHomePage(name: auth.name)));
                },
                child: Tab(
                    icon: Icon(Icons.home,
                        color:
                            (this.runtimeType.toString() == "MyHomePageState")
                                ? Colors.yellow
                                : Colors.grey))),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => TutorsPage()));
                },
                child: Tab(
                    icon: Icon(Icons.person_outline,
                        color:
                            (this.runtimeType.toString() == "TutorsPageState")
                                ? Colors.yellow
                                : Colors.grey))),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ClassesPage()));
                },
                child: Tab(
                    icon: Icon(Icons.class_,
                        color:
                            (this.runtimeType.toString() == "ClassesPageState")
                                ? Colors.yellow
                                : Colors.grey))),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EventPage()));
                },
                child: Tab(
                    icon: Icon(Icons.event_seat,
                        color: (this.runtimeType.toString() == "EventPageState")
                            ? Colors.yellow
                            : Colors.grey)))
          ],
        ),
      ),
    );
  }

  Widget _simplePopup() => PopupMenuButton(
        onSelected: (value) {
          if (value == 'Logout') {
            _save('0');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()));
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(child: const Text('Logout'), value: 'Logout'),
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
                            icon: Icon(Icons.person)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Category",
                            hintText: "Please Enter category",
                            icon: Icon(Icons.category)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Topic",
                            hintText: "Please Enter topic",
                            icon: Icon(Icons.title)),
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
              ));
        });
  }
}
