
import 'package:flutter/material.dart';
import 'package:mentor/views/auth/login.dart';

class MyHomePage extends StatefulWidget{
  
  MyHomePageState createState() => MyHomePageState();

}

class MyHomePageState extends State<MyHomePage>
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

  final selectedTab = {"num": 0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("MyMentor")),
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
                      
                      SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Hello , Pino',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'What do you want to buy?',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
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
                      child: Container(height: 45.0, color: Colors.white)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          selectedTab["num"] = 0;
                          (context as Element).markNeedsBuild();
                        },
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color:  (this.selectedTab['num'] == 0)? Color(getColorHexFromStr('#F9C335')): Colors.white,
                          child: Padding(
                          padding: const EdgeInsets.only(top:10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Pending',
                                  style: TextStyle(fontFamily: 'Quicksand' , fontSize: 20.0,fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          selectedTab["num"] = 1;
                          (context as Element).markNeedsBuild();
                        },
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color:  (this.selectedTab['num'] == 1)? Color(getColorHexFromStr('#F9C335')): Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Upcoming',
                                  style: TextStyle(fontFamily: 'Quicksand' , fontSize: 20.0,fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          selectedTab["num"] = 2;
                          (context as Element).markNeedsBuild();
                        },
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color:  (this.selectedTab['num'] == 2)? Color(getColorHexFromStr('#F9C335')): Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Classes',
                                  style: TextStyle(fontFamily: 'Quicksand' , fontSize: 20.0,fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          selectedTab["num"] = 3;
                          (context as Element).markNeedsBuild();
                        },
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color:  (this.selectedTab['num'] == 3)? Color(getColorHexFromStr('#F9C335')): Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Sessions',
                                  style: TextStyle(fontFamily: 'Quicksand' , fontSize: 20.0,fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              itemCard('FinnNavian', 'assets/images/1.png', false),
              itemCard('FinnNavian', 'assets/images/1.png', true),
              itemCard('FinnNavian', 'assets/images/1.png', true)
            ],
          )
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.yellow,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.event_seat, color: Colors.yellow)),
            Tab(icon: Icon(Icons.timer, color: Colors.grey)),
            Tab(icon: Icon(Icons.shopping_cart, color: Colors.grey)),
            Tab(icon: Icon(Icons.person_outline, color: Colors.grey))
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
        width: double.infinity,
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
            SizedBox(width: 4.0),
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
                    SizedBox(width: 45.0),
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
                SizedBox(height: 5.0),
                Container(
                  width: 175.0,
                  child: Text(
                    'Scandinavian small sized double sofa imported full leather / Dale Italia oil wax leather black',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.grey,
                        fontSize: 12.0),
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


            