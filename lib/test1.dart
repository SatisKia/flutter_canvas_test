import 'package:flutter/cupertino.dart';

import 'main.dart';

class Test1 {
  double contentWidth;
  double contentHeight;
  Test1(this.contentWidth, this.contentHeight);

  GlobalObjectKey hogeKey = const GlobalObjectKey('__HOGE_KEY__'); // 一意の値を渡す
  GlobalObjectKey fugaKey = const GlobalObjectKey('__FUGA_KEY__'); // 一意の値を渡す
  GlobalObjectKey piyoKey = const GlobalObjectKey('__PIYO_KEY__'); // 一意の値を渡す

  Widget build(){
    return Column( children: [
      SizedBox( height: 20 ),
      Row( children: [
        SizedBox( width: 20 ),
        SizedBox(
            key: hogeKey,
            width: contentWidth - 20 - 20,
            height: 300,
            child: MyRenderObjectWidget(HogeRenderBox(hogeKey))
        ),
      ] ),
      SizedBox( height: 20 ),
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox( width: 20 ),
            SizedBox(
                key: fugaKey,
                width: 200,
                height: 200,
                child: MyRenderObjectWidget(FugaRenderBox(fugaKey))
            ),
            SizedBox( width: 20 ),
            SizedBox(
                key: piyoKey,
                width: contentWidth - 20 - 200 - 20 - 20,
                height: contentWidth - 20 - 200 - 20 - 20 - 10,
                child: MyRenderObjectWidget(PiyoRenderBox(piyoKey))
            ),
          ] ),
    ] );
  }
}

class HogeRenderBox extends MyRenderBox {
  HogeRenderBox(GlobalObjectKey key) : super(key);

  @override
  void paintCanvas(Canvas c, Paint p) {
    fillRect(c, p, 0, 0, contentWidth, contentHeight, color: Color.fromARGB(128, 0, 255, 255));
    setFontSize(24.0);
    String str = offsetX.toInt().toString() + "," + offsetY.toInt().toString();
    drawString(c, str, 0, 24, contentWidth, color: Color.fromARGB(255, 255, 0, 0));
    str = contentWidth.toInt().toString() + "," + contentHeight.toInt().toString();
    drawString(c, str, 0, 48, contentWidth, color: Color.fromARGB(255, 255, 0, 0));
  }
}

class FugaRenderBox extends MyRenderBox {
  FugaRenderBox(GlobalObjectKey key) : super(key);

  @override
  void paintCanvas(Canvas c, Paint p) {
    fillRect(c, p, 0, 0, contentWidth, contentHeight, color: Color.fromARGB(128, 255, 0, 255));
    setFontSize(24.0);
    String str = offsetX.toInt().toString() + "," + offsetY.toInt().toString();
    drawString(c, str, 0, 24, contentWidth, color: Color.fromARGB(255, 255, 0, 0));
    str = contentWidth.toInt().toString() + "," + contentHeight.toInt().toString();
    drawString(c, str, 0, 48, contentWidth, color: Color.fromARGB(255, 255, 0, 0));
  }
}

class PiyoRenderBox extends MyRenderBox {
  PiyoRenderBox(GlobalObjectKey key) : super(key);

  @override
  void paintCanvas(Canvas c, Paint p) {
    fillRect(c, p, 0, 0, contentWidth, contentHeight, color: Color.fromARGB(128, 255, 255, 0));
    setFontSize(24.0);
    String str = offsetX.toInt().toString() + "," + offsetY.toInt().toString();
    drawString(c, str, 0, 24, contentWidth, color: Color.fromARGB(255, 255, 0, 0));
    str = contentWidth.toInt().toString() + "," + contentHeight.toInt().toString();
    drawString(c, str, 0, 48, contentWidth, color: Color.fromARGB(255, 255, 0, 0));
  }
}
