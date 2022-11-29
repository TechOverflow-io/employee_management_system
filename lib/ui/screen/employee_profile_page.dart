import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/core/models/product_model.dart';
import 'package:intl/intl.dart';
import '../../core/models/employee_model.dart';
import '../../core/services/firestore_helper.dart';
import '../widgets/drawer_header.dart';

// ignore: must_be_immutable
class EmployeeProfile extends StatefulWidget {
  static const routeName = '/employeeProfile';
  final Employee employee;
  const EmployeeProfile({super.key, required this.employee});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  DateTime selectedDate = DateTime.now();
  String dropdownvalue = 'Item 1';
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text("Employee Profile"),
      ),
      body: ListView(children: [
        Padding(
          padding:
              const EdgeInsets.all(8.0).add(const EdgeInsets.only(top: 10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              shadowColor: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("First Name"),
                      Text(widget.employee.firstName)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Last  Name"),
                      Text(widget.employee.lastName)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Date of Birth"),
                      Text(widget.employee.dob)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Address"),
                      Text(widget.employee.address)
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 4,
            shadowColor: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  StreamBuilder<List<Product>>(
                      stream: FirestoreHelper.readProduct(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("some error occured"),
                          );
                        }
                        if (snapshot.hasData) {
                          final userData = snapshot.data;

                          var productName = userData!.map((product) {
                            return product.name.toString();
                          }).toList();

                          return DropdownSearch<String>(
                            items: productName,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Please Select Product",
                              ),
                            ),
                            onSaved: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                            popupProps: const PopupProps.bottomSheet(
                                constraints: BoxConstraints(maxHeight: 300),
                                showSearchBox: true,
                                bottomSheetProps: BottomSheetProps(
                                  elevation: 16,
                                  backgroundColor: Colors.white,
                                )),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    cursorColor: Colors.green,
                    controller: dateinput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value == null ? "Enter Date" : null,
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.green,
                        ),
                        labelText: "Enter Date",
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
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[700])),
                        child: const Text('Assign'),
                        onPressed: () {},
                      )),
                ],
              ),
            ),
          ),
        )
      ]),
      drawer: MyHeaderDrawer(),
    );
  }
}
