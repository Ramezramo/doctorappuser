import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'databaseXoperations/read_from_data_base_fb.dart';

class UserProvider with ChangeNotifier {
  bool userLoggedIns = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool get userLoggedIn => userLoggedIns;
  String userName = "";
  String userPicLink = "";
  String userGmail = "";
  String userPhone = "";

  Future<void> checkServerForUserLogedIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        // User is not logged in

        userLoggedIns = false;
      } else {
        // User is logged in
        User? user = auth.currentUser;
        String? userid = user?.uid;
        Map doctorData = await giveMeTheDataBaseAsJson(userid);
        userName = doctorData["name"];
        userPicLink = doctorData["piclink"];
        userGmail = doctorData["email"];
        userPhone = doctorData["phone"];
        // print(doctorData["name"]);




        userLoggedIns = true;
      }
    });
  }
  // void checkServerForUserLogedIn() {
  //
  //
  //   _userLoggedIn = value;
  //   notifyListeners();
  // }
}
