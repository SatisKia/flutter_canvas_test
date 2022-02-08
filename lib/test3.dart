import 'package:flutter/cupertino.dart';

import 'main.dart';

class Test3 {
  double contentWidth;
  double contentHeight;
  Test3(this.contentWidth, this.contentHeight);

  GlobalObjectKey hogehogeKey = const GlobalObjectKey('__HOGEHOGE_KEY__'); // 一意の値を渡す

  Widget build() {
    return SizedBox(
        key: hogehogeKey,
        width: contentWidth,
        height: contentHeight,
        child: MyRenderObjectWidget(HogehogeRenderBox(hogehogeKey))
    );
  }
}

class HogehogeRenderBox extends MyRenderBox {
  HogehogeRenderBox(GlobalObjectKey key) : super(key);

  int frameTime = 1000 ~/ 60/*フレーム*/;

  String str = 'Hello World !!';
  double w = 0.0;
  double h = 0.0;
  double x = 0.0;
  double y = 0.0;
  double dx = 0.0;
  double dy = 0.0;
  bool initFlag = true;

  @override
  void paintCanvas(Canvas c, Paint p) {
    int startTime = DateTime.now().millisecondsSinceEpoch;

    setFontSize(32.0);
    if( initFlag ) {
      w = stringWidth(str);
      h = 32;
      x = 0;
      y = h;
      dx = 10;
      dy = 5;
      initFlag = false;
    } else {
      x += dx;
      if( (x <= 0) || (x >= contentWidth - w) ){
        dx = -dx;
      }
      y += dy;
      if( (y <= h) || (y >= contentHeight) ){
        dy = -dy;
      }
      if( x < 0 ){
        x = 0;
      }
      if( x > contentWidth - w ){
        x = contentWidth - w;
      }
      if( y < h ){
        y = h;
      }
      if( y > contentHeight ){
        y = contentHeight;
      }
    }
    fillRect(c, p, 0, 0, contentWidth, contentHeight, color: Color.fromARGB(255, 192, 255, 255));
    drawString(c, str, x, y, contentWidth, color: Color.fromARGB(255, 255, 0, 0));

    int waitTime = frameTime - (DateTime.now().millisecondsSinceEpoch - startTime);
    if( waitTime < 0 ){
      waitTime = 0;
    }
    Future.delayed( Duration( milliseconds: waitTime ), (){ markNeedsPaint(); } );
  }
}
