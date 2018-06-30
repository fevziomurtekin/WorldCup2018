import 'package:flutter/material.dart';
import './screens/goalking.dart';
import './screens/team.dart';
import './screens/match.dart';

void main() => runApp(new MyApp()); // ilk myapp i çalıştırıp ona göre router(yönlendiriyoruz).

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Navigation",
      routes: <String,WidgetBuilder>{
        '/Home': (BuildContext contrex)=>new Match(),
        '/Second': (BuildContext contrex)=>new Goalking(),
        '/Third': (BuildContext contrex)=>new Team(),
      },
      home: new Match(),
      // ana sayfayı home belirledik. diğer sayfaları ise routes de belirledik.
    );
  }
}