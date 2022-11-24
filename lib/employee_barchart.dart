import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:sliver_bar_chart/sliver_bar_chart.dart';

class EmployeeChart extends StatefulWidget {
  const EmployeeChart({super.key});

  @override
  State<EmployeeChart> createState() => _EmployeeChartState();
}

class _EmployeeChartState extends State<EmployeeChart>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final List<BarChartData> _barValues;

  final double _minHeight = AppBar().preferredSize.height;
  final double _xAxisTextRotationAngle = 180.0;
  final int _yAxisIntervalCount = 8;
  double _maxHeight = 500.0;
  double _maxWidth = 10.0;

  final bool _restrain = true;
  final bool _fluctuating = false;
  bool _isScrolling = true;

  final int _sliverListChildCount = 20;

  @override
  void initState() {
    super.initState();
    _setupBarChartValues();

    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset.roundToDouble() < 100.0) {
          _maxHeight = 500.0;
          _maxWidth = 10.0;
          _isScrolling = false;
        } else {
          if (_scrollController.offset.roundToDouble() >= 400.0) {
            _maxWidth = _scrollController.offset - 10;
          }
          _isScrolling = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text("Employee performance")),
      body: Padding(
        padding: const EdgeInsets.all(8.0).add(const EdgeInsets.only(top: 10)),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4,
                shadowColor: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Employee ID"),
                        Text("F2018065117")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text("First Name"), Text("Ahmad")],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text("Last  Name"), Text("Raza")],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
              ),
            ),
            Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              shadowColor: Colors.green,
              child: SizedBox(
                height: 200,
                width: 200,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverBarChart(
                      restrain: _restrain,
                      fluctuating: _fluctuating,
                      minHeight: _minHeight,
                      maxHeight: _maxHeight,
                      maxWidth: _maxWidth,
                      barWidget: BarChartWidget(
                        maxHeight: _maxHeight,
                        minHeight: _minHeight,
                        barValues: _barValues,
                        isScrolling: _isScrolling,
                        yAxisIntervalCount: _yAxisIntervalCount,
                        xAxisTextRotationAngle: _xAxisTextRotationAngle,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext _, int index) => Container(
                          color: index.isOdd ? Colors.white : Colors.black12,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '$index',
                                textScaleFactor: 3.0,
                              ),
                            ),
                          ),
                        ),
                        childCount: _sliverListChildCount,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _setupBarChartValues() {
    _barValues = [
      BarChartData(
        x: '2014',
        y: 500.0,
        barColor: Colors.blue,
      ),
      BarChartData(
        x: '2015',
        y: 800.0,
        barColor: Colors.blue,
      ),
      BarChartData(
        x: '2016',
        y: 600.0,
        barColor: Colors.blue,
      ),
      BarChartData(
        x: '2017',
        y: 900.0,
        barColor: Colors.blue,
      ),
      BarChartData(
        x: '2018',
        y: 1000.0,
        barColor: Colors.blue,
      ),
      BarChartData(
        x: '2019',
        y: 700.0,
        barColor: Colors.blue,
      ),
      BarChartData(
        x: '2020',
        y: 500.0,
        barColor: Colors.blue,
      ),
      BarChartData(
        x: '2021',
        y: 300.0,
        barColor: Colors.blue,
      ),
    ];
  }
}
