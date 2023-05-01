import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Entrance/login.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  sendResetEmail() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;
    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: CustomAppBar(title: isEnglish ? "Reset Password" : ""),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEnglish ? "Enter your email to reset password" : "",
                  style: TextStyle(
                      color: colors.text,
                      fontSize: buttonFont,
                      fontWeight: FontWeight.w600),
                ),
                //email textfield
                textField(
                  label: isEnglish ? "Email" : "",
                  icon: Icons.email,
                  paddingHor: 0,
                  paddingVert: 20,
                  controller: _emailController,
                  validate: (value) {
                    return (value == null ||
                            value.isEmpty ||
                            !EmailValidator.validate(value.trim()))
                        ? 'Invalid Email'
                        : null;
                  },
                ),
                // const SizedBox(height: 15),
                Text(
                  isEnglish
                      ? "An email will be sent to your account. Follow the link to reset your password."
                      : "",
                  style: TextStyle(color: colors.text),
                ),
                Btn(
                    label: isEnglish ? 'Reset Password' : "",
                    paddingHor: 0,
                    onPress: () async {
                      await sendResetEmail();
                      Fluttertoast.showToast(msg: 'Email sent!');
                      Navigation().navigationReplace(context, Login());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
