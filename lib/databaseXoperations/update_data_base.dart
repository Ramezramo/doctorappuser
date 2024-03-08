import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
Future<void> dataBaseUpdater() async {
  print("in database updater");
  FirebaseFirestore db = FirebaseFirestore.instance;
  var userDocRef = db.collection('users').doc('teKESef7NCcCZwGgZzjSlfVsNgG2');
  // added

  String bookName = "leave the world behind";
  String pageNAme = "page_35";
  Map theData = {};

  // Get the current data
  try {
    DocumentSnapshot userDoc = await userDocRef.get();
    Map<String, dynamic>? theDataBaseAsJson = userDoc.data() as Map<String, dynamic>?;

    // Check if 'books' field exists
    if (theDataBaseAsJson != null && theDataBaseAsJson.containsKey('books')) {
      // If 'books' field exists, update it by adding a new page
      Map<String, dynamic> booksData = theDataBaseAsJson['books'];
      booksData[bookName] ??= {};
      booksData[bookName][pageNAme] = theData;

      // Atomically update the 'books' field with the modified data
      await userDocRef.update({
        "books": booksData,
      });
    } else {
      // If 'books' field doesn't exist, create it with the new page
      await userDocRef.update({
        "books": {
          bookName: {
            pageNAme : theData,
          },
        },
      });
    }

    print("Supposed to be updated");
    print(pageNAme);
  } catch (e) {
    print("Error updating document: $e");
  }
}



void updateTheUserTranslation(phraseRandomName,bookName, pageName, theTranslation) async {
  print("in data base updater");
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Replace 'teKESef7NCcCZwGgZzjSlfVsNgG2' with the actual user ID
  String userId = 'teKESef7NCcCZwGgZzjSlfVsNgG2';

  // Reference to the specific document
  DocumentReference userRef = db.collection('users').doc(userId);

  // Update the specific field
  try {
    await userRef.update({
      'books.$bookName.$pageName.$phraseRandomName.user_english_phrase': theTranslation,
    });

    print('User translation updated successfully.');
  } catch (e) {
    print('Error updating user translation: $e');
  }
}
