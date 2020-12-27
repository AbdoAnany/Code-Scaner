import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:scan/setting.dart';

import 'home.dart';
class AppTheme{

  AppTheme._();
  AppTheme();
  static const Color test =  Color(0xff9f0000);

  static const  mix1 =  [Color(0xff0f3037),Color(0xffa6d18c),Color(0xfff6a03d),];
  static const  mix2 =  [Color(0xff321e5c),Color(0xffe52f62),Color(0xfff79d4d),];
  static const  mix3 =  [Color(0xff52184b),Color(0xffef8ab2),Color(0xff6554a4),];
  static const  mix4 =  [Color(0xff353b6b),Color(0xfff17343),Color(0xfff32b1e),];

  static const  mix5 =  [Color(0xff7acbce),Color(0xffbbdfc5),Color(0xffdca47f),];
  static const  mix6 =  [Color(0xffd6558d),Color(0xfff28c7d),Color(0xfffbab54),];
  static const  mix7 =  [Color(0xff18767e),Color(0xffa9bcb8),Color(0xfff27056),];
  static const  mix8 =  [Color(0xff552f92),Color(0xffc68ebb),Color(0xfffa93a6),];

  static const  mix9 =  [Color(0xffdc0b80),Color(0xff321e5c),Color(0xff321e5c),Color(0xffdc0b80),];
  static const  mix10 =  [Color(0xfff9c24e),Color(0xffec5741),Color(0xff883796),];
  static const  mix11 =  [Color(0xffda5161),Color(0xffbf65a2),Color(0xff7b87bb),];
  static const  mix12=  [Color(0xff87cfcb),Color(0xff9485c6),Color(0xfff37869),];

  static const  mix13 =  [Color(0xff58bde9),Color(0xff935fa7),Color(0xffe5b7d1),];
  static const  mix14 =  [Color(0xff334ea7),Color(0xff558ccd),Color(0xff7e599e),];
  static const  mix15 =  [Color(0xfff47294),Color(0xffb05a9b),Color(0xff643ea3),];
  static const  mix16=  [Color(0xff5ac2e9),Color(0xff78cab4),Color(0xff7f4a9a),];

  static const  mix17 =  [Color(0xff6cc5c3),Color(0xff9785bf),Color(0xff655699),];
  static const  mix18 =  [Color(0xfff8ce18),Color(0xffec5741),Color(0xff833694),];

  static const  mix19 =  [Color(0xff0600a7),Color(0xff2187ee),Color(0xff03afbf),];
  static const  mix20=  [Color(0xffff086f),Color(0xffff0808),Color(0xff36c19c),];


  static const Color a2 = Color(0xff321e5c);
  static const Color a11 = Color(0xffe52f62);
  static const Color a1 = Color(0xff353b6b);


  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color bg =  Color(0xff505051);
  static  Color blueGrey =  Colors.blueGrey[900];
  static const Color p1 =  Color(0xff263238);
  static const Color d1 =  Color(0xff000a12);
  static const Color l1 =  Color(0xff4f5b62);
  static const Color blod =  Color(0xff7f0000);
  static const Color d2 =  Color(0xffb71c1c);
  static const Color l2 =  Color(0xfff05545);
  static   MyDrawer (context){return Container(
    child: Column(children: [
      SizedBox(height: 20,),
      Container(child:FlatButton.icon(onPressed: (){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));

      }, icon: Icon(Icons.palette), label: Text('Palette')) ,),
      SizedBox(height: 20,),
      Container(child:FlatButton.icon(onPressed: (){}, icon: Icon(Icons.palette), label: Text('Palette')) ,),
      SizedBox(height: 20,),
      Container(child:FlatButton.icon(onPressed: (){}, icon: Icon(Icons.palette), label: Text('Palette')) ,),
      SizedBox(height: 20,),
      Container(child:FlatButton.icon(onPressed: (){}, icon: Icon(Icons.palette), label: Text('Palette')) ,),
      SizedBox(height: 20,),
    ],),
  );}

}


