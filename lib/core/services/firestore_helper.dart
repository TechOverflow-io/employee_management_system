import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import '../models/product_model.dart';

class FirestoreHelper with ChangeNotifier {
  static Future<String?> createProduct(Product product) async {
    final userCollection = FirebaseFirestore.instance.collection("product");

    final uid = userCollection.doc().id;
    final docRef = userCollection.doc(uid);
    final newProdect = Product(
      id: uid,
      name: product.name,
      price: product.price,
      url: product.url,
      img: product.img,
    ).toJson();

    try {
      await docRef.set(newProdect);
      return null;
    } catch (e) {
      return "Some error occured $e";
    }
  }

  static Future<String?> registerEmployee(Employee employee) async {
    final userCollection = FirebaseFirestore.instance.collection("employee");

    final uid = userCollection.doc().id;
    final docRef = userCollection.doc(uid);

    final newEmployee = Employee(
      employeeId: employee.employeeId,
      firstName: employee.firstName,
      lastName: employee.lastName,
      dob: employee.dob,
      address: employee.address,
    ).toJson();

    try {
      await docRef.set(newEmployee);
      return null;
    } catch (e) {
      return "Some error occured $e";
    }
  }

  static Stream<List<Product>> readProduct() {
    final userCollection = FirebaseFirestore.instance.collection("product");
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => Product.fromSnapshot(e)).toList());
  }

  static Stream<List<Employee>> readEmployee() {
    final userCollection = FirebaseFirestore.instance.collection("employee");
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => Employee.fromSnapshot(e)).toList());
  }
}
