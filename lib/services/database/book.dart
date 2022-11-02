import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('readingList');
final user = FirebaseAuth.instance.currentUser;

class Book {
  // tambah data buku
  static Future<void> addBook({
    String? title,
    String? author,
    int? totalPage,
    String? readingStatus,
    String? urlBookCover,
    File? bookCover,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user?.uid).collection('books').doc();
    final ref =
        FirebaseStorage.instance.ref().child('cover').child(title! + '.jpg');
    await ref.putFile(bookCover!);
    urlBookCover = await ref.getDownloadURL();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "author": author,
      "totalPage": totalPage,
      "readingStatus": readingStatus,
      "bookCover": urlBookCover
    };
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Book detail added to the database"))
        .catchError((e) => print(e));
  }

  // read currently reading book
  static Stream<QuerySnapshot> readCurrentlyBook() {
    CollectionReference bookCollection =
        _mainCollection.doc(user?.uid).collection('books');

    return bookCollection
        .where('readingStatus', isEqualTo: 'Currently Reading')
        .orderBy('title')
        .snapshots();
  }

  // read To Read Later book
  static Stream<QuerySnapshot> readLaterBook() {
    CollectionReference bookCollection =
        _mainCollection.doc(user?.uid).collection('books');

    return bookCollection
        .where('readingStatus', isEqualTo: 'To Read Later')
        .orderBy('title')
        .snapshots();
  }

  // read Finished book
  static Stream<QuerySnapshot> readFinishedBook() {
    CollectionReference bookCollection =
        _mainCollection.doc(user?.uid).collection('books');

    return bookCollection
        .where('readingStatus', isEqualTo: 'Finished')
        .orderBy('title')
        .snapshots();
  }

  // read Give Up book
  static Stream<QuerySnapshot> readGiveupBook() {
    CollectionReference bookCollection =
        _mainCollection.doc(user?.uid).collection('books');

    return bookCollection
        .where('readingStatus', isEqualTo: 'Give Up')
        .orderBy('title')
        .snapshots();
  }

  // delete book
  static Future<void> deleteBook({
    String? docId,
    String? title,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user?.uid).collection('books').doc(docId);
    final ref =
        FirebaseStorage.instance.ref().child('cover').child(title! + '.jpg');
    await ref.delete();

    await documentReferencer
        .delete()
        .whenComplete(() => print('Book deleted from the database'))
        .catchError((e) => print(e));
  }

  // edit book
  static Future<void> updateBook({
    String? title,
    String? author,
    int? totalPage,
    String? readingStatus,
    String? docID,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user?.uid).collection('books').doc(docID);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "author": author,
      "totalPage": totalPage,
      "readingStatus": readingStatus
    };

    await documentReferencer
        .update(data)
        // .set(data, SetOptions(merge: true))
        .whenComplete(() => print("Book updated in the database"))
        .catchError((e) => print(e));
  }

  // Button Start Reading
  static Future<void> startReading({
    String? readingStatus,
    String? docID,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user?.uid).collection('books').doc(docID);

    Map<String, dynamic> data = <String, dynamic>{
      "readingStatus": readingStatus
    };

    await documentReferencer
        .update(data)
        // .set(data, SetOptions(merge: true))
        .whenComplete(() => print("Book updated in the database"))
        .catchError((e) => print(e));
  }
}
