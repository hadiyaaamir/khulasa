import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/Dialogs/exitPopup.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Entrance/verifyEmail.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Entrance/login.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
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

    return WillPopScope(
      onWillPop: () async => showExitPopup(context),
      child: Directionality(
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
                                padding: const EdgeInsets.symmetric(
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
                            label: isEnglish ? "First Name" : "پہلا نام",
                            controller: firstNameController,
                            validate: (value) {
                              return (value == null || value.isEmpty)
                                  ? isEnglish
                                      ? 'Invalid First Name'
                                      : 'غلط پہلا نام'
                                  : null;
                            },
                          ),
                          //last name textfield
                          textField(
                            label: isEnglish ? "Last Name" : "آخری نام",
                            controller: lastNameController,
                            validate: (value) {
                              return (value == null || value.isEmpty)
                                  ? isEnglish
                                      ? 'Invalid Last Name'
                                      : 'غلط آخری نام'
                                  : null;
                            },
                          ),
                          //email textfield
                          textField(
                            label: isEnglish ? "Email" : "ای میل",
                            icon: Icons.email,
                            controller: emailController,
                            validate: (value) {
                              return (value == null ||
                                      value.isEmpty ||
                                      !EmailValidator.validate(value.trim()))
                                  ? isEnglish
                                      ? 'Invalid Email'
                                      : 'غلط ای میل'
                                  : null;
                            },
                          ),

                          //password textfield
                          textField(
                            label: isEnglish ? "Password" : "پاس ورڈ",
                            controller: passwordController,
                            icon: Icons.password_rounded,
                            password: true,
                            validate: (value) {
                              if (value != null) {
                                if (value.length < 8) {
                                  return isEnglish
                                      ? 'Password must be atleast 8 characters long'
                                      : 'پاس ورڈ کم از کم 8 حروف کا ہونا ضروری ہے';
                                }
                              }
                              return null;
                            },
                          ),

                          //button
                          Btn(
                              label: isEnglish ? "SIGN UP" : "سائن اپ",
                              onPress: () async {
                                final FormState form =
                                    _formKey2.currentState as FormState;
                                if (form.validate()) {
                                  appUser user = appUser(
                                      firstName:
                                          firstNameController.text.trim(),
                                      lastName: lastNameController.text.trim(),
                                      email: emailController.text.trim());
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
                                          .getFromDB(
                                              emailController.text.trim());
                                      setState(() => signingUp = false);
                                      Navigation()
                                          .navigation(context, VerifyEmail());
                                    } else {
                                      if (result ==
                                          'An account already exists for this email') {
                                        Navigation()
                                            .navigation(context, VerifyEmail());
                                      }
                                      setState(() => signUpError = result);
                                    }
                                  }
                                }
                              }),

                          RichText(
                            text: TextSpan(
                              text: isEnglish
                                  ? "Already have an account? "
                                  : "کیا آپ کا پہلے سے اکاؤنٹ ہے؟",
                              style: TextStyle(color: colors.text),
                              children: <TextSpan>[
                                TextSpan(
                                  text: isEnglish ? 'Login!' : 'لاگ ان',
                                  style: TextStyle(
                                      color: colors == blueDarkMode
                                          ? colors.primary
                                          : colors.secondary,
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
      ),
    );
  }
}
