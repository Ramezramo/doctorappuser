import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class MakeChangesDBM {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _userId;

  // Future<void> forceLogin() async {
  //   /// THIS WILL AUTO SIGNIN TO GET THE USER ID IN THE getCurrentUser()
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: "ramezmalakdev@gmail.com", password: "pass.toString()");
  //   } catch (e) {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: "ramezmalakdev@gmail.com", password: "pass.toString()");
  //   }
  // }

  Future<String?> getCurrentUser() async {
    /// TO CHECK IF THE CURRENT USER ALREADY SIGNED IN OR NO
    /// IF SIGNEDIN == TRUE THE FUNCTION WILL RETURN ITS USER ID TO USE IT IN DATA BASE
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    // print(user);
    if (user != null) {
      // The user is signed in.
      _userId = user.uid;
      return _userId;
    } else {
      // The user is signed out or not logged in.
      return "";
    }
  }

  Future<void> _settingUserId(besolevel ,themapwillbeintheuserid) async {
    /// HERE WILL MAKE A BRANCH IN THE COLLECTION WITH THE USER ID
    getCurrentUser();
    final CollectionReference loggedDoctorsCollection =
    FirebaseFirestore.instance.collection(besolevel);
    // DocumentSnapshot snapshot = await doc.get();
    try {
      // Check if the document with the specified user ID exists
      DocumentSnapshot documentSnapshot = await loggedDoctorsCollection.doc(_userId).get();

      if (documentSnapshot.exists) {
        // Document exists, you can perform an update or take other actions
        print("Document with user ID $_userId already exists. Performing an update or other actions...");

        // Uncomment the line below if you want to update the existing document
        // await loggedDoctorsCollection.doc(userId).update(doctors);

        // You can also perform other actions here if needed
      } else {
        // Document doesn't exist, perform the initial set
        await loggedDoctorsCollection.doc(_userId).set(themapwillbeintheuserid);
        print("Document with user ID $_userId created successfully.");
      }
    } catch (e) {
      print("Error updating/creating logged doctors document: $e");
    }
    // if (snapshot.exists) {
    //   // Collection and document exist
    //
    // } else {
    //   // Collection or document doesn't exist, create them
    //   await _createDocumentWithUserId(
    //       beboLevel, weboLevel, googleLevel, googlChild);
    //   // if (kDebugMode) {
    //   //   print("Created collection and document.");
    //   // }
    // }
  }

  Future<void> _createDocumentWithUserId(String beboLevel, String weboLevel,
      String googleLevel, Map googlChild) async {
    /// IT WILL PREPARE THE DATA BASE ENVIRONMENT FOR THE USER FIRST TIME

    /// beboLevel      userIdLevel webowebolevel  googleLevel randomKeyLevel
    ///     //            //               //        //           //
    ///beboLevel   >> aksjdfhalskdfj >>  webowebo >> google { "randomid": {
    ///                                           //
    ///                                           //                       "theword": {
    ///                                           //                       "translation": "thetranslation",
    ///                                           //                        "time": "123456789"
    ///                                           //                               }
    ///                                           //                      }
    ///                                           //            }
    ///                                           >>  github { "randomid": {
    ///                                           //
    ///                                           //                         "theword": {
    ///                                           //                         "translation": "thetranslation",
    ///                                           //                          "time": "123456789"
    ///                                           //                               }
    ///                                           //                      }
    ///                                           //               }

    if (_userId == null) {
      if (kDebugMode) {
        print('User ID is not available. Make sure the user is logged in.');
      }
      return;
    }

    try {
      DocumentReference documentReference = _firestore
          .collection(beboLevel)
          .doc(_userId); //TRY TO GET IN COLLECTION NAME WITH USER ID

      await documentReference.set({
        weboLevel: {googleLevel: googlChild},
      });

      /// WILL ADD THE FIRST MAP TO MAKE THE DATA BASE CONTROLLER KNOW ABOUT HOW DATA BE STORED

      if (kDebugMode) {
        print('Document with ID $_userId created successfully.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating document: $e');
      }
    }
  }

  Future<void> _appendDataToDatabase(value, key, beboLevel, weboLevel) async {
    try {
      /// Reference to the document containing the [websites] map
      DocumentReference documentRef =
          _firestore.collection(beboLevel).doc(_userId);

      /// Get the current data of the document
      DocumentSnapshot documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        // Extract the 'websites' map from the current data
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> websites = data[weboLevel];

        // Check if 'google' exists in the 'websites' map
        if (websites.containsKey(key)) {
          // Extract the existing value of 'google' (which is another map)
          Map<String, dynamic> googleValue = websites[key];

          // Add the new data to the existing 'google' map
          googleValue[_generateRandomKey()] = value;

          // Update the 'websites' map in the Firestore document
          await documentRef.update({weboLevel: websites});
          if (kDebugMode) {
            print("Appended data to $key successfully.");
          }
        } else {
          if (kDebugMode) {
            print("$key field does not exist.");
          }
        }
      } else {
        if (kDebugMode) {
          print("Document does not exist.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error updating document: $e");
      }
    }
  }

  Future<void> prepareDataBaseEnvironment(besolevel,mapwillbeinbeso
      ) async {
    // await forceLogin();
    await getCurrentUser();
    await _settingUserId(besolevel,mapwillbeinbeso);
  }

  String _generateRandomKey() {
    const String _chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random _rnd = Random();
    String result = '';
    for (int i = 0; i < 7; i++) {
      result += _chars[_rnd.nextInt(_chars.length)];
    }
    return result;
  }

  void addChildTogoogleLevel(
      GoogleNewChild, translation, userId, beboLevel, weboLevel) async {
    //ok

    /// Replace 'Xv4Yac4wxxfM91uDknWGKA6nf4m1' with the ID of your desired document

    ///this function will add data to googleLevel level

    String documentId = userId;

    /// Get a reference to the document you want to update
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection(beboLevel).doc(documentId);

    // Fetch the current data
    DocumentSnapshot snapshot = await documentRef.get();
    if (!snapshot.exists) {
      if (kDebugMode) {
        print('Document does not exist');
      }
      return;
    }

    /// Get the data map from the snapshot
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // Check if the 'websites' map exists
    if (data[weboLevel] == null) {
      // If 'websites' map doesn't exist, create it with the 'for_test' key
      data[weboLevel] = {'for_test': {}};
    }

    /// Get the 'for_test' map
    _appendDataToDatabase(
        {"theword": GoogleNewChild, "translationtoarabic": translation},
        GoogleNewChild,
        beboLevel,
        weboLevel);
  }

  Future<void> addNewWordGoogleLevel(
      theWordInGoogleLevel, translation, beboLevel, weboLevel,userId) async {
    //ok
    ///THIS FUNCTION WILL ADD A NEW WORD IN THE PLACE OF GOOGLE LEVEL
    // getCurrentUser();
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection(beboLevel).doc(userId).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        /// print(data);

        if (data[weboLevel] != null &&
            data[weboLevel][theWordInGoogleLevel] != null) {
          await _appendDataToDatabase({
            "theword": theWordInGoogleLevel,
            "translationtoarabic": translation
          }, theWordInGoogleLevel, beboLevel, weboLevel);
        } else {
          /// The key 'google' doesn't exist in the 'websites' map

          DocumentReference documentReference =
              _firestore.collection(beboLevel).doc(userId);
          await documentReference.update({
            "$weboLevel.$theWordInGoogleLevel": {
              "translationtoarabic": translation,
            },
          });
        }
      } else {
        /// Document does not exist
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting document: $e");
      }
    }
  }

  Future<void> deleteGoogleLevel(googleLevel, weboLevel, beboLevel) async {
    await getCurrentUser();
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(beboLevel).doc(_userId);

    /// Update the document by removing the 'for_test' field

    await documentReference.update({
      '$weboLevel.$googleLevel': FieldValue.delete(),
    });
  }

  Future<void> deleteGoogleChild(googleLevel, weboLevel, beboLevel, userId, googleChild) async {
    getCurrentUser();
    String documentId = userId;

    /// Get a reference to the document you want to update
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection(beboLevel).doc(documentId);

    // Fetch the current data
    DocumentSnapshot snapshot = await documentRef.get();
    if (!snapshot.exists) {
      if (kDebugMode) {
        print('Document does not exist');
      }
      return;
    }

    /// Get the data map from the snapshot
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (kDebugMode) {
      print(googleLevel);
      print(data[weboLevel][googleChild]);
    }

    /// Check if the 'for_test' key exists in the 'websites' map
    if (data[weboLevel] != null && data[weboLevel][googleLevel] != null) {
      /// Remove the 'for_test' key from the 'websites' map
      data[weboLevel][googleLevel].remove(googleChild);

      /// Update the document with the modified data
      await documentRef.update(data);
      if (kDebugMode) {
        print('Key "for_test" deleted successfully');
      }
    } else {
      if (kDebugMode) {
        print('Key "for_test" does not exist in the document');
      }
    }
  }
}
