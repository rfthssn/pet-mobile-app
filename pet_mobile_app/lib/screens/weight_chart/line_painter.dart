import 'package:flutter/material.dart';
import 'package:pet_mobile_app/models/weight_model.dart';

class LinePainter extends CustomPainter{
  final List<Weight> data;
  final double minD;
  final double maxD;
  final double rangeD;
  LinePainter(this.data, this.minD, this.maxD, this.rangeD);


  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white;
    canvas.drawPaint(paint);
    var center = Offset(size.width / 2, size.height / 2);
    drawFrame(canvas, center);
    drawChart(canvas, center);
  }

  var W = 1000.0;
  void drawFrame(Canvas canvas, Offset center) {
    var rect = Rect.fromCenter(center: center, width: W, height: 400);
    var bg = Paint()..color = Color(0xfff2f3f0);
    canvas.drawRect(rect, bg);

  }

  var chartW = 900.0;
  var chartH = 150.0;
  void drawChart(Canvas canvas, Offset center) {
    var rect = Rect.fromCenter(center: center, width: chartW, height: chartH);
    var chBorder = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    var dpPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;


    var labelStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    drawChartGuides(canvas, chBorder, rect);
    drawLabels(canvas, rect, labelStyle);
    drawDataPoints(canvas, dpPaint, rect);
  }

  void drawChartBorder(Canvas canvas, Paint chBorder, Rect rect) {
    canvas.drawRect(rect, chBorder);
  }


  void drawChartGuides(Canvas canvas, Paint chBorder, Rect rect) {
    var x = rect.left;
    var colW = chartW /data.length;
    for (var i = 0; i < data.length; i++) {
      var p1 = Offset(x, rect.bottom);
      var p2 = Offset(x, rect.top);
      canvas.drawLine(p1, p2, chBorder);
      x += colW;
    }

    var yD = chartH / 2.0;
    canvas.drawLine(Offset(rect.left, rect.bottom - yD),
        Offset(rect.right, rect.bottom - yD), chBorder);
  }

  void drawDataPoints(Canvas canvas, dpPaint, Rect rect) {
    if (data == null) return;
    var yRatio = chartH / rangeD;
    var colW = chartW / data.length;
    var p = Path();
    var x = rect.left;
    bool first = true;
    data.forEach((d) {
      var y = (d.weightInKg - minD) * yRatio;
      if (first) {
        p.moveTo(x, rect.bottom - y);
        first = false;
      } else {
        p.lineTo(x, rect.bottom - y);
      }
      canvas.drawCircle(Offset(x, rect.bottom - y), 5.0,dpPaint);
      x += colW;

    });

    p.moveTo(x - colW, rect.bottom);
    p.moveTo(rect.left, rect.bottom);
    canvas.drawPath(p, dpPaint);

  }

  drawText(Canvas canvas, Offset position, double width, TextStyle style,
      String text) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter =
    TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: width*2);
    textPainter.paint(canvas, position);
  }

  void drawLabels(Canvas canvas, Rect rect, TextStyle labelStyle) {
    final xLabel = data.map((e) =>  "${DateTime.parse(e.date).month.toString() + "."+ DateTime.parse(e.date).year.toString().substring(2,4)}").toList();
    var colW = chartW / data.length;

    var x = rect.left;
    for (var i = 0; i < data.length; i++) {
      drawText(canvas, Offset(x, rect.bottom + 15), 20, labelStyle, xLabel[i]);
      x += colW;
    }

    drawText(canvas, rect.bottomLeft + Offset(-35, -10), 40, labelStyle,
        minD.toStringAsFixed(0));
    drawText(canvas, rect.topLeft + Offset(-35, 0), 40, labelStyle,
        maxD.toStringAsFixed(0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}