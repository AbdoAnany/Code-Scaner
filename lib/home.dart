import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'package:scan/add.dart';
import 'package:scan/appTheme.dart';

class Home extends StatefulWidget {
  @override
  _HomeeState createState() => _HomeeState();
}

class _HomeeState extends State<Home> {
  var save, list = [], save1 = [], val, fav;
  final url = 'https://morning-bayou-24260.herokuapp.com/get';
  TextEditingController _inputController;
  Uint8List bytes = Uint8List(0);
  Path path = Path();
  String mess, bar, search_by = 'name';

  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    val = true;
    fav = false;
    mess = "Welcome In Open Casher ^_^ ";
  }

  Future<List> getData() async {
    mess = '0';
    http.Response response = await http
        .get(url + "/$search_by/${_inputController.text}")
        .then((response) {
      save = response.body;
    });
    if (save == null) {
      mess = "Welcome In Open Casher ^_^ ";
    }
    if (save == "Not Found") {
      save1.clear();
      mess = "Not Found";
    } else {
      save1 = json.decode(save);
    }
    return save1;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(right: 5, top: 10, bottom: 10, left: 5),
                    height: 75,
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
                            child: Container(
                          height: 50,
                          width: w * .7,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextField(
                            controller: this._inputController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.go,
                            onSubmitted: (value) {
                              setState(() {
                                getData();
                              });
                            },
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
                        Positioned(
                          left: w * .79,
                          child: Tooltip(
                            message: "Scan By Camera",
                            child: Container(
                              width: 30,
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () => _scanPhoto(),
                                icon: Icon(
                                  Icons.camera,
                                  size: w * .06,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          width: 50,
                          left: w * .88,
                          child: Tooltip(
                            message: "Scan from  Gallery",
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                              ),
                              child: IconButton(
                                onPressed: () => _scanPhoto(),
                                icon: Icon(
                                  Icons.image,
                                  size: w * .06,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Menu(),
                ],
              ),
              Container(
                height: h,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: FutureBuilder<List>(
                    future: getData(),
                    builder: (context1, snapshot) {
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
                          : mess == ""
                              ? Container(
                                  alignment: Alignment.topCenter,
                                  height: 50,
                                  child: CupertinoActivityIndicator(
                                    animating: true,
                                    radius: 30,
                                  ))
                              : Container(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 100,
                                    child: Tooltip(
                                      message: "Add New Product in System",
                                      child: FloatingActionButton.extended(
                                        backgroundColor: Colors.transparent,
                                        icon: const Icon(Icons.add),
                                        label: Text(
                                          " The Product Not Found\n If You Want Add It ! Click",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Add_Product()));
                                        },
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: AppTheme.mix9)),
                                  ),
                                );
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: AppTheme.test,
        focusColor: AppTheme.test,
        onPressed: () => _scanBytes(),
        tooltip: 'Take a Photo',
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget CommentItem(prouduct) {
    var z = DateTime.parse(prouduct['date']);
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(5, 10)),
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppTheme.mix9),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Name : " + prouduct["name"].toString(),
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.white),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Price : " + prouduct["price"].toString() + " LE",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white),
                    textAlign: TextAlign.start,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 15,
                      color: fav ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        fav = !fav;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Last Update  " + DateFormat.yMEd().format(z),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.white),
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
        "Search By : $search_by",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        onSelected: (value) {
          setState(() {
            search_by = value;
          });
        },
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: "name",
            child: ListTile(
              leading:
                  const Icon(Icons.art_track, size: 30, color: AppTheme.a2),
              title: Text("Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          PopupMenuItem<String>(
            value: "price",
            child: ListTile(
              leading: const Icon(Icons.attach_money,
                  size: 30, color: Colors.yellow),
              title: Text("Price",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          PopupMenuItem<String>(
            value: "barcode",
            child: ListTile(
              leading: const Icon(
                Icons.qr_code,
                size: 30,
                color: AppTheme.black,
              ),
              title: Text("Barcode",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ],
      ),
    );
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
    this._inputController.text = barcode;
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

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.cubicTo(sw / 12, 0, sw / 12, 2 * sh / 5, 2 * sw / 12, 2 * sh / 5);
    path.cubicTo(3 * sw / 12, 2 * sh / 5, 3 * sw / 12, 0, 4 * sw / 12, 0);
    path.cubicTo(
        5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.cubicTo(
        9 * sw / 12, 0, 9 * sw / 12, 2 * sh / 5, 10 * sw / 12, 2 * sh / 5);
    path.cubicTo(11 * sw / 12, 2 * sh / 5, 11 * sw / 12, 0, sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
