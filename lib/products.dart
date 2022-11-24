import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {

  TextEditingController productPriceController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Products Details',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Please fill all details to register products',
                  style: TextStyle(fontSize: 16),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: productImageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product Image',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: productPriceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product Price',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'URL',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(' ',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green[700])
                  ),
                  child: const Text('Add New Product'),
                  onPressed: () {
                    print(productPriceController.text);
                    print(passwordController.text);
                  },
                )
            ),
          ],
        ));
  }
}


