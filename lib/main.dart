import 'package:flutter/material.dart';
import 'Screen/employee_list_page.dart';
import 'Screen/employee_performance_page.dart';
import 'Screen/employee_profile_page.dart';
import 'Screen/employees_register_page.dart';
import 'Screen/home_page.dart';
import 'Screen/login_page.dart';
import 'Screen/products_register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        EmployeeList.routeName: (context) => const EmployeeList(),
        EmployeePerformance.routeName: (context) => const EmployeePerformance(),
        EmployeeProfile.routeName: (context) => const EmployeeProfile(),
        EmployeesPage.routeName: (context) => const EmployeesPage(),
        HomePage.routeName: (context) => const HomePage(),
        ProductsPage.routeName: (context) => const ProductsPage(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
