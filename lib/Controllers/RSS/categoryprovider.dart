import 'package:flutter/cupertino.dart';

import '../../Models/category.dart';

class catprovider extends ChangeNotifier {
  catprovider() {
    categoryList;
    notifyListeners();
  }
  List<category> _category = [
    category(cat: "Breaking News", isFav: false),
    category(cat: "Current Affairs", isFav: false),
    category(cat: "Eucation", isFav: false),
    category(cat: "Sports", isFav: false),
    category(cat: "Entertainment", isFav: false),
    category(
      cat: "Health & Lifestyle",
      isFav: false,
    )
  ];

  List<category> get categoryList => _category; //update later
  int get count => _category.length;
  String getcategory(int i) => _category[i].cat;
  bool getfav(int i) => _category[i].isFav;
  void setfav(int i, bool b) {
    _category[i].isFav = b;
    notifyListeners();
  }
}
