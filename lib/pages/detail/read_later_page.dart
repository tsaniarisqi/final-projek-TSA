import 'package:final_projek/pages/add_note_page.dart';
import 'package:final_projek/pages/edit_book_page.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/widgets/note_list.dart';
import 'package:flutter/material.dart';

class DetailReadLaterBook extends StatefulWidget {
  final documentId;
  final String title;
  final String author;
  final int totalPage;
  final String readingStatus;
  final String urlCoverBook;

  const DetailReadLaterBook({
    Key? key,
    this.documentId,
    required this.title,
    required this.author,
    required this.totalPage,
    required this.readingStatus,
    required this.urlCoverBook,
  }) : super(key: key);

  @override
  State<DetailReadLaterBook> createState() => _DetailReadLaterBookState();
}

class _DetailReadLaterBookState extends State<DetailReadLaterBook> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: const Text(
            'Detail',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          actions: [
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
                      Text("Edit This Book")
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
                      Text("Delete This Book")
                    ],
                  ),
                ),
              ],
              color: Colors.white,
              elevation: 2,
              // on selected we show the dialog box
              onSelected: (value) {
                // if value 1 show dialog
                if (value == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(
                        documentId: widget.documentId,
                        currentTitle: widget.title,
                        currentAuthor: widget.author,
                        currentTotalPage: widget.totalPage,
                        currentReadingStatus: widget.readingStatus,
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
                      content: const Text("Are you sure to delete this book? "),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Book.deleteBook(
                              docId: widget.documentId,
                              title: widget.title,
                            );
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
        // button add note
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNote(
                  documentId: widget.documentId,
                ),
              ),
            );
          },
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // cover
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 30,
                      top: 8,
                    ),
                    height: MediaQuery.of(context).size.height * 0.32,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 29,
                                offset: const Offset(8, 8),
                                spreadRadius: 3,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 25,
                                offset: const Offset(-8, -8),
                                // spreadRadius: 3,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: NetworkImage(
                                widget.urlCoverBook,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // title
                Center(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // author
                Center(
                  child: Text(
                    'By ' + widget.author,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                //status
                const Center(
                  child: Text(
                    'To Read Later',
                    style: TextStyle(fontSize: 15, color: Colors.black45),
                  ),
                ),
                // button
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                //notes
                const Text(
                  'Notes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: NoteList(bookId: widget.documentId),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
