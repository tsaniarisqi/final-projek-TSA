import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('readingList');
final user = FirebaseAuth.instance.currentUser;

class Note {
  static Future<void> addNote({
    String? note,
    int? page,
    String? date,
    String? docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user?.uid).collection('books').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'note': note,
      'page': page,
      'date': date,
    };

    await documentReferencer
        .collection('notes')
        .doc()
        .set(data)
        .whenComplete(() => print("Note detail added to the database"))
        .catchError((e) => print(e));
  }

  // read Give Up book
  static Stream<QuerySnapshot> readNote(String documentId) {
    // String? documentId;

    CollectionReference noteCollection = _mainCollection
        .doc(user?.uid)
        .collection('books')
        .doc(documentId)
        .collection('notes');

    return noteCollection.orderBy('date').snapshots();
  }
}
