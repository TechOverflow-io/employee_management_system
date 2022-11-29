import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/ui/screen/employee_performance_page.dart';
import 'package:flutter_first_app/ui/screen/home_page.dart';
import '../../core/auth/authentication.dart';
import '../../core/utils/utils.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: ListView(children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: const Image(image: AssetImage('assets/images/logo.png')),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Email ',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? "Enter valid email"
                      : null,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Password',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                onPressed: () {
                  // Respond to button press

                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();

                    AuthenticationHelper()
                        .signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim())
                        .then((result) {
                      if (result == null) {
                        if (emailController.text.trim() ==
                            "admin123@gmail.com") {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EmployeePerformance()));
                        }
                        Utils.showSnackBar("Login successfully", false);
                      } else {
                        Utils.showSnackBar(result, true);
                      }
                    });
                  }
                },
                child: const Text('Sign In'),
              )),
        ]),
      ),
    );
  }
}
