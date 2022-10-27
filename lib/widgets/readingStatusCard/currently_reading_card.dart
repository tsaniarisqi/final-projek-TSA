import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/widgets/reading_status.dart';
import 'package:flutter/material.dart';

class CurrentlyReadingCard extends StatefulWidget {
  const CurrentlyReadingCard({Key? key}) : super(key: key);

  @override
  State<CurrentlyReadingCard> createState() => _CurrentlyReadingCardState();
}

class _CurrentlyReadingCardState extends State<CurrentlyReadingCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Book.readCurrentlyBook(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          final documentSnapshot = snapshot.data!.docs;
          var total = documentSnapshot.length.toString();
          return StatusCard(
            img: 'img/book.png',
            title: total.toString(),
            subTitle: 'Currently Reading',
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
