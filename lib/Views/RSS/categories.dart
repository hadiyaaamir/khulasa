import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Controllers/RSS/categoryprovider.dart';
import 'package:khulasa/Controllers/RSS/categoryprovider.dart';
import 'package:khulasa/Views/RSS/articlelist.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';
import '../../Models/category.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    List<category> categorylist = context.watch<catprovider>().categoryList;
    return Scaffold(
        backgroundColor: background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  "RSS Feed",
                  style: TextStyle(
                    color: text,
                    fontSize: headingFont,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    itemCount: context.read<catprovider>().count,
                    itemBuilder: (context, index) => Card(
                          color: primary,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => articleList(
                                        c: context
                                            .watch<catprovider>()
                                            .getcategory(index),
                                      )));
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            title: Text(
                              context.read<catprovider>().getcategory(index),
                              style: const TextStyle(
                                  color: text, fontSize: buttonFont),
                            ),
                            trailing: GestureDetector(
                                child:
                                    (!context.read<catprovider>().getfav(index))
                                        ? const Icon(
                                            Icons.favorite_outline_outlined,
                                            color: text,
                                          )
                                        : const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                onTap: () {
                                  context.read<catprovider>().setfav(
                                      index,
                                      !context
                                          .read<catprovider>()
                                          .getfav(index));
                                }),
                            tileColor: primary,
                          ),
                        )),
              ),
            ],
          ),
        ));
  }
}
