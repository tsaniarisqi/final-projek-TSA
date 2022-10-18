import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('readingList');
final user = FirebaseAuth.instance.currentUser;

class Book {
  // tambah data buku
  static Future<void> addBook(
      {String? title,
      String? author,
      int? totalPage,
      String? readingStatus}) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user?.uid).collection('books').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "author": author,
      "totalPage": totalPage,
      "readingStatus": readingStatus
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
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user?.uid).collection('books').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Book deleted from the database'))
        .catchError((e) => print(e));
  }
}
