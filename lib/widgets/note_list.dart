import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_projek/pages/edit_note_page.dart';
import 'package:final_projek/services/database/note.dart';
import 'package:flutter/material.dart';

class NoteList extends StatelessWidget {
  final bookId;
  const NoteList({
    Key? key,
    this.bookId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Note.readNote(bookId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final documentSnapshot = snapshot.data!.docs[index];
              final String noteId = snapshot.data!.docs[index].id;
              String note = documentSnapshot['note'];
              int page = documentSnapshot['page'];
              String date = documentSnapshot['date'];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            date,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          PopupMenuButton<int>(
                            itemBuilder: (context) => [
                              // PopupMenuItem 1
                              PopupMenuItem(
                                value: 1,
                                // row with 2 children
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Edit This Note")
                                  ],
                                ),
                              ),
                              // PopupMenuItem 2
                              PopupMenuItem(
                                value: 2,
                                // row with two children
                                child: Row(
                                  children: const [
                                    Icon(Icons.delete),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Delete This Note")
                                  ],
                                ),
                              ),
                            ],
                            color: Colors.white,
                            elevation: 2,
                            iconSize: 15,
                            // on selected we show the dialog box
                            onSelected: (value) {
                              // if value 1 show dialog
                              if (value == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNotePage(
                                      noteId: noteId,
                                      bookId: bookId,
                                      currentNote: note,
                                      currentPage: page,
                                      currentDate: date,
                                    ),
                                  ),
                                );
                                // if value 2 show dialog
                              } else if (value == 2) {
                                // delete book
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Delete"),
                                    content: const Text(
                                      "Are you sure to delete this note? ",
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await Note.deleteBook(bookId, noteId);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Yes"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      Text(
                        ('Page: ' + page.toString()),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          note,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
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
