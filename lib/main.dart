import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String result = "Hey there !";

  Future _scanQR() async {
    List<Barcode> barcodes = [];
    try {
      barcodes = await FlutterMobileVision.scan(
        flash: false,
        autoFocus: true,
        formats: Barcode.ALL_FORMATS,
        multiple: false,
        showText: true,
        camera: FlutterMobileVision.CAMERA_BACK,
        fps: 30.0,
      );
      setState(() {
        result = barcodes[0].displayValue;
      });
    } on Exception {
      result = 'Failed to get barcode.';
      barcodes.add(new Barcode('Failed to get barcode.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
