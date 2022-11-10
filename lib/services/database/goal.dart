import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('readingList');
final user = FirebaseAuth.instance.currentUser;

class Goal {
  static Future<void> addProgress({
    // int? year,
    String? goal,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user?.uid).collection('goals').doc();
    Map<String, dynamic> data = <String, dynamic>{
      // "year": year,
      "goal": goal,
    };
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Book detail added to the database"))
        .catchError((e) => print(e));
  }

  // read currently reading book
  static Stream<QuerySnapshot> readProgres() {
    CollectionReference bookCollection =
        _mainCollection.doc(user?.uid).collection('goals');

    return bookCollection.snapshots();
  }
}
