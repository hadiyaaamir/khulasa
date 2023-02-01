import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/login.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/Views/Options/option.dart';
import 'package:khulasa/constants/colors.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
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
              Btn(
                  label: "SIGN UP",
                  onPress: () async {
                    final FormState form = _formKey.currentState as FormState;
                    if (form.validate()) {
                      User user = User(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                      //add to Database
                      Navigation().navigationReplace(context, const Option());
                    }
                  }),

              RichText(
                  text: TextSpan(
                      text: "Already have an acount? Login!",
                      style: const TextStyle(color: text),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => {
                              Navigation().navigation(context, const Login()),
                            }))
            ],
          ),
        ),
      ),
    );
  }
}
