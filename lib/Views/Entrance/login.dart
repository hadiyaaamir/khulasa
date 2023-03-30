import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/Views/Entrance/option.dart';
import 'package:khulasa/Views/apicall.dart';
import 'package:provider/provider.dart';

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
    ColorTheme colors = context.watch<DarkMode>().mode;
    return Scaffold(
      backgroundColor: colors.background,
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
              allowEmpty: true,
              validate: (value) {
                return
                    // (value == null ||
                    //         value.isEmpty ||
                    //         !value.contains('@') ||
                    //         !value.contains('.'))
                    //     ? 'Invalid Email'
                    //     :
                    null;
              },
            ),

            //password textfield
            textField(
              label: "Password",
              controller: passwordController,
              icon: Icons.password_rounded,
              password: true,
              allowEmpty: true,
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
                    style: TextStyle(color: colors.text),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigation().navigation(context, const ApiCall());
                      }))
          ],
        ),
      )),
    );
  }
}
