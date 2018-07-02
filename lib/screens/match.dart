import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';

var now = new DateTime.now(); // simdiki zamanı atadık.
var formated = new DateFormat("dd/MM/yyyy");
var hour = new DateFormat("hh:mm");

Future<List> fetchMatch(http.Client client) async {
  final response = await client.get('https://worldcup.sfg.io/matches/today');

  return parseMatch(response.body);
}

List parseMatch(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return json.decode(responseBody);
}

class Match extends StatefulWidget{
  @override
  _Match createState() => new _Match();
}
class Details{
  String state_name,home_team,away_team,datetime;
  int goal_home,goal_away;
}

class _Match extends State<Match>{
  String s;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Container(
            child: new Text("World Cup Russia 2018",
              style: TextStyle(
                fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
          ),
        ),
        backgroundColor:Colors.indigo,
        actions: <Widget>[
          new Image.network("http://files.softicons.com/download/sport-icons/fifa-world-cup-2006-icons-by-yellow-icon/ico/cup.ico",height: 40.0,width: 40.0,)
        ],
      ),
      bottomNavigationBar:new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
           icon: new Icon(Icons.calendar_today),
            title: new Text(
                "Matchs",
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0
                ),)),
        new BottomNavigationBarItem(
           icon: new Icon(Icons.person),
            title: new Text("Goal King",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0
              ),)),
        new BottomNavigationBarItem(
           icon: new Icon(Icons.people),
            title: new Text("Teams",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0
              ),)),
      ]),

      body:FutureBuilder<List>(
        future: fetchMatch(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? matchList(matchs: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class matchList extends StatelessWidget{
  final List matchs;
  matchList({Key key, this.matchs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(32.0),
      child:new SizedBox(
        width: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(formated.format(now),
            style: TextStyle(
                fontWeight: FontWeight.bold,color: Colors.black),),
            new Expanded(
                child: new ListView.builder(
                  padding: EdgeInsets.all(10.0),
                    itemCount: matchs.length,
                    itemBuilder: (BuildContext context,int index){
                      return Row(
                        children: <Widget>[
                         new Card(
                           child: new Container(
                             padding: EdgeInsets.all(20.0),
                             child: new Column(
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(matchs[index]["stage_name"],style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)
                                      )
                                    ],
                                  ), new Column(
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              new Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 5.0)),
                                              new Icon(Icons.timer),
                                              new Text(((((matchs[index]["datetime"].toString()).split("T"))[1]).split(":")[0])+":"
                                                  +((((matchs[index]["datetime"].toString()).split("T"))[1]).split(":")[1])+":00",
                                                textAlign: TextAlign.center,style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black45
                                                ),)
                                            ],
                                          )

                                        ],
                                      )
                                    ],
                                  ),new Row(
                                    children: <Widget>[
                                      new Image.network("http://icons.iconarchive.com/icons/aha-soft/standard-city/256/stadium-icon.png",height: 30.0 ,width:30.0 ,),
                                      new Padding(padding: EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0)),
                                      new Text(matchs[index]["location"],style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      color: Colors.indigo),)
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              new Text(matchs[index]["home_team_country"]),
                                              new Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),
                                              new Text(matchs[index]["home_team"]["goals"].toString())
                                            ],
                                          ),
                                          new Text(" - "),
                                          new Row(
                                            children: <Widget>[
                                              new Text(matchs[index]["away_team"]["goals"].toString()),
                                              new Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0)),
                                              new Text(matchs[index]["away_team_country"])
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                             ),
                           ),
                         )
                        ],
                      );
                    }))
          ],
        ),
      ),
    );
  }


}

