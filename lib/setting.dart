
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scan/appTheme.dart';

class Hot extends StatefulWidget {
  Hot({Key key}) : super(key: key);

  @override
  _HotState createState() => _HotState();
}

class _HotState extends State<Hot> {
  var save, list = [], save1 = [],val, fav ;
  final url = 'https://morning-bayou-24260.herokuapp.com/get';
  TextEditingController _inputController;
  Uint8List bytes = Uint8List(0);
  Path path = Path();
  String mess,bar,search_by='name';

  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    val = true;
    fav = false;
    mess="Welcome In Open Casher ^_^ ";
  }

  Future<List> getData() async {

  }




  @override
  Widget build(BuildContext context) {
    var w= MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (BuildContext context) {
          return Container(child: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(right: 5, top: 10, bottom: 10, left: 5),
                height: 75, width: w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: AppTheme.mix9)),
                child: Stack(alignment: Alignment.centerLeft ,
                  children: [
                    Positioned(child:     Container(
                      height: 50,
                      width: w * .7,
                      decoration: BoxDecoration( color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextField(
                        controller: this._inputController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {setState(() {
                          getData();
                        });},
                        style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold) ,
                        decoration: InputDecoration(

                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: AppTheme.a2,
                          ),
                          hintText: 'Please Input Your $search_by',
                          hintStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                    )),


                  ],
                ),

              ),
              Menu(),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: FutureBuilder<List>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 10),
                          child: ListView.builder(
                              itemCount: save1.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CommentItem(save1[index]);
                              }))
                          : mess=="0"?
                      Container(alignment: Alignment.topCenter,
                          child: CupertinoActivityIndicator(animating:true,radius:30,)):
                      Text(
                        mess,
                        textAlign: TextAlign.center,
                      );
                    }),
              ),
            ],),
          ),);
        },
      ),

    );
  }


  Widget CommentItem(prouduct) {
    var z = DateTime.parse(prouduct['date']);
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5,bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 10,offset:Offset(5,10)),
        ],
        gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,
            colors: AppTheme.mix9),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      padding: EdgeInsets.all(20),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Name : " + prouduct["name"].toString(),
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: AppTheme.white),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: [ Text(
                "Price : " + prouduct["price"].toString() + " LE",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppTheme.white),
                textAlign: TextAlign.start,
              ),FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      fav = !fav;
                    });
                  },
                  icon: Icon(
                    Icons.favorite,size: 15,
                    color: fav ? Colors.red : Colors.grey,
                  ),
                  label: Text(''))],),
              SizedBox(
                height: 10,
              ),
              Text(
                "Last Update  " + DateFormat.yMEd().format(z),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: AppTheme.white),
                textAlign: TextAlign.start,
              ),
            ],
          ),


        ],
      ),
    );
  }
  Widget Menu() {

    return ListTile(
      title: Text(
        "Search By : $search_by",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
      trailing: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        onSelected: (value) {setState(() {
          search_by=value;
        });},
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: "name",
            child: ListTile(
              leading: const Icon(Icons.art_track,size: 30,color: AppTheme.a2),
              title: Text(
                  "Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: "price",
            child: ListTile(
              leading: const Icon(Icons.attach_money,size: 30,color: Colors.yellow),
              title: Text(
                  "Price",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: "barcode",
            child: ListTile(
              leading: const Icon(Icons.qr_code,size: 30,color: AppTheme.black,),
              title: Text(
                  "Barcode",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)
              ),
            ),
          ),
        ],
      ),
    );
  }




}
