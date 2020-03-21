import 'package:flutter/material.dart';
import 'package:mentor/controllers/auth/auth.dart';
import 'package:mentor/controllers/mentor/mentor.dart';
import 'package:mentor/models/auth/mentor.dart';
import 'package:mentor/views/tutor/tutors.dart';

class DetailPage extends StatefulWidget {
  final id;
  DetailPage({this.id});


  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  
  final auth = new Auth();
  final mentor = new Mentor();

    Future<UserMentor> mentorData;

  @override
  void initState() {
    auth.read('name');
    mentorData = mentor.mentor(widget.id);
    super.initState();
    print(mentorData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body : FutureBuilder<UserMentor>(
            future: mentorData,
            builder: (context, snapshot) {
            if (snapshot.hasData) {

                return ListView(
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          color: Color(0xFFFE7050),
                        ),
                        Positioned(
                          bottom: 22.0,
                          child: Container(

                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.3), size: 11.0),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.5), size: 12.0),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.7), size: 13.0),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.9), size: 14.0),
                                  RotatedBox(child: Icon(Icons.local_airport, color: Colors.white), quarterTurns: 1),
                                ],
                              ),
                            )
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 65.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.0), bottomRight: Radius.circular(35.0)),
                            color: Colors.white
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 400.0,
                          width: MediaQuery.of(context).size.width,
                          child: snapshot.data.photo == null ? Image.asset("assets/images/1.png", fit: BoxFit.cover) : Image.network(snapshot.data.photo, fit: BoxFit.cover),

                        ),
                        Positioned(
                          top: 350.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height:  15.0),
                              Padding(
                                padding: const EdgeInsets.only(left:15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 35.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.location_on, size: 16.0, color: Colors.grey),
                                              Text("${snapshot.data.country}, ${snapshot.data.city}",
                                              style: TextStyle(
                                                fontFamily: 'Opensans',
                                                fontSize: 14.0,
                                                color: Colors.grey
                                              ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Text("${snapshot.data.name}",
                                          style: TextStyle(
                                            fontFamily: 'Opensans',
                                            fontSize: 27.0,
                                            fontWeight: FontWeight.w600
                                          )
                                          )
                                        ],
                                      ),
                                      InkWell(
                                          onTap:(){},
                                          child: Container(
                                          height: 60.0,
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(20.0)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Icon(Icons.favorite_border, color: Colors.black, size: 20.0),
                                              SizedBox(height: 17.0)
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                                child: Row(
                                children: <Widget>[
                                    Container(
                                      width: 220.0,
                                      child: Text("${snapshot.data.topic}",
                                        style: TextStyle(
                                            fontFamily: 'Opensans',
                                            fontSize: 15.0,
                                            color: Color(0xFF6A6A6A),
                                            fontWeight: FontWeight.w600)),
                                    ),
                                  Stack(
                                    children: <Widget>[
                                      Container(height: 40.0, width: 70.0),
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
                                              color: Color(0xFFFE7050)),
                                          child: Center(
                                            child: Text('+28',
                                                style: TextStyle(
                                                    fontSize: 14.0, color: Colors.white)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 10.0),
                                  InkWell(
                                    onTap: (){
                                        Navigator.of(context).push (
                                          MaterialPageRoute(builder: (BuildContext context) => TutorsPage())
                                        );
                                    },
                                    child: Text(
                                      'More',
                                      style:
                                          TextStyle(color: Color(0xFF6A6A6A), fontFamily: 'Opensans', fontWeight: FontWeight.w600),
                                ),
                                  )
                                ],
                            ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.0, left: 15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text("${snapshot.data.subject}",
                                  style:
                                      TextStyle(color: Color(0xFF6A6A6A), fontFamily: 'Opensans', fontWeight: FontWeight.w300)
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 15.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: (){ Navigator.of(context).pop();},
                                    child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 15.0)),
                                  SizedBox(width: 20.0),
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
                                          Text("${snapshot.data.rate}",
                                            style: TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    )
                                  )
                              ],
                            ),
                            Icon(Icons.file_upload, color: Colors.white)
                      ],
                    ),
                          ),
                        )
                      ]
                    ),
                  ]
            );
            }else if (snapshot.hasError) {
                return Text("${snapshot.error}");
            }

            return Center( child: CircularProgressIndicator(),);

        }),
    );
  }
}