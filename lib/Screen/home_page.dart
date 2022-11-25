import 'package:flutter/material.dart';

import '../widgets/drawer_header.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[700], title: const Text("Home Page")),
      body: const Center(
        child: Text("Home Page"),
      ),
      drawer: const MyHeaderDrawer(),
    );
  }
}
