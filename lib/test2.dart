import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'widget.dart';

class Test2 {
  double contentWidth;
  double contentHeight;
  int test;
  Test2(this.contentWidth, this.contentHeight, this.test);

  GlobalObjectKey hogeraKey = const GlobalObjectKey('__HOGERA_KEY__'); // 一意の値を渡す

  Widget build() {
    return SizedBox(
        key: hogeraKey,
        width: contentWidth,
        height: contentHeight,
        child: MyRenderObjectWidget(HogeraRenderBox(hogeraKey, test))
    );
  }
}

class HogeraRenderBox extends MyRenderBox {
  int test;
  HogeraRenderBox(GlobalObjectKey key, this.test) : super(key) {
    // イメージの構築
    _createImage();
  }

  // イメージの構築
  ui.Image? image1;
  ui.Image? image2;
  void _createImage() async {
    createImageFromAsset('assets/test.jpg').then((image){
      image1 = image;
      markNeedsPaint(); // paint要求
    });

    try {
      createImage("http://www5d.biglobe.ne.jp/~satis/flutter_test.jpg").then((image){
        image2 = image;
        markNeedsPaint(); // paint要求
      });
    } catch(e){
    }
  }

  @override
  void paintCanvas(Canvas c, Paint p) {
    setStrokeWidth(20.0);

    double x = 50;
    double y = 50;
    double w = 200;
    double h = 150;

    switch( test ){
      case rectTest: // 矩形
        drawRect(c, p, x, y, w, h, color: Color.fromARGB(255, 255, 255, 0));
        fillRect(c, p, x, y, w, h, color: Color.fromARGB(128, 160, 160, 160));
        setStrokeWidth(1.0);
        drawRect(c, p, x, y, w, h, color: Color.fromARGB(255, 255, 0, 0));
        break;
      case ovalTest: // 楕円
        drawOval(c, p, x, y, w, h, color: Color.fromARGB(255, 255, 255, 0));
        fillOval(c, p, x, y, w, h, color: Color.fromARGB(128, 160, 160, 160));
        setStrokeWidth(1.0);
        drawRect(c, p, x, y, w, h, color: Color.fromARGB(255, 255, 0, 0));
        break;
      case circleTest: // 円
        double r = w / 2;
        drawCircle(c, p, x + r, y + r, r, color: Color.fromARGB(255, 255, 255, 0));
        fillCircle(c, p, x + r, y + r, r, color: Color.fromARGB(128, 160, 160, 160));
        setStrokeWidth(1.0);
        drawLine(c, p, x + r, y + r, x + w, y + r, color: Color.fromARGB(255, 255, 0, 0));
        break;
      case lineTest: // 直線
        drawLine(c, p, x, y + h, x + w, y, color: Color.fromARGB(255, 255, 255, 0));
        fillRect(c, p, x, y, w, h, color: Color.fromARGB(128, 160, 160, 160));
        setStrokeWidth(1.0);
        drawLine(c, p, x, y + h, x + w, y, color: Color.fromARGB(255, 255, 0, 0));
        break;
      case imageTest: // イメージ
        double width = contentWidth / 2;
        drawImage(c, p, image1, 0, width);
        if( image1 != null ){
          drawClippedImage(c, p, image1, 0, 0, 100, 100, width, width);
        }
        if( image2 != null ){
          double swidth  = image2!.width.toDouble();
          double sheight = image2!.height.toDouble();
          drawScaledImage(c, p, image2, width, 0, width, width, 0, 0, swidth, sheight);
        }
        break;
    }
  }
}
