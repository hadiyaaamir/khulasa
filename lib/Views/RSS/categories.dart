import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Controllers/RSS/categoryprovider.dart';
import 'package:khulasa/Controllers/RSS/categoryprovider.dart';
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
            children: [
              Text(
                "RSS Feed",
                style: const TextStyle(
                  color: text,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: context.read<catprovider>().count,
                    itemBuilder: (context, index) => ListTile(
                          onTap: () {},
                          title: Text(
                            context.read<catprovider>().getcategory(index),
                            style: const TextStyle(
                                color: text, fontSize: buttonFont),
                          ),
                          trailing: GestureDetector(
                              child:
                                  (!context.read<catprovider>().getfav(index))
                                      ? Icon(
                                          Icons.favorite_outline_outlined,
                                          color: text,
                                        )
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                              onTap: () {
                                context.read<catprovider>().setfav(index,
                                    !context.read<catprovider>().getfav(index));
                              }),
                          tileColor: primary,
                        )),
              )
            ],
          ),
        ));
  }
}
