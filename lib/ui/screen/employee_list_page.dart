import 'package:flutter/material.dart';
import 'package:flutter_first_app/ui/screen/employee_profile_page.dart';
import '../../core/models/employee_model.dart';
import '../../core/services/firestore_helper.dart';
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
      body: StreamBuilder<List<Employee>>(
          stream: FirestoreHelper.readEmployee(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("some error occured"),
              );
            }
            if (snapshot.hasData) {
              final userData = snapshot.data;

              return ListView.builder(
                itemCount: userData!.length,
                itemBuilder: (context, index) {
                  final singleUser = userData[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[700],
                      child: Text(singleUser.firstName[0]),
                    ),
                    title:
                        Text("${singleUser.firstName}${singleUser.lastName}"),
                    subtitle: Text(singleUser.address),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployeeProfile(
                                  employee: Employee(
                                    employeeId: singleUser.employeeId,
                                    firstName: singleUser.firstName,
                                    lastName: singleUser.lastName,
                                    address: singleUser.address,
                                    dob: singleUser.dob,
                                  ),
                                )),
                      );
                    },
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      drawer: MyHeaderDrawer(),
    );
  }
}
