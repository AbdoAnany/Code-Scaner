
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductData{

  dynamic id;
  String name;
  int price;
  String barcode ;
  String description;

  

}

class PostData {


  int id ;
  String date ;
  int type ;
  String content ;
  String course_name ;
  String data_type ;
  int course_code ;
  List files ;
  bool is_saved ;
  List owner ;


  PostData(
      this.id,
      this.date,
      this.type,
      this.data_type,
      this.content,
      this.course_name,
      this.course_code,
      this.is_saved,
      this.owner,
      [this.files]);

  PostData.map(dynamic obj){
    this.date =obj['date'] ;
    this.type=obj['type'] ;
    this.content=obj['content'] ;
    this.course_name=obj['course_name'] ;
    this.id=obj['id'] ;
    this.files=obj['files'] ;
    this.data_type=obj['data_type'] ;
    this.course_code=obj['course_code'] ;
    this.is_saved=is_aprove(obj['is_saved'] );
    this.owner=obj['owner'] ;
  }

  bool is_aprove(int x){
    if(x==1)
      return true;
    else
      return false;

  }
  List is_list(Map<String,dynamic> x){
    List y=[x["code"],x["name"],x["email"],x["profile_image"]];
    return y;


  }

  String get _date=>date;
  int get _type=>type;
  String get _content=>content;
  String get _course_name=>course_name;
  int get _id=>id;
  String get _data_type=>data_type;
  int get _course_code=>course_code;
  List get _files=>files;
  bool get _is_saved=>is_saved;
  List get _owner=>owner;


  Map<String,dynamic>toMap(){
    var map =new Map<String,dynamic>();
    if(id!=null){
      map['id']=_id;
    }
    map['date']=_date;
    map['type']=_type;
    map['content']=_content;
    map['course_name']=_course_name;
    map['data_type']=_data_type;
    map['course_code']=_course_code;
    map['files']=_files;
    map['is_saved']=_is_saved;
    map['owner']=_owner;


    return map;
  }

  PostData.fromMap(Map<String,dynamic>map){
    var z=DateTime.parse(map['date']);
    this.date =  this.date=DateFormat.jm().format(z)+" "+DateFormat.yMEd().format(z) ;
    this.type=map['type'] ;
    this.content=map['content'] ;
    this.course_name=map['course_name'] ;
    this.id=map['id'] ;
    this.course_code=map['course_code'] ;
    this.data_type=map['data_type'] ;
    this.files=map['files'] ;
    if (map['is_saved'].runtimeType==id.runtimeType) {
      this.is_saved = is_aprove(map['is_saved']);
    } else {
      this.is_saved = map['is_saved'];

    }
    if (map['owner'].runtimeType==map.runtimeType) {
      this.owner = is_list(map['owner'])as List;
    } else {
      this.owner = map['owner'];

    }
  }



}