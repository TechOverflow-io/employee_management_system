import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String employeeId;
  final String firstName;
  final String lastName;
  final String dob;
  final String address;

  Employee({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.address,
  });

  factory Employee.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Employee(
      employeeId: snapshot['employeeId'],
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      dob: snapshot['dob'],
      address: snapshot['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "address": address,
      };
}
