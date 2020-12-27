import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'package:scan/home_page.dart';

import 'appTheme.dart';
import 'generate.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  Uint8List bytes = Uint8List(0);
  TextEditingController _inputController, _outputController;
  var save, list = [], save1 = [];
  bool val, fav;
  String bar;

  int count, sum = 0, s = 0;
  final url = 'https://morning-bayou-24260.herokuapp.com/get';

  Future<List> getData() async {
    http.Response response = await http
        .get(url + "/barcode/${_inputController.text}")
        .then((response) {
      if (response.body == "Not Found" || _inputController.text.isEmpty) {
        return;
      } else {
        save1 = json.decode(response.body);
        count = save1.length;
        s += 1;
      }
    });
    return save1;
  }

  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    val = true;
    fav = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan",
          style: TextStyle(fontSize: 20, ),
        ),
        centerTitle: true,
      //  backgroundColor: AppThame.test,
        actions: [
          Container(
            width: 50,
           // color: AppThame.test,
            child: FlatButton(
              onPressed: () => _scanPhoto(),
              child: Icon(
                Icons.camera,
                size: 30,
        //        color: AppThame.white,
              ),
            ),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(
             // color: AppThame.test,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: FlatButton(
              onPressed: () => null,
              child: Icon(
                Icons.image,
                size: 30,
            //    color: AppThame.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
   //   backgroundColor: AppThame.white,
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              val ? _qrCodeWidget(this.bytes, context) : SizedBox(),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    margin: EdgeInsets.only(
                        right: 10, top: 20, bottom: 20, left: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                       //     color: AppThame.test,
                            width: 3)),
                    child: TextField(
                      controller: this._inputController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) => _generateBarCode(value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.text_fields,
                         // color: AppThame.test,
                        ),
                        hintText: 'Please Input Your Code',
                        hintStyle: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () => getData(),
                   // backgroundColor: AppThame.test,
                    child: Icon(
                      Icons.search,
                      size: 30,
                  //    color: AppThame.white,
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(20),
           //     color: AppThame.white,
                child: FutureBuilder<List>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return save1.isNotEmpty
                          ? Container(
                              height: 50,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 10),
                              child: ListView.builder(
                                  itemCount: count,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return CommentItem(save1[index]);
                                  }))
                          : Text(
                              "Not Found",
                              textAlign: TextAlign.center,
                            );
                    }),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
     //   foregroundColor: AppThame.test,
     //   focusColor: AppThame.test,
        onPressed: () => _scanBytes(),
        tooltip: 'Take a Photo',
        child: const Icon(
          Icons.camera_alt,
    //      color: AppThame.white,
        ),
      ),
    );
  }

  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
    return Card(
      elevation: 10,
    //  color: AppThame.test,
      margin: EdgeInsets.all(30),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 180,
                    child: bytes.isEmpty
                        ? Center(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                            //      color: AppThame.white,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'images/qr.png',
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                          //            color: AppThame.test,
                                             width: 3)),
                              child: FlatButton(
                                onPressed: () => _scan(),
                                child: Text(
                                  "Scan",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: QrImage(
                              gapless: true,
                              foregroundColor: Colors.blueGrey[900],
                              data: _inputController.text,
                              errorCorrectionLevel: 3,
                              version: QrVersions.auto,
                           //   backgroundColor: AppThame.white,
                              size: 200,
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
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
                              //    color: AppThame.test,
                                  fontSize: 22,
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
                        Text('|',
                            style: TextStyle(
                              //  color: AppThame.test,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () async {
                              SnackBar snackBar;
                              if (this.bytes.isNotEmpty) {
                                final success =
                                    await ImageGallerySaver.saveImage(
                                  this.bytes,
                                );
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
                                //  color: AppThame.test,
                                  fontSize: 25,
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
            Divider(height: 2, //color: AppThame.test
            ),
          ],
        ),
      ),
    );
  }

  Widget CommentItem(prouduct) {
    var z = DateTime.parse(prouduct['date']);
    return Card(
      elevation: 2,
     // color: AppThame.test,
      child: Container(
        decoration: BoxDecoration(
        //  color: AppThame.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Name : " + prouduct["name"].toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Price : " + prouduct["price"].toString() + " LE",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Last Update  " + DateFormat.yMEd().format(z),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Spacer(),
            Spacer(),
            FlatButton.icon(
                onPressed: () {
                  setState(() {
                    fav = !fav;
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  color: fav ? Colors.red : Colors.grey,
                ),
                label: Text(''))
          ],
        ),
      ),
    );
  }

  Future showalert(String error) async {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            decoration: BoxDecoration(
              //  color: AppThame.test,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  error,
                  style: TextStyle(fontSize: 20,// color: AppThame.white
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
              //      color: AppThame.white,
                  ),
                )
              ],
            ),
          );
        });
  }

  Future<String> _scan() async {
    String barcode = await scanner.scan();
    this.bar = barcode;
    this._inputController.text = barcode;
    Uint8List result =
        await scanner.generateBarCode(this._inputController.text);
    this.setState(() {
      this.bytes = result;
      this.bar = barcode;
    });
    return barcode;
  }

  Future<String> _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    this.bar = barcode;
    this._outputController.text = barcode;
    Uint8List result =
        await scanner.generateBarCode(this._inputController.text);
    this.setState(() {
      this.bytes = result;
      this.bar = barcode;
    });
    return barcode;
  }

  Future _scanPath(String path) async {
    String barcode = await scanner.scanPath(path);
    this._inputController.text = barcode;
  }

  Future _scanBytes() async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    Uint8List bytes = file.readAsBytesSync();
    String barcode = await scanner.scanBytes(bytes);
    this._inputController.text = barcode;
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
}
