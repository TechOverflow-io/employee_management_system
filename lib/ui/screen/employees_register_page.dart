import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/core/models/employee_model.dart';
import 'package:intl/intl.dart';
import '../../core/auth/authentication.dart';
import '../../core/services/firestore_helper.dart';
import '../../core/utils/utils.dart';
import '../widgets/drawer_header.dart';

// ignore: must_be_immutable
class EmployeesPage extends StatefulWidget {
  static const routeName = '/employeeRegistration';
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController employeeIDController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  void inputClear() {
    firstNameController.clear();
    lastNameController.clear();
    employeeIDController.clear();
    addressController.clear();
    emailController.clear();
    dateinput.clear();
    passwordController.clear();
  }

  void textform() {
    firstNameController.text = "";
    lastNameController.text = "";
    employeeIDController.text = "";
    addressController.text = "";
    emailController.text = "";
    dateinput.text = "";
    passwordController.text = "";
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    employeeIDController.dispose();
    addressController.dispose();
    emailController.dispose();
    dateinput.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text("Employee Registeration")),
      body: Form(
        key: _formkey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Employee Details',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Please fill all details to register Employees',
                      style: TextStyle(fontSize: 16),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: employeeIDController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Employee ID',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter employee id.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextFormField(
                    cursorColor: Colors.green,
                    controller: dateinput,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter date.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.green,
                        ),
                        labelText: "Enter Date of Birth",
                        labelStyle: TextStyle(
                          color: Colors.green,
                        )),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary:
                                      Colors.green, // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface: Colors.green, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(),
                                ),
                              ),
                              child: child!,
                            );
                          },
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        // ignore: avoid_print
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        // ignore: avoid_print
                        print(formattedDate);
                        setState(() {
                          dateinput.text = formattedDate;
                        });
                      } else {
                        // ignore: avoid_print
                        print("Date is not selected");
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Address.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? "Enter valid email"
                            : null,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) => value != null && value.length < 6
                        ? "Enter min. 6 character "
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[700])),
                      child: const Text('Register New Employee'),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();

                          FirestoreHelper.registerEmployee(Employee(
                            employeeId: employeeIDController.text.trim(),
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                            dob: dateinput.text.trim(),
                            address: addressController.text.trim(),
                          )).then((result) {
                            if (result == null) {
                              AuthenticationHelper()
                                  .signUp(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim())
                                  .then((value) =>
                                      Utils.showSnackBar(value, true));
                              inputClear();

                              Utils.showSnackBar(
                                  "Register successfully", false);
                            } else {
                              Utils.showSnackBar(result, true);
                            }
                          });
                        }
                      },
                    )),
              ],
            )),
      ),
      drawer: MyHeaderDrawer(),
    );
  }
}
