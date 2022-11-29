import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/auth/authentication.dart';
import '../widgets/bar_chart.dart';

class EmployeePerformance extends StatefulWidget {
  const EmployeePerformance({super.key});
  static const routeName = '/employeePerformance';

  @override
  State<EmployeePerformance> createState() => _EmployeePerformanceState();
}

class _EmployeePerformanceState extends State<EmployeePerformance> {
  String formattedDate = DateFormat.MMMd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store Sale"),
        actions: [
          // Creating a icon button
          IconButton(
            iconSize: 20,
            icon: const Icon(
              Icons.power_settings_new,
            ),
            // the method which is called
            // when button is pressed
            onPressed: () {
              setState(
                () {
                  AuthenticationHelper().signOut(context);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text("$formattedDate Net Seles"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '\$1,717',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox.fromSize(
                size: Size.fromHeight(MediaQuery.of(context).size.height * 0.4),
                child: const BarChartSample3(),
              ),
              const Text("Your sales rank with your department"),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Per Period Sales"),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '\$3,735',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Last Year \$0"),
              const Divider(
                thickness: 2,
              ),
              const Text("Year to Date Sale"),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '\$4,554',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Last Year \$0"),
              const Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
