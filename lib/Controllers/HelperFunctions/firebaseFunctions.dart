// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> addToCollection(String coll) async {

//   CollectionReference addList = FirebaseFirestore.instance.collection(coll);

//   list.forEach((element) async {
//     await addList
//         .add(element.toJson())
//         .then((value) => print("Added"))
//         .catchError((error) => print("Failed to add: $error"));
//   });
// // }

// Future<void> cacheFBImage(String imgPath) async {
//   await FirebaseImage(imgPath).preCache();
// }
