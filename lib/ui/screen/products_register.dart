import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first_app/core/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/firestore_helper.dart';
import '../../core/utils/utils.dart';
import '../widgets/drawer_header.dart';

// ignore: must_be_immutable
class ProductsPage extends StatefulWidget {
  static const routeName = '/productsRegistration';
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() => this.image = File(image.path));
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  void inputClear() {
    productPriceController.clear();
    urlController.clear();
  }

  @override
  void dispose() {
    productPriceController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text("Products Registeration")),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formkey,
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
                  child: TextFormField(
                    controller: productNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Product Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: productPriceController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Product Price',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'URL',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter url.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[700])),
                      child: const Text('Add  Image'),
                      onPressed: () {
                        pickImage();
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                image == null
                    ? const SizedBox(
                        height: 10,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[700])),
                      child: const Text('Add New Product'),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          FirestoreHelper.createProduct(Product(
                            id: "",
                            name: productNameController.text.trim(),
                            price: int.parse(
                              productPriceController.text.trim(),
                            ),
                            img: image!.path,
                            url: urlController.text.toString(),
                          )).then((result) {
                            if (result == null) {
                              Utils.showSnackBar(
                                  "Register successfully", false);
                              inputClear();
                              image == null;
                            } else {
                              Utils.showSnackBar(result, true);
                            }
                          });
                        }
                      },
                    )),
              ],
            ),
          )),
      drawer: MyHeaderDrawer(),
    );
  }
}
