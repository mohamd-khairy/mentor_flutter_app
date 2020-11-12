import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mentor/constant/color.dart';
import 'package:mentor/constant/text_style.dart';
import 'package:mentor/models/event_model.dart';
import 'package:mentor/utils/datetime_utils.dart';
import 'package:mentor/widgets/ui_helper.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;
  EventDetailPage(this.event);
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage>
    with TickerProviderStateMixin {
  Event event;
  AnimationController controller;
  AnimationController bodyScrollAnimationController;
  ScrollController scrollController;
  Animation<double> scale;
  Animation<double> appBarSlide;
  double headerImageSize = 0;
  bool isFavorite = false;
  @override
  void initState() {
    event = widget.event;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    bodyScrollAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset >= headerImageSize / 2) {
          if (!bodyScrollAnimationController.isCompleted)
            bodyScrollAnimationController.forward();
        } else {
          if (bodyScrollAnimationController.isCompleted)
            bodyScrollAnimationController.reverse();
        }
      });

    appBarSlide = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: bodyScrollAnimationController,
    ));

    scale = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    bodyScrollAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    headerImageSize = MediaQuery.of(context).size.height / 2.5;
    return ScaleTransition(
      scale: scale,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildHeaderImage(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildEventTitle(),
                          UIHelper.verticalSpace(16),
                          buildEventDate(),
                          UIHelper.verticalSpace(24),
                          buildAboutEvent(),
                          UIHelper.verticalSpace(24),
                          buildOrganizeInfo(),
                          UIHelper.verticalSpace(24),
                          buildEventLocation(),
                          UIHelper.verticalSpace(124),
                          //...List.generate(10, (index) => ListTile(title: Text("Dummy content"))).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                child: buildPriceInfo(),
                alignment: Alignment.bottomCenter,
              ),
              AnimatedBuilder(
                animation: appBarSlide,
                builder: (context, snapshot) {
                  return Transform.translate(
                    offset: Offset(0.0, -1000 * (1 - appBarSlide.value)),
                    child: Material(
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                      child: buildHeaderButton(hasTitle: true),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderImage() {
    double maxHeight = MediaQuery.of(context).size.height;
    double minimumScale = 0.8;
    return GestureDetector(
      onVerticalDragUpdate: (detail) {
        controller.value += detail.primaryDelta / maxHeight * 2;
      },
      onVerticalDragEnd: (detail) {
        if (scale.value > minimumScale) {
          controller.reverse();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: headerImageSize,
            child: Hero(
              tag: event.image,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(32)),
                child: Image.network(
                  event.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          buildHeaderButton(),
        ],
      ),
    );
  }

  Widget buildHeaderButton({bool hasTitle = false}) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              child: InkWell(
                onTap: () {
                  if (bodyScrollAnimationController.isCompleted)
                    bodyScrollAnimationController.reverse();
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: hasTitle ? Colors.white : Colors.black,
                  ),
                ),
              ),
              color: hasTitle ? Theme.of(context).primaryColor : Colors.white,
            ),
            Card(
              shape: CircleBorder(),
              elevation: 0,
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () => setState(() => isFavorite = !isFavorite),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white),
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventTitle() {
    return Container(
      child: Text(
        event.name,
        style: headerStyle.copyWith(fontSize: 32),
      ),
    );
  }

  Widget buildEventDate() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("${DateTimeUtils.getMonth(event.eventDate)}",
                    style: monthStyle),
                Text("${DateTimeUtils.getDayOfMonth(event.eventDate)}",
                    style: titleStyle),
              ],
            ),
          ),
          UIHelper.horizontalSpace(22),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(DateTimeUtils.getDayOfWeek(event.eventDate),
                  style: titleStyle),
              UIHelper.verticalSpace(4),
              Text("10:00 - 12:00 PM", style: subtitleStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAboutEvent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("About", style: headerStyle),
        UIHelper.verticalSpace(),
        Text(event.description, style: subtitleStyle),
      ],
    );
  }

  Widget buildOrganizeInfo() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          child: Text(event.organizer[0]),
        ),
        UIHelper.horizontalSpace(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.organizer, style: titleStyle),
            UIHelper.verticalSpace(4),
            Text("Organizer", style: subtitleStyle),
          ],
        ),
        Spacer(),
        FlatButton(
          child: Text("Follow",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: () {},
          shape: StadiumBorder(),
          color: primaryLight,
        )
      ],
    );
  }

  Widget buildEventLocation() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/map.jpg',
        height: MediaQuery.of(context).size.height / 3,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildPriceInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Price", style: subtitleStyle),
              UIHelper.verticalSpace(8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "\$${event.price}",
                        style: titleStyle.copyWith(
                            color: Theme.of(context).primaryColor)),
                    TextSpan(
                        text: "/per person",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          RaisedButton(
            onPressed: () {},
            shape: StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: Theme.of(context).primaryColor,
            child: Text(
              "Join",
              style: titleStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
