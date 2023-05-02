import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Controllers/Backend/categoryExcel.dart';
import 'package:khulasa/Controllers/articleprovider.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Entrance/homePage.dart';
import 'package:khulasa/Views/Entrance/login.dart';
import 'package:khulasa/Views/Entrance/option.dart';
import 'package:khulasa/Views/Entrance/verifyEmail.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => Language()),
        // ChangeNotifierProvider(create: (context) => DarkMode()),
        ChangeNotifierProvider(create: (context) => articleprovider()),
        ChangeNotifierProvider(create: (context) => UserController()),

        //dark mode provider with user passed in
        ChangeNotifierProxyProvider<UserController, DarkMode>(
          create: (BuildContext context) => DarkMode(
            user: Provider.of<UserController>(context, listen: false),
          ),
          update:
              (BuildContext context, UserController user, DarkMode? darkMode) =>
                  DarkMode(user: user),
        ),

        //language provider with user
        ChangeNotifierProxyProvider<UserController, Language>(
          create: (BuildContext context) => Language(
            user: Provider.of<UserController>(context, listen: false),
          ),
          update:
              (BuildContext context, UserController user, Language? language) =>
                  Language(user: user),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Open Sans',
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<articleprovider>().getArticlesSimultaneous();
    });

    // CategoryExcel().toExcel();
    // TODO: implement initState

    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    // bool result = await InternetConnectionChecker().hasConnection;

    var currUser = FirebaseAuth.instance.currentUser;
    print('current User: $currUser');
    if (currUser != null) {
      var user = await appUser.getFromDB(currUser.email!);
      context.read<UserController>().currentUser = user;
      context.read<UserController>().getUserArticles();
      context.read<UserController>().getUserSummaries();

      Navigation().navigationReplace(context,
          currUser.emailVerified ? const HomePage() : const VerifyEmail());
    } else {
      Navigation().navigationReplace(context, const Login());
    }
  }

  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
          child: (Text("خلاصہ",
              style: TextStyle(color: colors.text, fontSize: titleFont)))),
    );
  }
}
