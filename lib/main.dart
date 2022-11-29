import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/core/utils/utils.dart';
import 'ui/screen/employee_list_page.dart';
import 'ui/screen/employee_performance_page.dart';
import 'ui/screen/employees_register_page.dart';
import 'ui/screen/home_page.dart';
import 'ui/screen/login_page.dart';
import 'ui/screen/products_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final nivegatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: Utils.messengerkey,
        navigatorKey: nivegatorkey,
        routes: {
          EmployeeList.routeName: (context) => const EmployeeList(),
          EmployeePerformance.routeName: (context) =>
              const EmployeePerformance(),
          // EmployeeProfile.routeName: (context) =>  EmployeeProfile(employee: Employee(),),
          EmployeesPage.routeName: (context) => const EmployeesPage(),
          HomePage.routeName: (context) => const HomePage(),
          ProductsPage.routeName: (context) => const ProductsPage(),
        },
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else if (snapshot.data?.email == "admin123@gmail.com") {
              return const HomePage();
            } else if (snapshot.data?.email != "admin123@gmail.com") {
              return const EmployeePerformance();
            } else {
              return const LoginPage();
            }
          }),
        ));
  }
}
