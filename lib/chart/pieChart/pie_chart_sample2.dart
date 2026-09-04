import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:webazin/chart/pieChart/indicator.dart';
import 'package:webazin/webazin/utilities.dart';

class PieChartSample2 extends StatefulWidget {
  PieChartSample2({required this.list, super.key});

  List<PieChartModel> list;

  @override
  State<StatefulWidget> createState() => PieChart2State(list);
}

class PieChart2State extends State {
  int touchedIndex = -2;
  List<PieChartModel> list;

  PieChart2State(this.list);

  @override
  Widget build(final BuildContext context) => AspectRatio(
        aspectRatio: 1.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.7,
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
                  centerSpaceRadius: 20,
                  sections: showingSections(list),
                ),
              ),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: 100,
              child: Center(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  itemBuilder: (context, index) => Indicator(
                    color: Color(int.parse(list[index].color)),
                    text: list[index].title,
                    textColor: context.theme.dividerColor,
                    isSquare: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  // ignore: always_specify_types
  List<PieChartSectionData> showingSections(List<PieChartModel> list) => List.generate(list.length, (final int i) {
        final bool isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 14.0 : 10.0;
        final double radius = isTouched ? 35.0 : 25.0;

        PieChartModel data = list[i];
        return PieChartSectionData(
          color: Color(int.parse(data.color)),
          value: data.values,
          title: '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      });
}

class PieChartModel {
  PieChartModel({required this.values, required this.title, required this.color});

  double values;
  String title;
  String color;
}
