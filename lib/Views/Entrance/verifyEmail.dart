import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Entrance/option.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      print('sending email');
      final user = FirebaseAuth.instance.currentUser!;
      await user
          .sendEmailVerification()
          .then((value) => print('email sent to ${user.email}'))
          .catchError((e) => print("can't send email: $e"));
    } catch (e) {
      print(e);
    }
  }

  Future checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.currentUser!.reload();
    }

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
      var setuser = await appUser.getFromDB(user!.email!);

      context.read<UserController>().currentUser = setuser;
      context.read<UserController>().getUserArticles();
      context.read<UserController>().getUserSummaries();
      Navigation().navigationReplace(context, Option());
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;
    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: CustomAppBar(title: isEnglish ? "Verify Email" : ""),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isEmailVerified) ...[
                  Text(
                    isEnglish ? 'Email Verified!' : "",
                    style: TextStyle(color: colors.text, fontSize: buttonFont),
                  ),
                ],
                if (!isEmailVerified) ...[
                  Text(
                    isEnglish ? "Verify your Email to proceed" : "",
                    style: TextStyle(
                        color: colors.text,
                        fontSize: buttonFont,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    isEnglish
                        ? "A verification email has been sent to your account."
                        : "",
                    style: TextStyle(color: colors.text),
                  ),
                  Btn(
                      label: isEnglish ? 'Resend Email' : "",
                      paddingHor: 0,
                      onPress: () => sendVerificationEmail()),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
