import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:pet_mobile_app/models/weight_model.dart';

class ShowChart extends StatelessWidget {
  final List<Weight> data;
  ShowChart({required this.data});

  static List<charts.Series<Weight, DateTime>> _createSampleData(dataAPI) {
    return [
      new charts.Series<Weight, DateTime>(
        id: 'timeSeriesChart',
        colorFn: (Weight weight, _) =>
        charts.MaterialPalette.green.shadeDefault,
        domainFn: (Weight weight, _) => DateTime.parse(weight.date) ,
        measureFn: (Weight weight, _) => weight.weightInKg,
        data: dataAPI,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 1000,
        child: charts.TimeSeriesChart(
          _createSampleData(data),
          defaultRenderer:
          new charts.LineRendererConfig(includePoints: true),
          animate: true,
          behaviors: [
            charts.SlidingViewport(),
          ],
        ),
      )

    );
  }
}