import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/login.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/constants/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //first name textfield
            textField(
              label: "First Name",
              controller: firstNameController,
              validate: (value) {
                return (value == null || value.isEmpty)
                    ? 'Invalid First Name'
                    : null;
              },
            ),
            //last name textfield
            textField(
              label: "Last Name",
              controller: lastNameController,
              validate: (value) {
                return (value == null || value.isEmpty)
                    ? 'Invalid Last Name'
                    : null;
              },
            ),
            //email textfield
            textField(
              label: "Email",
              icon: Icons.email,
              controller: emailController,
              validate: (value) {
                return (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.'))
                    ? 'Invalid Email'
                    : null;
              },
            ),

            //password textfield
            textField(
              label: "Password",
              controller: passwordController,
              icon: Icons.password_rounded,
              password: true,
              validate: (value) {
                return null;
              },
            ),

            //button
            Btn(label: "SIGN UP", onPress: () {}),

            RichText(
                text: TextSpan(
                    text: "Already have an acount? Login!",
                    style: const TextStyle(color: text),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            )
                          }))
          ],
        ),
      ),
    );
  }
}
