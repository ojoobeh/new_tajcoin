import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:webazin/chart/pieChart/indicator.dart';
import 'package:webazin/chart/pieChart/pie_chart_sample2.dart';
import 'package:webazin/webazin/utilities.dart';

class PieChartSample extends StatefulWidget {
  PieChartSample({required this.list, super.key});

  List<PieChartModel> list;

  @override
  State<StatefulWidget> createState() => PieChart2State(list);
}

class PieChart2State extends State {
  int touchedIndex = -2;
  List<PieChartModel> list;

  PieChart2State(this.list);

  @override
  Widget build(final BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        height: 300,
        width: double.infinity,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (final FlTouchEvent event, final PieTouchResponse? pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(show: true),
            sectionsSpace: 0,
            centerSpaceRadius: 50,
            sections: showingSections(list),
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          width: 300,
          child: Center(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: list.length,
              itemBuilder: (context, index) => Indicator(
                color: Color(int.parse(list[index].color)),
                text: "${list[index].title} ${list[index].values}%",
                size: 24,
                fontSize: 16,
                textColor: context.theme.dividerColor,
                isSquare: true,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  // ignore: always_specify_types
  List<PieChartSectionData> showingSections(List<PieChartModel> list) => List.generate(list.length, (final int i) {
        final bool isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 16.0 : 14.0;
        final double radius = isTouched ? 70.0 : 50.0;

        PieChartModel data = list[i];
        return PieChartSectionData(
          color: Color(int.parse(data.color)),
          value: data.values,
          title: '${data.values}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      });
}

