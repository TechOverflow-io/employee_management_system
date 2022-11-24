import 'package:flutter/material.dart';

import 'employees.dart';
import 'dashboard.dart';
import 'drawer_header.dart';
import 'products.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.employees;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.employees) {
      container = EmployeesPage();
    } else if (currentPage == DrawerSections.products) {
      container = ProductsPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Employee Management App"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget MyDrawerList() {
  return Container(
    padding: EdgeInsets.only(
      top: 15,
    ),
    child: Column(
      // shows the list of menu drawer
      children: [
        menuItem(1, "Dashboard", Icons.dashboard_outlined,
            currentPage == DrawerSections.dashboard ? true : false),
        menuItem(2, "Employee Registration", Icons.people_alt_outlined,
            currentPage == DrawerSections.employees ? true : false),
        menuItem(3, "Products", Icons.event,
            currentPage == DrawerSections.products ? true : false),
      ],
    ),
  );
}

Widget menuItem(int id, String title, IconData icon, bool selected) {
  return Material(
    color: selected ? Colors.grey[300] : Colors.transparent,
    child: InkWell(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          if (id == 1) {
            currentPage = DrawerSections.dashboard;
          } else if (id == 2) {
            currentPage = DrawerSections.employees;
          } else if (id == 3) {
            currentPage = DrawerSections.products;
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}


enum DrawerSections {
  dashboard,
  employees,
  products,
}
