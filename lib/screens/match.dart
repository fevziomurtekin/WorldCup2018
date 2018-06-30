import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../model/dao_match.dart';

class Match extends StatefulWidget{
  @override
  _Match createState() => new _Match();
}
class Details{
  String state_name,home_team,away_team,datetime;
  int goal_home,goal_away;
}

class _Match extends State<Match>{
  List<daoMatch> listMatch;
  String s;

  void getData() async{ // verileri asekron çekiyor.
    listMatch=new List();
    var url="https://worldcup.sfg.io/matches/today";
    var response=await http.get(url); // veriyi çekiyoruz.
    if(response.statusCode==200){
      s=response.body.toString();
      print(response.body.toString());
      //TODO veriyi parselerken hata alınıyor.

      /*listMatch=response.body as List<daoMatch>;*/
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }
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

      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center( // center horizontal=true
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // center vertical=true.
            children: <Widget>[
              new Text(s)
            ],
          ),
        ),
      ),
    );
  }
}