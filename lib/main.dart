import 'package:flutter/material.dart';
import 'package:twitter_timeline/src/pages/Home.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart'; 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueAccent.withOpacity(0.2),
        appBar: AppBar(
          leading: Icon(EvaIcons.twitter,color: Colors.blueAccent,),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Twitter Timeline API',style: TextStyle(color:Colors.blueAccent),),
        ),
        body:Home()
      ),
    );
  }
}