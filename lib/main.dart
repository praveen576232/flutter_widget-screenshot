import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Screenshot Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Screenshot Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List uint8list;
  GlobalKey _containerKey = GlobalKey();
  void takescreenshot() async {
    RenderRepaintBoundary renderRepaintBoundary =
        _containerKey.currentContext.findRenderObject();
    ui.Image boximage = await renderRepaintBoundary.toImage(pixelRatio: 1);
    ByteData byteData =
        await boximage.toByteData(format: ui.ImageByteFormat.png);
    setState(() {
      uint8list = byteData.buffer.asUint8List();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RepaintBoundary(
              key: _containerKey,
              child: Container(
                height: 300,
                width: 300,
                color: Colors.amber,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "payment done",
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      "96",
                      style: TextStyle(fontSize: 60, color: Colors.blue),
                    )
                  ],
                )),
              ),
            ),SizedBox(height: 30,),
            uint8list != null ? Image.memory(uint8list) : Offstage()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: takescreenshot,
        tooltip: 'Increment',
        child: Icon(Icons.screen_share_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
