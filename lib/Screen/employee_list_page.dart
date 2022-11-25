import 'package:flutter/material.dart';
import 'package:flutter_first_app/Screen/employee_profile_page.dart';
import '../widgets/drawer_header.dart';

class EmployeeList extends StatefulWidget {
  static const routeName = '/employeeList';
  const EmployeeList({super.key});
  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final List<String> items = List<String>.generate(30, (i) => '$i');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text("Employee List")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[700],
              child: Text(items[index]),
            ),
            title: Text('Employee ${items[index]}'),
            subtitle: const Text('Employee details'),
            onTap: () {
              Navigator.of(context).pushNamed(EmployeeProfile.routeName);
            },
          );
        },
      ),
      drawer: const MyHeaderDrawer(),
    );
  }
}
