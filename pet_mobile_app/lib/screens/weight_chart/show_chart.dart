import 'package:flutter/material.dart';
import 'package:pet_mobile_app/models/weight_model.dart';
import 'line_painter.dart';

class DrawChart extends StatefulWidget {
  final List<Weight> data;
  const DrawChart({Key? key, required this.data}) : super(key: key);

  @override
  _DrawChartState createState() => _DrawChartState();
}

class _DrawChartState extends State<DrawChart> {

  double min = double.maxFinite;
  double max = -double.maxFinite;
  double range = 1.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.data.forEach((d) {
        min = d.weightInKg.toDouble() < min ? d.weightInKg.toDouble() : min;
        max = d.weightInKg.toDouble() > max ? d.weightInKg.toDouble() : max;
      });
      range = max - min;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 1000,
          child: CustomPaint(
            foregroundPainter: LinePainter(widget.data, min, max, range),
          ),
        )

    );
  }
}