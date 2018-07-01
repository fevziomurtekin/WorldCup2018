import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../model/dao_match.dart';


Future<List<daoMatch>> fetchMatch(http.Client client) async {
  final response =
  await client.get('https://worldcup.sfg.io/matches/today');

  return parseMatch(response.body);
}

List<daoMatch> parseMatch(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<daoMatch>((json) => daoMatch.fromJson(json)).toList();
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
  List<daoMatch> listMatch;
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

      body:FutureBuilder<List<daoMatch>>(
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
  final List <daoMatch> matchs;
  matchList({Key key, this.matchs}) : super(key: key);

  ExpansionPanel _createitem(daoMatch item) {
    return new ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return new Container(
            padding: new EdgeInsets.all(5.0),
            child: new Text('${item.homeTeam}'),
          );
        },
        body:new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Text('Expansion Item'),
        ),
        isExpanded:false

    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(32.0),
      child: new ListView( // listview içine model listimizi atayıp , expansionun içine ise createItem ile oluşturduğumuz. Hello world yazılarını attık.
        children: <Widget>[
          new ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
            },
            children: matchs.map(_createitem).toList(),
          )
        ],
      ),
    );
  }


}

