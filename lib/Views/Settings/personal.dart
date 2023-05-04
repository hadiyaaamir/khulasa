import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Backend/dateFormat.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Settings/changePassword.dart';
import 'package:khulasa/Views/Settings/settingBtn.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/labelIcon.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appUser user = context.read<UserController>().currentUser;
    _emailController.text = user.email;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
  }

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    appUser user = context.watch<UserController>().currentUser;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(
        title: isEnglish ? 'Personal Details' : '',
        trailing: Padding(
          padding: EdgeInsets.only(top: 5, right: 20),
          child: LabelIcon(
            icon: Icons.edit,
            label: 'Edit',
            color: isEditing ? Colors.transparent : colors.text,
            onPress: () => setState(() => isEditing = true),
          ),
        ),
      ),
      body: Directionality(
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //name tile
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
                child: SettingBtn(
                  isSelected: false,
                  perpetualShadow: true,
                  paddingBottom: 0,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: TextStyle(
                            fontSize: smallerLargerFont,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode && colors == blueDarkMode
                                ? colors.primary
                                : isDarkMode
                                    ? colors.secondary
                                    : colors.text),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Member since ${DateFormatter().formatDate(FirebaseAuth.instance.currentUser!.metadata.creationTime!, isEnglish)}',
                        style: TextStyle(color: colors.text2),
                      ),
                    ],
                  ),
                ),
              ),

              //Form
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    //first name textfield
                    textField(
                      label: isEnglish ? "First Name" : "",
                      controller: _firstNameController,
                      isEnabled: isEditing,
                      validate: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Invalid First Name'
                            : null;
                      },
                    ),
                    //last name textfield
                    textField(
                      label: isEnglish ? "Last Name" : "",
                      controller: _lastNameController,
                      isEnabled: isEditing,
                      validate: (value) {
                        return (value == null || value.isEmpty)
                            ? 'Invalid Last Name'
                            : null;
                      },
                    ),
                    //email textfield
                    textField(
                      label: isEnglish ? "Email" : "",
                      controller: _emailController,
                      isEnabled: false,
                    ),

                    //button
                    if (isEditing) ...[
                      //change password
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
                              text:
                                  isEnglish ? 'Change Password' : 'urdu thing',
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
                                ..onTap = () => Navigation().navigation(
                                    context, const ChangePassword()),
                            ),
                          ),
                        ),
                      ),

                      //save button
                      Btn(
                        label: isEnglish ? "SAVE" : "",
                        onPress: () async {
                          final FormState form =
                              _formKey.currentState as FormState;
                          if (form.validate()) {
                            //only update if change
                            if (user.firstName != _firstNameController.text ||
                                user.lastName != _lastNameController.text) {
                              await context.read<UserController>().updateName(
                                  _firstNameController.text,
                                  _lastNameController.text);
                            }

                            setState(() => isEditing = false);
                          }
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
