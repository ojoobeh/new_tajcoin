import 'package:flutter/material.dart';
import 'package:webazin/chart/pieChart/pie_chart_sample.dart';
import 'package:webazin/chart/pieChart/pie_chart_sample2.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/dto/wallet.dart';
import 'package:webazin/webazin/utilities.dart';

class AssetsChart extends StatefulWidget {
  AssetsChart({required this.list, required this.balance, Key? key}) : super(key: key);
  List<DataWallet> list;
  double balance;

  @override
  State<AssetsChart> createState() => _AssetsChartState(list, balance);
}

class _AssetsChartState extends State<AssetsChart> {
  _AssetsChartState(this.list, this.balance);

  List<DataWallet> list;
  double balance;
  List<PieChartModel> listChartModel = [];

  @override
  void initState() {
    super.initState();
    getChart();
  }

  void getChart() {
    for (int i = 0; i < list.length; i++) {
      // for (int i = 0; i < 5; i++) {
      DataWallet model = list[i];
      if (model.balanceFree! > 0 && (model.currency?.symbol ?? '') != 'IRT') {
        double totalPrice = (model.balanceFree ?? 0.0) * (model.currency?.price ?? 0);
        double p = (100 / (balance / totalPrice));

        PieChartModel pieChartModel = PieChartModel(
          values: double.parse(p.toStringAsFixed(Core.pieChartHomeDecimalLimit)),
          color: model.currency?.color ?? '',
          title: model.currency!.symbol ?? '',
        );
        listChartModel.add(pieChartModel);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: PieChartSample(list: listChartModel),
    );
  }
}
