import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_projek/pages/detail/currently_reading_page.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:flutter/material.dart';

class CurretlyReadingList extends StatelessWidget {
  const CurretlyReadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Book.readCurrentlyBook(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final documentSnapshot = snapshot.data!.docs[index];
              String title = documentSnapshot['title'];
              String author = documentSnapshot['author'];
              int totalPage = documentSnapshot['totalPage'];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailCurrentlyReadingBook(),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(top: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, top: 8, right: 8, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 90,
                          height: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('img/cover.jpeg'),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 10),
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 5),
                              child: Text(
                                author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
