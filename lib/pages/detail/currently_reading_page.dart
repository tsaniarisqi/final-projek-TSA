import 'package:final_projek/pages/add_note_page.dart';
import 'package:final_projek/pages/edit_book_page.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/widgets/note_list.dart';
import 'package:flutter/material.dart';

class DetailCurrentlyReadingBook extends StatefulWidget {
  final documentId;
  final String title;
  final String author;
  final int totalPage;
  final String readingStatus;
  final String urlCoverBook;

  const DetailCurrentlyReadingBook({
    Key? key,
    this.documentId,
    required this.title,
    required this.author,
    required this.totalPage,
    required this.readingStatus,
    required this.urlCoverBook,
  }) : super(key: key);

  @override
  State<DetailCurrentlyReadingBook> createState() =>
      _DetailCurrentlyReadingBookState();
}

class _DetailCurrentlyReadingBookState
    extends State<DetailCurrentlyReadingBook> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
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
          padding: const EdgeInsets.all(8),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // cover
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Center(
                    child: Image(
                      height: 300,
                      image: NetworkImage(widget.urlCoverBook),
                    ),
                  ),
                ),
                // title
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                // author
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Center(
                    child: Text(
                      widget.author,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45),
                    ),
                  ),
                ),
                //status
                const Center(
                  child: Text(
                    'Currently Reading',
                    style: TextStyle(fontSize: 18, color: Colors.black45),
                  ),
                ),
                // Progres Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Pages', style: TextStyle(fontSize: 17)),
                    const Text(' 20',
                        style: TextStyle(fontSize: 20, color: Colors.amber)),
                    Text('/ ' + widget.totalPage.toString(),
                        style: const TextStyle(fontSize: 17)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 17,
                      ),
                    ),
                  ],
                ),
                //notes
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Notes',
                    style: TextStyle(fontSize: 20),
                  ),
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
