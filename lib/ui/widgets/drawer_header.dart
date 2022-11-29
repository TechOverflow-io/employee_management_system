// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_first_app/ui/screen/employee_list_page.dart';
import 'package:flutter_first_app/ui/screen/home_page.dart';
import 'package:flutter_first_app/ui/screen/products_register.dart';
import '../../core/auth/authentication.dart';
import '../screen/employees_register_page.dart';

// ignore: must_be_immutable
class MyHeaderDrawer extends StatelessWidget {
  var size, height, width;
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

  MyHeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Drawer(
      width: 185,
      child: Column(
        children: [
          Container(
            height: height * 0.3,
            width: width * 0.6,
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
          SizedBox(
            height: height * 0.02,
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
            AuthenticationHelper().signOut(context);
          }),
        ],
      ),
    );
  }
}
