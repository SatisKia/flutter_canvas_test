import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class MyRenderObjectWidget extends SingleChildRenderObjectWidget {
  final RenderBox renderBox;
  const MyRenderObjectWidget(this.renderBox, {Key? key}) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return renderBox;
  }
}

class MyRenderBox extends RenderBox {
  GlobalObjectKey key;
  MyRenderBox(this.key);

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    size = constraints.biggest;
  }

  // view上の描画領域
  double offsetX = 0.0;
  double offsetY = 0.0;
  double contentWidth  = 0.0;
  double contentHeight = 0.0;

  // 描画に使用する色
  Color color = Color(0xff000000);
  void setColor(Color color){
    this.color = color;
  }

  // 線幅
  double strokeWidth = 1.0;
  void setStrokeWidth(double width){
    strokeWidth = width;
  }

  // フォントサイズ
  double fontSize = 0.0;
  void setFontSize(double size){
    fontSize = size;
  }

  // クリッピング領域の設定
  void setClip(Canvas c, double x, double y, double width, double height){
    if( x + width > contentWidth ){
      width = contentWidth - x;
    }
    if( y + height > contentHeight ){
      width = contentHeight - y;
    }
    c.clipRect(Rect.fromLTWH(x, y, width, height));
  }

  // クリッピング領域の解除
  void clearClip(Canvas c){
    c.clipRect(Rect.fromLTWH(0, 0, contentWidth, contentHeight));
  }

  // 矩形の描画
  void drawRect(Canvas c, Paint p, double x, double y, double w, double h, {Color? color}){
    if( color != null ){
      this.color = color;
    }
    p.style = PaintingStyle.stroke;
    p.strokeWidth = strokeWidth;
    p.color = this.color;
    if (strokeWidth == 1.0) {
      c.drawRect(Rect.fromLTWH(x + 0.5, y + 0.5, w - 1, h - 1), p);
    } else {
      c.drawRect(Rect.fromLTWH(x, y, w, h), p);
    }
  }
  void fillRect(Canvas c, Paint p, double x, double y, double w, double h, {Color? color}) {
    if( color != null ){
      this.color = color;
    }
    p.style = PaintingStyle.fill;
    p.color = this.color;
    c.drawRect(Rect.fromLTWH(x, y, w, h), p);
  }

  // 楕円の描画
  void drawOval(Canvas c, Paint p, double x, double y, double w, double h, {Color? color}){
    if( color != null ){
      this.color = color;
    }
    p.style = PaintingStyle.stroke;
    p.strokeWidth = strokeWidth;
    p.color = this.color;
    if (strokeWidth == 1.0) {
      c.drawOval(Rect.fromLTWH(x + 0.5, y + 0.5, w - 1, h - 1), p);
    } else {
      c.drawOval(Rect.fromLTWH(x, y, w, h), p);
    }
  }
  void fillOval(Canvas c, Paint p, double x, double y, double w, double h, {Color? color}) {
    if( color != null ){
      this.color = color;
    }
    p.style = PaintingStyle.fill;
    p.color = this.color;
    c.drawOval(Rect.fromLTWH(x, y, w, h), p);
  }

  // 円の描画
  void drawCircle(Canvas c, Paint p, double cx, double cy, double r, {Color? color}){
    if( color != null ){
      this.color = color;
    }
    p.style = PaintingStyle.stroke;
    p.strokeWidth = strokeWidth;
    p.color = this.color;
    c.drawCircle(Offset(cx, cy), r, p);
  }
  void fillCircle(Canvas c, Paint p, double cx, double cy, double r, {Color? color}){
    if( color != null ){
      this.color = color;
    }
    p.style = PaintingStyle.fill;
    p.color = this.color;
    c.drawCircle(Offset(cx, cy), r, p);
  }

  // 直線の描画
  void drawLine(Canvas c, Paint p, double x1, double y1, double x2, double y2, {Color? color}){
    if( color != null ){
      this.color = color;
    }
    p.style = PaintingStyle.stroke;
    p.strokeWidth = strokeWidth;
    p.color = this.color;
    c.drawLine(Offset(x1, y1), Offset(x2, y2), p);
  }

  // イメージの構築
  Future<ui.Image?> createImage(String url) async {
    NetworkImage tmp = NetworkImage(url);
    Completer<ImageInfo> completer = Completer();
    ImageStream stream = tmp.resolve(ImageConfiguration());
    stream.addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info);
    }, onError: (error, _) {
      completer.completeError(error);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }
  Future<ui.Image> createImageFromAsset(String name) async {
    ByteData data = await rootBundle.load(name);
    Uint8List uint8list = Uint8List.view(data.buffer);
    ui.Codec codec = await ui.instantiateImageCodec(uint8list);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  // イメージの描画
  void drawImage(Canvas c, Paint p, ui.Image? image, double dx, double dy){
    if( image != null ){
      c.drawImage(image, Offset(dx, dy), p);
    }
  }
  void drawClippedImage(Canvas c, Paint p, ui.Image? image, double dx, double dy, double sx, double sy, double width, double height){
    if( image != null ){
      Rect src = Rect.fromLTWH(sx, sy, width, height);
      Rect dst = Rect.fromLTWH(dx, dy, width, height);
      c.drawImageRect(image, src, dst, p);
    }
  }
  void drawScaledImage(Canvas c, Paint p, ui.Image? image, double dx, double dy, double width, double height, double sx, double sy, double swidth, double sheight){
    if( image != null ){
      Rect src = Rect.fromLTWH(sx, sy, swidth, sheight);
      Rect dst = Rect.fromLTWH(dx, dy, width, height);
      c.drawImageRect(image, src, dst, p);
    }
  }

  // 文字列の幅を取得
  double stringWidth(String str, {double? fontSize}){
    if( fontSize != null ){
      this.fontSize = fontSize;
    }
    ui.ParagraphBuilder builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(textDirection: TextDirection.ltr)
    );
    builder.pushStyle(ui.TextStyle(fontSize: this.fontSize));
    builder.addText(str);
    ui.Paragraph paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: 0));
    return paragraph.maxIntrinsicWidth;
  }

  // 文字列の描画
  double drawString(Canvas c, String str, double x, double y, double width, {double? fontSize, Color? color}){
    if( fontSize != null ){
      this.fontSize = fontSize;
    }
    if( color != null ){
      this.color = color;
    }
    ui.ParagraphBuilder builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(textDirection: TextDirection.ltr)
    );
    builder.pushStyle(ui.TextStyle(fontSize: this.fontSize, color: this.color));
    builder.addText(str);
    ui.Paragraph paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: width));
    y -= this.fontSize;
    c.drawParagraph(paragraph, Offset(x, y));
    return paragraph.minIntrinsicWidth;
  }

  // オーバーライドする関数
  void paintCanvas(Canvas c, Paint p) {
    // 描画処理
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    offsetX = offset.dx;
    offsetY = offset.dy;
    contentWidth  = key.currentContext!.size!.width;
    contentHeight = key.currentContext!.size!.height;

    Canvas c = context.canvas;
    c.save();

    // 座標軸の移動
    c.translate(offsetX, offsetY);

    // クリッピング
    c.clipRect(Rect.fromLTWH(0, 0, contentWidth, contentHeight));

    paintCanvas(c, Paint());

    c.restore();
  }
}
