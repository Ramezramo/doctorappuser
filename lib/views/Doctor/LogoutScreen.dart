import 'dart:async';

import 'package:doctorapplast/main.dart';
import 'package:doctorapplast/views/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../en.dart';

class LogOutScreen extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // @override
  Future messageDialogLogout(context){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text("Are you sure you want to logout?",style: GoogleFonts.comfortaa(
              fontWeight: FontWeight.bold,
            ),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Logout",style: GoogleFonts.poppins(
                  fontSize: 14,
                ),)
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async{
                  try{
                    // CubeChatConnection.instance.logout();
                    await _auth.signOut();
                  }catch(e){
                    ("CubeChatConnection.instance ${e.toString()}");
                  }
                  // SharedPreferences.getInstance().then((pref){
                  //   pref.clear();
                  //   pref.setBool("isLoggedInAsDoctor", false);
                  //   pref.setBool("isLoggedIn", false);
                  //   // pref.setString("userId", null);
                  //   // pref.setString("name", null);
                  //   // pref.setString("phone", null);
                  //   // pref.setString("email", null);
                  //   // pref.setString("token", null);
                  // });
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => TabsScreen(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hintColor,
                ),
                child: Text(YES,style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: BLACK,
                ),),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
