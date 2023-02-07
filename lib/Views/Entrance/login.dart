import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/signup.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/Views/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Options/option.dart';
import 'package:khulasa/Views/apicall.dart';
import 'package:khulasa/constants/colors.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          child: Form(
        key: _formKey,
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
            Btn(
                label: "LOGIN",

                onPress: () async {
                  final FormState form = _formKey.currentState as FormState;
                  if (form.validate()) {
                    //check database
                    Navigation().navigationReplace(context, const Option());
                  }

                }),

            RichText(
                text: TextSpan(
                    text: "Don't have an acount? Sign Up!",
                    style: const TextStyle(color: text),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigation().navigation(context, const SignUp());
                      }))
          ],
        ),
      )),
    );
  }
}
