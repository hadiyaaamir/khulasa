import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
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
        title: isEnglish ? 'Change Password' : 'پاس ورڈ تبدیل ',
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
                    label: isEnglish ? "Old Password" : "پرانا پاس ورڈ",
                    controller: _oldPasswordController,
                    password: true,
                    validate: (value) {
                      return null;
                    },
                  ),

                  //new password textfield
                  textField(
                    label: isEnglish ? "New Password" : "نیا پاس ورڈ",
                    controller: _newPasswordController,
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
                  //confirm password textfield
                  textField(
                    label: isEnglish ? "Confirm Password" : "پاس ورڈ کی تصدیق",
                    controller: _confirmPasswordController,
                    password: true,
                    validate: (value) {
                      if (value != null) {
                        if (value != _newPasswordController.text) {
                          return isEnglish
                              ? 'Passwords do not match'
                              : 'پاس ورڈ مماثل نہیں ہیں';
                        }
                      }
                      return null;
                    },
                  ),
                  //save button
                  Btn(
                    label: isEnglish ? "CHANGE PASSWORD" : "پاس ورڈ تبدیل",
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
                            setState(() => passwordError = isEnglish
                                ? "Incorrect Password"
                                : 'غلط پاس ورڈ');
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
