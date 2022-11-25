import 'package:flutter/material.dart';
import 'package:flutter_first_app/Screen/employee_list_page.dart';
import 'package:flutter_first_app/Screen/home_page.dart';
import 'package:flutter_first_app/Screen/login_page.dart';
import 'package:flutter_first_app/Screen/products_register.dart';
import '../Screen/employees_register_page.dart';

class MyHeaderDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  const MyHeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 185,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 300,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.green,
            child: const Text(
              'Coming Soon !',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile('Home', Icons.home, () {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          }),
          buildListTile('Employee Register', Icons.person, () {
            Navigator.of(context).pushReplacementNamed(EmployeesPage.routeName);
          }),
          buildListTile('Employee List', Icons.people, () {
            Navigator.of(context).pushReplacementNamed(EmployeeList.routeName);
          }),
          buildListTile('Product Register', Icons.production_quantity_limits,
              () {
            Navigator.of(context).pushReplacementNamed(ProductsPage.routeName);
          }),
          buildListTile('Logout', Icons.logout, () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          }),
        ],
      ),
    );
  }
}
