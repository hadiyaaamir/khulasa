import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/user.dart';

import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Entrance/login.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/Views/Entrance/option.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

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

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  String signUpError = "";
  bool signingUp = false;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.background,
        body: Center(
          child: signingUp
              ? CircularProgressIndicator(color: colors.primary)
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),

                        //error message
                        if (signUpError != "") ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Text(
                                signUpError,
                                style: TextStyle(color: colors.caution),
                              ),
                            ),
                          ),
                        ],

                        //first name textfield
                        textField(
                          label: isEnglish ? "First Name" : "",
                          controller: firstNameController,
                          validate: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Invalid First Name'
                                : null;
                          },
                        ),
                        //last name textfield
                        textField(
                          label: isEnglish ? "Last Name" : "",
                          controller: lastNameController,
                          validate: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Invalid Last Name'
                                : null;
                          },
                        ),
                        //email textfield
                        textField(
                          label: isEnglish ? "Email" : "",
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
                          label: isEnglish ? "Password" : "",
                          controller: passwordController,
                          icon: Icons.password_rounded,
                          password: true,
                          validate: (value) {
                            return null;
                          },
                        ),

                        //button
                        Btn(
                            label: isEnglish ? "SIGN UP" : "",
                            onPress: () async {
                              final FormState form =
                                  _formKey2.currentState as FormState;
                              if (form.validate()) {
                                appUser user = appUser(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text);
                                //add to Database

                                var result = await context
                                    .read<UserController>()
                                    .addToDB(user, passwordController.text);

                                if (result != null) {
                                  if (result == 'Success') {
                                    setState(() =>
                                        {signingUp = true, signUpError = ""});
                                    await context
                                        .read<UserController>()
                                        .getFromDB(emailController.text);
                                    setState(() => signingUp = false);
                                    Navigation().navigationReplace(
                                        context, const Option());
                                  } else {
                                    setState(() => signUpError = result);
                                  }
                                }
                              }
                            }),

                        RichText(
                          text: TextSpan(
                            text: isEnglish ? "Already have an account? " : "",
                            style: TextStyle(color: colors.text),
                            children: <TextSpan>[
                              TextSpan(
                                text: isEnglish ? 'Login!' : 'urdu login',
                                style: TextStyle(
                                    color: colors.secondary,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigation()
                                      .navigation(context, const Login()),
                              ),
                            ],
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                    Navigation()
                                        .navigation(context, const Login()),
                                  },
                          ),
                        ),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
