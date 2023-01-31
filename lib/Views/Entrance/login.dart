import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/constants/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Btn(label: "LOGIN", onPress: () {})
          ],
        ),
      ),
    );
  }
}
