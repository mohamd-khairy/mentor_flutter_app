import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mentor/constant/text_style.dart';
import 'package:mentor/controllers/event/event.dart';
import 'package:mentor/models/event_model.dart';
import 'package:mentor/pages/event_detail_page.dart';
import 'package:mentor/utils/app_utils.dart';
import 'package:mentor/widgets/home_bg_color.dart';
import 'package:mentor/widgets/nearby_event_card.dart';
import 'package:mentor/widgets/ui_helper.dart';
import 'package:mentor/widgets/upcoming_event_card.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  ScrollController scrollController;
  AnimationController controller;
  AnimationController opacityController;
  Animation<double> opacity;
  final events = new CEvent();

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

  @override
  void initState() {
    scrollController = ScrollController();
    controller =
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
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomeBackgroundColor(opacity),
          SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIHelper.verticalSpace(16),
                buildUpComingEventList(),
                UIHelper.verticalSpace(16),
                buildNearbyConcerts(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }

  Widget buildUpComingEventList() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Upcoming Events",
              style: headerStyle.copyWith(color: Colors.white)),
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
                        parent: controller,
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
