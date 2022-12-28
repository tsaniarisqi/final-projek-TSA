import 'package:final_projek/pages/add_note_page.dart';
import 'package:final_projek/pages/edit/edit_finished_page.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/widgets/note_list.dart';
import 'package:flutter/material.dart';

class DetailFinishedBook extends StatefulWidget {
  final documentId;
  final String title;
  final String author;
  final int totalPage;
  final String readingStatus;
  final String urlCoverBook;
  final String startReadingDate;
  final String finishReadingDate;
  final String year;

  const DetailFinishedBook({
    Key? key,
    required this.documentId,
    required this.title,
    required this.author,
    required this.totalPage,
    required this.readingStatus,
    required this.urlCoverBook,
    required this.startReadingDate,
    required this.finishReadingDate,
    required this.year,
  }) : super(key: key);

  @override
  State<DetailFinishedBook> createState() => _DetailFinishedBookState();
}

class _DetailFinishedBookState extends State<DetailFinishedBook> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
                  value: 1,
                  // row with 2 children
                  child: Row(
                    children: const [
                      Icon(Icons.info),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Book Details")
                    ],
                  ),
                ),
                // PopupMenuItem 2
                PopupMenuItem(
                  value: 2,
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
                  value: 3,
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
                  _details(context);
                  // if value 2 show dialog
                } else if (value == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditFinishedPage(
                        documentId: widget.documentId,
                        currentTitle: widget.title,
                        currentAuthor: widget.author,
                        currentTotalPage: widget.totalPage,
                        currentReadingStatus: widget.readingStatus,
                        currentUrlCoverBook: widget.urlCoverBook,
                        currentStartReadingDate: widget.startReadingDate,
                        currentFinishReadingDate: widget.finishReadingDate,
                        year: widget.year,
                      ),
                    ),
                  );
                  // if value 3 show dialog
                } else if (value == 3) {
                  // delete book
                  _delete(context);
                }
              },
            ),
          ],
        ),
        // button add note
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xffC5930B),
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
                    'Finished',
                    style: TextStyle(fontSize: 15, color: Colors.black45),
                  ),
                ),

                // bintang

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

  _delete(BuildContext context) async {
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
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Book deleted successfully'),
                ),
              );
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _details(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Book Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Text(
                'Title : ' + widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Text(
                'Author : ' + widget.author,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Text(
                'Total Page : ' + widget.totalPage.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Text(
                'Reading Status : ' + widget.readingStatus,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Text(
                'Start Reading : ' + widget.startReadingDate,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            Text(
              'Finish Reading : ' + widget.finishReadingDate,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
          )
        ],
      ),
    );
  }
}
