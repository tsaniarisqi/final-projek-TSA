import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  // Add note with image
  static Future<void> addNoteImg({
    String? note,
    int? page,
    String? date,
    String? docId,
    String? urlNote,
    File? noteImg,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user?.uid).collection('books').doc(docId);
        var time = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref('note/$time.png');
    await ref.putFile(noteImg!);
    urlNote = await ref.getDownloadURL();

    Map<String, dynamic> data = <String, dynamic>{
      'note': note,
      'page': page,
      'date': date,
      'noteImg': urlNote,
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

  // delete book
  static Future<void> deleteBook(bookId, noteId) async {
    // String? bookId,
    // String? noteId
    {
      DocumentReference documentReferencer = _mainCollection
          .doc(user?.uid)
          .collection('books')
          .doc(bookId)
          .collection('notes')
          .doc(noteId);

      await documentReferencer
          .delete()
          .whenComplete(() => print('Note deleted from the database'))
          .catchError((e) => print(e));
    }
  }

  // edit note
  static Future<void> updateNote({
    String? note,
    int? page,
    String? date,
    String? bookId,
    String? noteId,
  }) async {
    DocumentReference documentReferencer = _mainCollection
        .doc(user?.uid)
        .collection('books')
        .doc(bookId)
        .collection('notes')
        .doc(noteId);

    Map<String, dynamic> data = <String, dynamic>{
      'note': note,
      'page': page,
      'date': date,
    };

    await documentReferencer
        .update(data)
        // .set(data, SetOptions(merge: true))
        .whenComplete(() => print("Note updated in the database"))
        .catchError((e) => print(e));
  }
}
