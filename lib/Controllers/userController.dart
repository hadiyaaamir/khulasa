import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khulasa/Models/user.dart';

CollectionReference userlist = FirebaseFirestore.instance.collection('Users');
User user = User();

class UserController {
  // User get user => _user;

  Future<void> addToDB(User user) async {
    await userlist
        .add(user.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add: $error"));
  }

  Future<void> getFromDB(String email) async {
    await userlist
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        user = (User.fromJson(doc.data() as Map<String, dynamic>));
      });
    });
    // notifyListeners();
  }

  Future<void> setLoggedIn(bool login) async {
    await userlist.where('email', isEqualTo: user.email).get().then((value) {
      userlist
          .doc(value.docs[0].id)
          .update({'isLoggedIn': login}).then((value) {
        print("Logged in/out!");
        user.isLoggedIn = login; // DB? or fine. Check
      });
    });
  }

  bool userNotFound() {
    return user.email == "";
  }
}
