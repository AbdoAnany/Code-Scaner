import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'appTheme.dart';
import 'home.dart';
import 'home_page.dart';

class ID extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EA STADY',
      theme: ThemeData(
        primaryColor: AppTheme.a2,
        primaryColorDark: AppTheme.a2,
        primaryColorLight: AppTheme.a2,
          accentColor: AppTheme.a2
      ),
      home: IDPage(),
    );
  }
}

class IDPage extends StatefulWidget {
  @override
  _IDState createState() => _IDState();
}

class _IDState extends State<IDPage> {
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    //  if(jsonDataUsers.isEmpty)
    // getAllData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeCourse()));
    });
    //getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      checkerboardOffscreenLayers: false,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'images/7.gif',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Text('')),
      ),
    );
  }
}
