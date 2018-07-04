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

Future<List> fetchTeams(http.Client client) async{
  final response = await client.get('https://worldcup.sfg.io/matches/?by=total_goals');
  return parseTeam(response.body);
}

List parseTeam(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return json.decode(responseBody);
}

List parseMatch(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return json.decode(responseBody);
}

Future<List> fetchGroup(http.Client client) async {
  final response = await client.get('https://worldcup.sfg.io/teams/group_results');
  return parseMatch(response.body);
}

List parseGroup(String responseBody) {
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
  final Key todayPage = PageStorageKey('today');
  final Key GroupsPage = PageStorageKey('Groups');
  final Key teamPage = PageStorageKey('team');

  int currentTab = 0;
  Today todays;
  Groups groups;
  Team team;
  List<Widget> pages;
  Widget currentPage;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    // TODO: implement initState
    todays=new Today(
      key:todayPage,
    );

    groups=new Groups(
      key: GroupsPage,
    );

    team=new Team(
      key:teamPage,
    );

    pages=[todays,groups,team];
    currentPage = todays;
    super.initState();
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
      body:PageStorage(
          bucket: bucket,
          child: currentPage) ,
      bottomNavigationBar:new BottomNavigationBar(
        currentIndex: currentTab,
          onTap: (int index){
            setState(() {
              currentTab=index; // tapa tıklanınca indexini verdik ona göre sayfa değişecek.
              currentPage=pages[index];
            });
          },
          items: [
        new BottomNavigationBarItem(
           icon: new Icon(Icons.calendar_today),
            title: new Text(
                "Matchs",
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0
                ),)),
        new BottomNavigationBarItem(
           icon: new Icon(Icons.group_work),
            title: new Text("Groups",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0
              ),)),
        new BottomNavigationBarItem(
           icon: new Icon(Icons.calendar_view_day),
            title: new Text("All Match",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0
              ),)),
      ]),
    );
  }
}

class Today extends StatefulWidget {

  Today({Key key}) : super(key: key);

  @override
  TodayState createState() => TodayState();
}

class matchList extends StatelessWidget{
  final List matchs;
  matchList({Key key, this.matchs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.fromLTRB(25.0,15.0,0.0,0.0),
      child:new SizedBox(
        width: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(formated.format(now),
              style: TextStyle(
                  fontSize: 20.0,
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
                                  ), new Row(
                                    children: <Widget>[
                                      new Image.network("http://icons.iconarchive.com/icons/aha-soft/standard-city/256/stadium-icon.png",height: 30.0 ,width:30.0 ,),
                                      new Padding(padding: EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0)),
                                      new Text(matchs[index]["location"],style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),)
                                    ],
                                  ), new Column(
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              new Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0)),
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
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new Column(
                                            children: <Widget>[
                                              new Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                                              Image.network(_getCartoon(matchs[index]["home_team"]["code"]),height: 150.0,width: 150.0,),
                                              new Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                                              new Row(
                                                children: <Widget>[
                                                  new Text(matchs[index]["home_team_country"]),
                                                  new Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),
                                                ],
                                              ),
                                            ],
                                          ),new Column(
                                            children: <Widget>[
                                              new Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                                              Image.network(_getCartoon(matchs[index]["away_team"]["code"]),height: 150.0,width: 150.0,),
                                              new Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                                              new Row(
                                                children: <Widget>[
                                                  new Text(matchs[index]["away_team_country"]),
                                                  new Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),

                                                ],
                                              ),
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
String _getCartoon(String code) {
  switch(code){
    case "BRA":
      return "https://i.pinimg.com/originals/2a/3b/7a/2a3b7ad397aa17d969543c8bb5ab8ccb.png";
    case "MEX":
      return "https://i.pinimg.com/564x/3f/71/e4/3f71e486654bb183d8ee60765d270ac1.jpg";
    case "BEL":
      return "https://i.pinimg.com/564x/0c/19/ea/0c19eab28723aa22e48ceb6e484251d6.jpg";
    case "JPN":
      return "https://i.pinimg.com/564x/60/51/3f/60513ff09fd45b603059108ecc5f8a99.jpg";
    case "URU":
      return "https://i.pinimg.com/564x/2a/1a/58/2a1a5857f36c61b1c895703b42b0beb2.jpg";
    case "FRA":
      return "https://i.pinimg.com/originals/9f/a4/47/9fa4472bd94d7fce55690b8e13bd0897.png";
    case "SWE":
      return "https://i.pinimg.com/originals/94/a2/37/94a2372a216bf27dc1832ce7e1fd60c7.png";
    case "SUI":
      return "https://i.pinimg.com/564x/cc/f6/8b/ccf68b0d97babddaa9da138724329d1d.jpg";
    case "COL":
      return "https://i.pinimg.com/564x/d0/05/01/d00501bdd4a1aa91c9f5fb6c98a2959d.jpg";
    case "RUS":
      return "https://i.pinimg.com/564x/25/d0/aa/25d0aac623237fb43178ee84da9e7574.jpg";
    case "CRO" :
      return "https://i.pinimg.com/236x/a1/76/94/a176949b624c5bec51aa0378c48226c2.jpg" ;
    case "ENG":
      return "https://i.pinimg.com/originals/04/93/ca/0493cadecfe1d367082f642275c6e35e.png" ;
  }
  return "";
}

class TodayState extends State<Today>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List>(
      future: fetchMatch(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? matchList(matchs: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class Groups extends StatefulWidget{

  Groups({Key key}): super(key: key);

  GroupsState createState() => GroupsState();
}

class GroupsState extends State<Groups>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List>(
      future: fetchGroup(http.Client()), // değişecek.
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? groupsList(groups: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class groupsList extends StatelessWidget{

  final List groups;
  groupsList({Key key, this.groups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.fromLTRB(0.0,15.0,0.0,0.0),
      child:new SizedBox(
        width: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
                child: new ListView.builder(
                    itemCount: groups.length,
                    itemBuilder: (BuildContext context,int index){
                      return Column(
                        children: <Widget>[
                          new Text(groups[index]["letter"] ,softWrap: true,
                            style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),),
                          new Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0)),
                          new Card(
                            child: new Container(
                              padding: EdgeInsets.all(20.0),
                                child: new DataTable(
                                    columns:<DataColumn>[
                                      new DataColumn(label: new Text("Country",style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),)),
                                      new DataColumn(label: new Text("Point",style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),)),
                                      new DataColumn(label: new Text("Avarage",style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),)),
                                    ],
                                    rows: <DataRow>[
                                      new DataRow(
                                          cells: <DataCell>[
                                            new DataCell(new Text(groups[index]["ordered_teams"][0]["country"],style: new TextStyle(color: Colors.redAccent))),
                                            new DataCell(new Text(groups[index]["ordered_teams"][0]["points"].toString(),style: new TextStyle(color: Colors.redAccent))),
                                            new DataCell(new Text(groups[index]["ordered_teams"][0]["goal_differential"].toString(),style: new TextStyle(color: Colors.redAccent))),
                                          ],
                                      ),
                                      new DataRow(
                                        cells: <DataCell>[
                                          new DataCell(new Text(groups[index]["ordered_teams"][1]["country"],style: new TextStyle(color: Colors.redAccent))),
                                          new DataCell(new Text(groups[index]["ordered_teams"][1]["points"].toString(),style: new TextStyle(color: Colors.redAccent))),
                                          new DataCell(new Text(groups[index]["ordered_teams"][1]["goal_differential"].toString(),style: new TextStyle(color: Colors.redAccent))),
                                        ],
                                      ),
                                      new DataRow(
                                          cells:<DataCell>[
                                            new DataCell(new Text(groups[index]["ordered_teams"][2]["country"],)),
                                            new DataCell(new Text(groups[index]["ordered_teams"][2]["points"].toString())),
                                            new DataCell(new Text(groups[index]["ordered_teams"][2]["goal_differential"].toString(),)),
                                          ],
                                      ),
                                      new DataRow(
                                          cells: <DataCell>[
                                            new DataCell(new Text(groups[index]["ordered_teams"][3]["country"],)),
                                            new DataCell(new Text(groups[index]["ordered_teams"][3]["points"].toString(),)),
                                            new DataCell(new Text(groups[index]["ordered_teams"][3]["goal_differential"].toString(),)),
                                          ],
                                      ),
                                    ],
                                ),
                            ),
                          ),
                          new Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0)),
                        ],
                      );
                    }))
          ],
        ),
      ),
    );
  }

}

class Team extends StatefulWidget{

  Team({Key key}): super(key: key);

  TeamState createState() => TeamState();
}

class TeamState extends State<Team>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List>(
      future: fetchTeams(http.Client()), // değişecek.
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? teamList(teams: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class teamList extends StatelessWidget{

  final List teams;
  teamList({Key key, this.teams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.fromLTRB(25.0,15.0,0.0,0.0),
      child:new SizedBox(
        width: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
                child: new ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: teams.length,
                    itemBuilder: (BuildContext context,int index){
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Card(
                            child: new Container(
                              padding: EdgeInsets.all(20.0),
                              child: new Column(
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Text(teams[index]["stage_name"],style: new TextStyle(fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new Image.network("http://icons.iconarchive.com/icons/aha-soft/standard-city/256/stadium-icon.png",height: 30.0 ,width:30.0 ,),
                                          new Padding(padding: EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0)),
                                          new Text(teams[index]["location"],style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.indigo),)
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new Text("${teams[index]["weather"]["temp_celsius"].toString()} °C",style: new TextStyle(color: Colors.black)),
                                          new Padding(padding: EdgeInsets.fromLTRB(2.0,0.0,0.0,0.0)),
                                          new Image.network(getWeather(teams[index]["weather"]["description"]),height:30.0,width: 30.0,)
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              new Image.network("https://cdn.countryflags.com/thumbs/${(teams[index]["home_team_country"].toString()).toLowerCase()}/flag-800.png",height: 35.0,width: 35.0,),
                                              new Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0)),
                                              new Text(teams[index]["home_team_country"],style: new TextStyle(fontWeight: FontWeight.normal),),
                                              new Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0)),
                                            ],
                                          ),
                                          new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Text(teams[index]["home_team"]["goals"].toString(),style: new TextStyle(fontWeight: FontWeight.bold),),
                                              new Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0)),
                                              new Text("-",style: new TextStyle(fontWeight: FontWeight.normal),),
                                              new Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0)),
                                              new Text(teams[index]["away_team"]["goals"].toString(),style: new TextStyle(fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                          new Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              new Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0)),
                                              new Text(teams[index]["away_team_country"],style: new TextStyle(fontWeight: FontWeight.normal),),
                                              new Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0)),
                                              new Image.network("https://cdn.countryflags.com/thumbs/${(teams[index]["away_team_country"].toString()).toLowerCase()}/flag-800.png",height: 35.0,width: 35.0,),
                                              new Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0)),
                                            ],
                                          )
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

  String getWeather(team) {
    switch(team){
      case "Sunny":
        return "https://www.iconspng.com/images/weather-icon-sunny/weather-icon-sunny.jpg";
      case "Partly Cloudy":
        return "http://icon-park.com/imagefiles/simple_weather_icons_partly_cloudy.png";
      case "Cloudy":
        return "http://downloadicons.net/sites/default/files/blue-cloudy-symbol-icon-38700.png";
      case "Partly Cloudy Night":
        return "http://www.free-icons-download.net/images/sunny-to-partly-cloudy-at-night-icons-38692.png";
      case "Clear Night":
        return "https://previews.123rf.com/images/puruan/puruan1702/puruan170202260/71632481-nature-forecast-clear-night-icon-in-color-.jpg";

    }
  }

}


