import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/widgets/reading_status.dart';
import 'package:flutter/material.dart';

class GiveUpCard extends StatefulWidget {
  const GiveUpCard({Key? key}) : super(key: key);

  @override
  State<GiveUpCard> createState() => _GiveUpCardState();
}

class _GiveUpCardState extends State<GiveUpCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Book.readGiveupBook(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          final documentSnapshot = snapshot.data!.docs;
          var total = documentSnapshot.length.toString();
          return StatusCard(
            img: 'img/cancel.png',
            title: total.toString(),
            subTitle: 'Give Up',
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
