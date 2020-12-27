import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;

import 'appTheme.dart';

class Add_Product extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Add_ProductState();
  }
}

class Add_ProductState extends State<Add_Product> {
  Uint8List bytes = Uint8List(0);

  var save;
  var save1 = [];
  String bar;
  int count;
  TextEditingController name;
  TextEditingController price;
  TextEditingController description;
  TextEditingController barcode;
  final url = 'https://morning-bayou-24260.herokuapp.com/post';

  Future AddProudeuct() async {
    int x = int.tryParse(price.text);
    var bodyy = {
      "description": [description.text],
      "name": name.text.toString(),
      "price": x,
      "barcode": barcode.text.toString()
    };
    print(bodyy);
    print(json.encode(bodyy));
    if (name.text.isEmpty || price.text.isEmpty || barcode.text.isEmpty) {
      showalert("name , price & barcode are requird");
    } else {
      await http.post(url, body: {
        "description": [description.text].toString(),
        "name": name.text.toString(),
        "price": x.toString(),
        "barcode": barcode.text.toString()
      }).then((response) {
        save = json.decode(response.body);
        if (response.statusCode == 200) {
          print(response.body);
          showalert("Product Added");
        }
      });
    }
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
                color: AppTheme.a2,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  error,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    price = new TextEditingController();
    barcode = new TextEditingController();
    name = new TextEditingController();
    description = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.only(top: 20),
          child: ListView(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(right: 5, top: 10, bottom: 10, left: 5),
                height: 50,
                width: w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: AppTheme.mix9)),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Positioned(
                      left: w / 5,
                      child: Text(
                        "Add New Product",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: w * .8,
                      child: Container(
                        width: 50,

                        child: FlatButton(
                          onPressed: () => _scanPhoto(),
                          child: Icon(
                            Icons.image,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: 50,
                      left: w * .7,
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: FlatButton(
                          onPressed: () => _scan(),
                          child: Icon(
                            Icons.settings_overscan,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    height: 50,
                    child: TextFormField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(gapPadding: 5),
                        prefixIcon: Icon(
                          Icons.local_grocery_store,
                          color: AppTheme.a2,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        labelText: "Product Name",
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    height: 50,
                    child: TextFormField(
                      controller: price,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(gapPadding: 5),
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: AppTheme.a2,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        suffixStyle: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.normal),
                        labelText: "Price",
                        suffixText: "EL",
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    height: 50,
                    child: TextFormField(
                      controller: barcode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(gapPadding: 5),
                        prefixIcon: Icon(
                          Icons.qr_code_scanner,
                          color: AppTheme.a2,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        labelText: "Barcode",
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    child: TextFormField(
                      controller: description,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(gapPadding: 5),
                        prefixIcon: Icon(
                          Icons.description,
                          color: AppTheme.a2,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        labelText: "Description",
                      ),
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
               Container(
                 child: Tooltip(message: "Add New Product in System",
                   child:    FloatingActionButton.extended(
backgroundColor: Colors.transparent,
                 icon: const Icon(Icons.add),
                 label: Text("Add Product",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                 onPressed: () {
                   AddProudeuct();
                 },
               ),
               ),  decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                   gradient: LinearGradient(
                       begin: Alignment.topLeft,
                       end: Alignment.bottomRight,
                       colors: AppTheme.mix9)),
               ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _scan() async {
    String barcode = await scanner.scan();
    this.bar = barcode;
    this.barcode.text = barcode;
    Uint8List result = await scanner.generateBarCode(this.barcode.text);
    this.setState(() {
      this.bytes = result;
      this.bar = barcode;
    });
    return barcode;
  }

  Future<String> _scanPhoto() async {
    String barcode1 = await scanner.scanPhoto();
    this.bar = barcode1;
    this.barcode.text = barcode1;
    Uint8List result = await scanner.generateBarCode(this.barcode.text);
    this.setState(() {
      this.bytes = result;
      this.bar = barcode1;
    });
    return barcode1;
  }

  Future _scanPath(String path) async {
    String barcode1 = await scanner.scanPath(path);
    this.barcode.text = barcode1;
  }

  Future _scanBytes() async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    Uint8List bytes = file.readAsBytesSync();
    String barcode1 = await scanner.scanBytes(bytes);
    this.barcode.text = barcode1;
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
}
