import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/category.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Entrance/homePage.dart';
import 'package:khulasa/Views/RSS/rssFeed.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/constants/categories.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;
    return WillPopScope(
      onWillPop: () async =>
          Navigation().navigationReplace(context, const HomePage()),
      child: Directionality(
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(
            title: isEnglish ? 'RSS Feed' : "آر ایس ایس فیڈ",
          ),
          drawer: const Drawer(child: Draw()),
          backgroundColor: colors.background,
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            itemCount: categories.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Card(
                color: colors.primary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 25),

                  title: Text(
                    isEnglish
                        ? categories[index].name
                        : categories[index].nameUrdu,
                    style: TextStyle(color: colors.text),
                  ),

                  leading: Icon(categories[index].icon, color: colors.text),
                  trailing: Icon(
                    isEnglish
                        ? Icons.keyboard_arrow_right_rounded
                        : Icons.keyboard_arrow_left_rounded,
                    color: colors.text2,
                  ),
                  onTap: () {
                    Navigation()
                        .navigation(context, RssFeed(cat: categories[index]));
                  },
                  // onTap: Navigation().navigation(context, RssFeed()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



/*


//                             trailing: GestureDetector(
//                                 child:
//                                     (!context.read<catprovider>().getfav(index))
//                                         ? const Icon(
//                                             Icons.favorite_outline_outlined,
//                                             color: text,
//                                           )
//                                         : const Icon(
//                                             Icons.favorite,
//                                             color: Colors.red,
//                                           ),
//                                 onTap: () {
//                                   context.read<catprovider>().setfav(
//                                       index,
//                                       !context
//                                           .read<catprovider>()
//                                           .getfav(index));
//                                 }),
//                             \
*/