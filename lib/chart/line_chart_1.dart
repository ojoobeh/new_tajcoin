import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/pages/trader/controllers/trade_controller.dart';

//GetView<TradeController>

class LineChartSample extends GetView<TradeController> {
  const LineChartSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 2,
        child: LineChart(
          mainData(),
        ),
      );

  Widget bottomTitleWidgets(final double value, final TitleMeta meta) {
    const TextStyle style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );
    return Container();
    // return SideTitleWidget(
    //   axisSide: meta.axisSide,
    //   // child: Text('${(value+1).toStringAsFixed(0)}', style: style),
    //   child: Text('', style: style),
    // );
  }

  LineChartData mainData() => LineChartData(
        gridData: FlGridData(
          show: false,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (final double value) => FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          ),
          getDrawingVerticalLine: (final double value) => FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              interval: 1,
              getTitlesWidget: (value, meta) => Container(),
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        minX: 0,
        maxX: controller.list.length - 1,
        minY: controller.min,
        maxY: controller.max,
        lineBarsData: <LineChartBarData>[
          LineChartBarData(
            spots: controller.list.value,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xffffb246),
                const Color(0xffffb246),
                const Color(0xffffb246),
              ],
            ),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            // belowBarData: BarAreaData(
            //   show: true,
            //   gradient: LinearGradient(
            //     colors: [
            //       const Color(0x00f5f3ed),
            //       const Color(0x00fce19e),
            //       const Color(0x008c8152),
            //     ].map((final Color color) => color.withOpacity(0.3)).toList(),
            //   ),
            // ),
          ),
        ],
      );

}
