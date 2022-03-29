import 'package:flutter/material.dart';

import 'test1.dart';
import 'test2.dart';
import 'test3.dart';

const int rectTest   = 0;
const int ovalTest   = 1;
const int circleTest = 2;
const int lineTest   = 3;
const int imageTest  = 4;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  double contentWidth  = 0.0;
  double contentHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height - MediaQuery.of( context ).padding.top - MediaQuery.of( context ).padding.bottom;

    Widget body = Test1(contentWidth, contentHeight).build();
//    Widget body = Test2(contentWidth, contentHeight, rectTest).build();
//    Widget body = Test2(contentWidth, contentHeight, ovalTest).build();
//    Widget body = Test2(contentWidth, contentHeight, circleTest).build();
//    Widget body = Test2(contentWidth, contentHeight, lineTest).build();
//    Widget body = Test2(contentWidth, contentHeight, imageTest).build();
//    Widget body = Test3(contentWidth, contentHeight).build();

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 0
        ),
        body: body
    );
  }
}
