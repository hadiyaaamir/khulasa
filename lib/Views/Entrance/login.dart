import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/Dialogs/exitPopup.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Entrance/forgotPassword.dart';
import 'package:khulasa/Views/Entrance/homePage.dart';
import 'package:khulasa/Views/Entrance/signup.dart';
import 'package:khulasa/Views/Entrance/verifyEmail.dart';
import 'package:khulasa/Views/Widgets/NavBar/Toggle.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loggedInFailed = false;
  bool loggingIn = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    bool isEnglish = context.watch<Language>().isEnglish;
    appUser user = context.watch<UserController>().currentUser;

    return WillPopScope(
      onWillPop: () async => showExitPopup(context),
      child: Scaffold(
        backgroundColor: colors.background,
        body: Center(
          child: loggingIn
              ? CircularProgressIndicator(color: colors.primary)
              : Stack(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                        child: ToggleButton(),
                      ),
                    ),
                    Directionality(
                      textDirection:
                          isEnglish ? TextDirection.ltr : TextDirection.rtl,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //error message
                            if (loggedInFailed) ...[
                              Align(
                                alignment: isEnglish
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  child: Text(
                                    isEnglish
                                        ? '* Email or password is incorrect'
                                        : '* ' + 'ای میل یا پاس ورڈ غلط ہے',
                                    style: TextStyle(color: colors.caution),
                                  ),
                                ),
                              ),
                            ],

                            //email textfield
                            textField(
                              label: isEnglish ? "Email" : "ای میل",
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
                              label: isEnglish ? "Password" : "پاس ورڈ",
                              controller: passwordController,
                              icon: Icons.password_rounded,
                              password: true,
                              allowEmpty: true,
                              validate: (value) {
                                return null;
                              },
                            ),

                            //forgot password
                            Align(
                              alignment: isEnglish
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: isEnglish ? 40 : 0,
                                    left: isEnglish ? 0 : 40,
                                    top: 5),
                                child: RichText(
                                  text: TextSpan(
                                    text: isEnglish
                                        ? 'Forgot Password?'
                                        : 'پاس ورڈ بھول گئے؟',
                                    style: TextStyle(
                                        color: Colors.transparent,
                                        fontWeight: isDarkMode
                                            ? FontWeight.w400
                                            : FontWeight.w600,
                                        // fontSize: largerSmallFont,
                                        decorationColor: colors.text,
                                        shadows: [
                                          Shadow(
                                            color: colors.text,
                                            offset: const Offset(0, -3),
                                          )
                                        ],
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 2),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => {
                                            Navigation().navigation(context,
                                                const ForgotPassword()),
                                          },
                                  ),
                                ),
                              ),
                            ),

                            //button
                            Btn(
                                label: isEnglish ? "LOGIN" : "لاگ ان",
                                onPress: () async {
                                  final FormState form =
                                      _formKey.currentState as FormState;
                                  if (form.validate()) {
                                    //show loading circle
                                    setState(() => loggingIn = true);

                                    //log in function
                                    var result = await context
                                        .read<UserController>()
                                        .setLoggedIn(
                                            emailController.text.trim(),
                                            passwordController.text);

                                    //stop loading circle
                                    setState(() => loggingIn = false);

                                    //if wrong credentials
                                    if (!result) {
                                      setState(() {
                                        loggedInFailed = true; //error message
                                        loggingIn = false; //stop loading circle
                                      });
                                    }

                                    //log in!
                                    else {
                                      setState(() => loggedInFailed = false);
                                      Navigation().navigationReplace(
                                          context,
                                          FirebaseAuth.instance.currentUser!
                                                  .emailVerified
                                              ? const HomePage()
                                              : const VerifyEmail());
                                    }
                                  }
                                }),

                            RichText(
                              text: TextSpan(
                                text: isEnglish
                                    ? "Don't have an account? "
                                    : "کیا آپ کا اکاؤنٹ نہیں ہے؟",
                                style: TextStyle(color: colors.text),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: isEnglish ? 'Signup!' : 'سائن اپ',
                                    style: TextStyle(
                                        color: colors == blueDarkMode
                                            ? colors.primary
                                            : colors.secondary,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigation().navigation(
                                          context,
                                          //const Chatgpt()
                                          const SignUp()),
                                  ),
                                ],
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigation()
                                      .navigation(context, const SignUp()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
