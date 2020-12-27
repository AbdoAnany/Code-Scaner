import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:scan/add.dart';
import 'appTheme.dart';

class Generate extends StatefulWidget {
  @override
  _GenrateState createState() => _GenrateState();
}

class _GenrateState extends State<Generate> {
  Uint8List bytes = Uint8List(0);
  TextEditingController _inputController;
  TextEditingController _outputController;

  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var h= MediaQuery.of(context).size.height;
    var w= MediaQuery.of(context).size.width;

    return Scaffold(

        backgroundColor: Colors.white,
        body: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 5, top: 10, bottom: 10, left: 5),
                  height: 50, width: w,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: AppTheme.mix9)),
                  child: Stack(alignment: Alignment.centerLeft ,
                    children: [
                      Positioned(left: w/3.5,  child:      Text(
                        "GENERATE",
                        style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                      ),),
                      Positioned(left: w*.8,child:   Container(
                        width:50 ,
                        decoration: BoxDecoration(
                            color:   Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(5)),

                        ),
                        child: FlatButton(onPressed: ()=>
                            Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Add_Product())),
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color:    Colors.white,
                          ),
                        ),
                      ),),



                    ],
                  ),

                ),
                _qrCodeWidget(this.bytes, context),
                Container(
                  margin: EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
                  height: 50,
                  child:    TextField(
                    controller: _inputController,cursorColor: AppTheme.a2,
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {setState(() {
                      _generateBarCode(_inputController.text);
                    });},
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(gapPadding: 5),
                      prefixIcon: Icon(
                        Icons.qr_code_scanner,
                        color:AppTheme.a2,size: 50,
                      ),
                      labelStyle:TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ,
                      labelText: "Barcode",
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            )
          ,


    );
  }

  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(boxShadow:[

        BoxShadow( color: Colors.black,
          spreadRadius: 1,
          blurRadius: 10,
          offset: Offset(5, 10))],
          borderRadius: BorderRadius.all(Radius.elliptical(25, 25),


          ),
          gradient: LinearGradient(
              begin: Alignment.topLeft,end: Alignment.bottomRight,
              colors: AppTheme.mix9
          )
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 120,
                  child: bytes.isEmpty
                      ? Center(
                    child:   Container(
                      height: 120,
                      width:120 ,
                      decoration: BoxDecoration(
                        color: Colors.white,  image: DecorationImage(
                          image: AssetImage(
                            'images/qr.png',
                          ),
                          fit: BoxFit.cover),

                      ),

                    ),
                  )
                      : Center(child: Image.memory(bytes,),),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 25,
                    right: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: GestureDetector(
                          child: Text(
                            'remove',
                            style: TextStyle(
                                color:   AppTheme.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            this.setState(() {
                              this.bytes = Uint8List(0);
                              _inputController.clear();
                            });
                          },
                        ),
                      ),
                      Text(' |',
                          style: TextStyle(
                              color:   AppTheme.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Expanded(
                        flex: 5,
                        child: GestureDetector(
                          onTap: () async {
                            SnackBar snackBar;
                            if(this.bytes.isNotEmpty){
                              final   success = await ImageGallerySaver.saveImage(this.bytes,);
                              if (success.toString().isNotEmpty) {
                                snackBar = new SnackBar(
                                    content: new Text(
                                        'Successful Preservation!  ${this._inputController.text}'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {
                                snackBar = new SnackBar(
                                    content: new Text('Save failed!'));
                              }
                            }
                          },
                          child: Text(
                            'save',
                            style: TextStyle(
                                color:   AppTheme.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );

  }


  Future _scan() async {
    String barcode = await scanner.scan();
    this._outputController.text = barcode;
    Uint8List result =
    await scanner.generateBarCode(this._outputController.text);
    this.setState(() => this.bytes = result);
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    this._outputController.text = barcode;
    Uint8List result =
    await scanner.generateBarCode(this._outputController.text);
    this.setState(() => this.bytes = result);
  }

  Future _scanPath(String path) async {
    String barcode = await scanner.scanPath(path);
    this._outputController.text = barcode;
  }

  Future _scanBytes() async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    Uint8List bytes = file.readAsBytesSync();
    String barcode = await scanner.scanBytes(bytes);
    this._outputController.text = barcode;
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
}
