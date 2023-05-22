import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String passwordError = "";
  bool changingPassword = false;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(
        title: isEnglish ? 'Change Password' : '',
      ),
      body: Directionality(
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //error message
                  if (passwordError != "") ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Text(
                          passwordError,
                          style: TextStyle(color: colors.caution),
                        ),
                      ),
                    ),
                  ],

                  //old password textfield
                  textField(
                    label: isEnglish ? "Old Password" : "",
                    controller: _oldPasswordController,
                    password: true,
                    validate: (value) {
                      return null;
                    },
                  ),

                  //new password textfield
                  textField(
                    label: isEnglish ? "New Password" : "",
                    controller: _newPasswordController,
                    password: true,
                    validate: (value) {
                      if (value != null) {
                        if (value.length < 8) {
                          return 'Password must be atleast 8 characters long';
                        }
                      }
                      return null;
                    },
                  ),
                  //confirm password textfield
                  textField(
                    label: isEnglish ? "Confirm Password" : "",
                    controller: _confirmPasswordController,
                    password: true,
                    validate: (value) {
                      if (value != null) {
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                      }
                      return null;
                    },
                  ),
                  //save button
                  Btn(
                    label: isEnglish ? "CHANGE PASSWORD" : "",
                    onPress: () async {
                      final FormState form = _formKey.currentState as FormState;
                      if (form.validate()) {
                        var result = await context
                            .read<UserController>()
                            .updatePassword(
                              newPassword: _newPasswordController.text,
                              oldPassword: _oldPasswordController.text,
                            )
                            .then((value) {
                          if (value) {
                            Navigation().navigationPop(context);
                          } else {
                            setState(
                                () => passwordError = "Incorrect Password");
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}