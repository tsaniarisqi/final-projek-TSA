import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/widgets/reading_status.dart';
import 'package:flutter/material.dart';

class ReadLateCard extends StatefulWidget {
  const ReadLateCard({Key? key}) : super(key: key);

  @override
  State<ReadLateCard> createState() => _ReadLateCardState();
}

class _ReadLateCardState extends State<ReadLateCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Book.readLaterBook(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          final documentSnapshot = snapshot.data!.docs;
          var total = documentSnapshot.length.toString();
          return StatusCard(
            img: 'img/books.png',
            title: total.toString(),
            subTitle: 'To Read Later',
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.black,
            ),
          ),
        );
      },
    );
  }
}
