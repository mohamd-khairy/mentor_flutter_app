import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor/constant/text_style.dart';
import 'package:mentor/controllers/auth/auth.dart';
import 'package:mentor/controllers/event/event.dart';
import 'package:mentor/controllers/mentor/mentor.dart';
import 'package:mentor/models/event_model.dart';
import 'package:mentor/pages/event_detail_page.dart';
import 'package:mentor/utils/app_utils.dart';
import 'package:mentor/views/auth/login.dart';
import 'package:mentor/views/class/classes.dart';
import 'package:mentor/views/home.dart';
import 'package:mentor/views/tutor/tutors.dart';
import 'package:mentor/widgets/nearby_event_card.dart';
import 'package:mentor/widgets/ui_helper.dart';
import 'package:mentor/widgets/upcoming_event_card.dart';

class EventPage extends StatefulWidget {
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  TabController controller;
  int _currentIndex = 0;

  ScrollController scrollController;
  AnimationController opacityController;
  Animation<double> opacity;
  AnimationController controller2;

  final auth = new Auth();
  final mentor = new Mentor();
  final events = new CEvent();

  @override
  void initState() {
    auth.read('name');
    super.initState();
    controller = new TabController(length: 4, vsync: this);

    scrollController = ScrollController();
    controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..forward();
    opacityController =
        AnimationController(vsync: this, duration: Duration(microseconds: 1));
    opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: opacityController,
    ));
    scrollController.addListener(() {
      opacityController.value = offsetToOpacity(
          currentOffset: scrollController.offset,
          maxOffset: scrollController.position.maxScrollExtent / 2);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  void viewEventDetail(Event event) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, animation, __) {
          return FadeTransition(
            opacity: animation,
            child: EventDetailPage(event),
          );
        },
      ),
    );
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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Most Popular Events")),
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
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: scrollController,
            // padding: EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIHelper.verticalSpace(16),
                buildUpComingEventList(),
                UIHelper.verticalSpace(16),
                buildNearbyConcerts(),
                UIHelper.verticalSpace(16),
              ],
            ),
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
                  print(this.runtimeType);
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()));
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(child: const Text('Logout'), value: 'Logout'),
        ],
      );

  Widget buildUpComingEventList() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Upcoming Events",
              style: headerStyle.copyWith(color: Colors.black)),
          UIHelper.verticalSpace(16),
          Container(
            height: 250,
            child: ListView.builder(
              itemCount: upcomingEvents.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final event = upcomingEvents[index];
                return UpComingEventCard(event,
                    onTap: () => viewEventDetail(event));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNearbyConcerts() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Nearby Concerts", style: headerStyle),
              Spacer(),
              Icon(Icons.more_horiz),
              UIHelper.horizontalSpace(16),
            ],
          ),
          FutureBuilder<List<Event>>(
            builder: (context, snapshot) {
              final nearbyEvents = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: nearbyEvents.length ?? 0,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    final event = nearbyEvents[index];
                    var animation =
                        Tween<double>(begin: 800.0, end: 0.0).animate(
                      CurvedAnimation(
                        parent: controller2,
                        curve: Interval((1 / nearbyEvents.length) * index, 1.0,
                            curve: Curves.decelerate),
                      ),
                    );
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) => Transform.translate(
                        offset: Offset(animation.value, 0.0),
                        child: NearbyEventCard(
                          event,
                          onTap: () => viewEventDetail(event),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            future: events.event_data(),
          ),
        ],
      ),
    );
  }
}
