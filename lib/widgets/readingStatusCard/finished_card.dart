import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/widgets/reading_status.dart';
import 'package:flutter/material.dart';

class FinishedCard extends StatefulWidget {
  const FinishedCard({Key? key}) : super(key: key);

  @override
  State<FinishedCard> createState() => _FinishedCardState();
}

class _FinishedCardState extends State<FinishedCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Book.readFinishedBook(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          final documentSnapshot = snapshot.data!.docs;
          var total = documentSnapshot.length.toString();
          return StatusCard(
            img: 'img/book_finished.png',
            title: total.toString(),
            subTitle: 'Finished',
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
