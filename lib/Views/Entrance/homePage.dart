import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/Dialogs/exitPopup.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Saved/savedOptions.dart';
import 'package:khulasa/Views/Transcription/transcription.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/RSS/categories.dart';
import 'package:khulasa/Views/Summary/summary.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    bool isEnglish = context.watch<Language>().isEnglish;

    appUser user = context.watch<UserController>().currentUser;
    print('at homepage user is $user');
    return WillPopScope(
      onWillPop: () async => showExitPopup(context),
      child: Directionality(
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(),
          drawer: const Drawer(child: Draw()),
          backgroundColor: colors.background,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Hello, person
                  Text(
                    isEnglish ? 'Hello,' : 'سلام،',
                    style: TextStyle(
                      color: colors.text,
                      fontSize: largerFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: TextStyle(
                      color: colors == blueDarkMode
                          ? colors.primary
                          : colors.secondary,
                      fontSize: largerFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 5),
                    child: Divider(
                      color: colors == blueDarkMode
                          ? colors.secondary
                          : colors.primary,
                    ),
                  ),

                  //what would you like to do
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 25),
                    child: Text(
                      isEnglish
                          ? 'What would you like to do today?'
                          : 'آج آپ کیا کرنا چاہیں گے؟',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: headingFont,
                      ),
                    ),
                  ),

                  //option tiles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OptionTile(
                        text: isEnglish ? "Generate a Summary" : "خلاصہ",
                        navTo: const Summary(),
                        imgPath: 'assets/images/summary.png',
                      ),
                      const SizedBox(width: 15),
                      OptionTile(
                        text: isEnglish
                            ? "Read the Latest News"
                            : "آر ایس ایس فیڈ",
                        navTo: const Categories(),
                        imgPath: 'assets/images/news.png',
                      ),
                    ],
                  ),

                  //space
                  const SizedBox(height: 15),

                  //option tiles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OptionTile(
                        text: isEnglish
                            ? "Transcribe an Audio/Video"
                            : "تقریر کی تحریر",
                        navTo: const Transcription(),
                        imgPath: 'assets/images/transcribe.png',
                      ),
                      const SizedBox(width: 15),
                      OptionTile(
                        text:
                            isEnglish ? "View Saved Items" : "محفوظ شدہ اشیاء",
                        navTo: const SavedMain(),
                        imgPath: 'assets/images/saved.png',
                      ),
                    ],
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

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.text,
    required this.navTo,
    required this.imgPath,
  });

  final String text;
  final Widget navTo;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigation().navigation(context, navTo),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          // width: double.infinity,
          // height: screenHeight / 3,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(1, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Image(image: AssetImage(imgPath)),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  text,
                  style: TextStyle(color: colors.text, fontSize: buttonFont),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
