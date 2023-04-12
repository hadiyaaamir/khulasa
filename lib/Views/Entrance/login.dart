import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Entrance/signup.dart';
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
  bool loggedInFailed = false;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;
    // appUser currentUser = context.watch<UserController>().currentUser;

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.background,
        body: Center(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loggedInFailed
                  ? const Text('Email or Password Incorrect')
                  : Text('none'),
              //email textfield
              textField(
                label: isEnglish ? "Email" : "email in urdu",
                icon: Icons.email,
                controller: emailController,
                allowEmpty: true,
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
                label: isEnglish ? "Password" : "email in urdu",
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
                  label: isEnglish ? "LOGIN" : "LOGIN in urdu",
                  onPress: () async {
                    final FormState form = _formKey.currentState as FormState;
                    if (form.validate()) {
                      var result = await UserController().setLoggedIn(
                          emailController.text, passwordController.text);
                      if (result == "LoggedIn Failed") {
                        loggedInFailed = true;
                      } else {
                        loggedInFailed = false;

                        context.read<UserController>().currentUser =
                            result as appUser;

                        // print(emailController.text);

                        Navigation().navigationReplace(context, const Option());
                      }
                    }
                  }),

              RichText(
                  text: TextSpan(
                      text: isEnglish
                          ? "Don't have an account? Sign Up!"
                          : "urdu text",
                      style: TextStyle(color: colors.text),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigation().navigation(context, const SignUp());
                        }))
            ],
          ),
        )),
      ),
    );
  }
}
