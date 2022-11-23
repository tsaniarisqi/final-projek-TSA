import 'package:final_projek/pages/add_note_page.dart';
import 'package:final_projek/pages/edit/edit_currently_reading_page.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/widgets/note_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailCurrentlyReadingBook extends StatefulWidget {
  final documentId;
  final String title;
  final String author;
  final int totalPage;
  final int currentPage;
  final String readingStatus;
  final String urlCoverBook;
  final String startReadingDate;

  const DetailCurrentlyReadingBook({
    Key? key,
    this.documentId,
    required this.title,
    required this.author,
    required this.totalPage,
    required this.currentPage,
    required this.readingStatus,
    required this.urlCoverBook,
    required this.startReadingDate,
  }) : super(key: key);

  @override
  State<DetailCurrentlyReadingBook> createState() =>
      _DetailCurrentlyReadingBookState();
}

class _DetailCurrentlyReadingBookState
    extends State<DetailCurrentlyReadingBook> {
  late var currentPageController = TextEditingController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPageController = TextEditingController(
      text: widget.currentPage.toString(),
    );
  }

  @override
  void dispose() {
    currentPageController.dispose();
    super.dispose();
  }

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
                // PopupMenuItem 3
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
                // PopupMenuItem 4
                PopupMenuItem(
                  value: 4,
                  // row with two children
                  child: Row(
                    children: const [
                      Icon(Icons.flag),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Give Up")
                    ],
                  ),
                ),
              ],
              color: Colors.white,
              elevation: 2,
              // on selected we show the dialog box
              onSelected: (value) async {
                // if value 1 show dialog
                if (value == 1) {
                  // detail book
                  _details(context);
                  // if value 2 show dialog
                } else if (value == 2) {
                  // edit book
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditCurrentlyReading(
                        documentId: widget.documentId,
                        currentTitle: widget.title,
                        currentAuthor: widget.author,
                        currentTotalPage: widget.totalPage,
                        currentReadingStatus: widget.readingStatus,
                        currentStartReadingDate: widget.startReadingDate,
                      ),
                    ),
                  );
                  // if value 3 show dialog
                } else if (value == 3) {
                  // delete book
                  _delete(context);
                } else if (value == 4) {
                  await Book.giveupReading(
                    readingStatus: 'Give Up',
                    docID: widget.documentId,
                  );
                  Navigator.of(context).pop();
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
                    'Currently Reading',
                    style: TextStyle(fontSize: 15, color: Colors.black45),
                  ),
                ),
                // Progres Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Pages ', style: TextStyle(fontSize: 17)),
                    Text(
                      widget.currentPage.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      ' / ' + widget.totalPage.toString(),
                      style: const TextStyle(fontSize: 17),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Current Page"),
                            content: TextFormField(
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'How much did you read?',
                              ),
                              controller: currentPageController,
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
                                  await Book.updateCurrentPage(
                                    docID: widget.documentId,
                                    currentPage: int.tryParse(
                                      currentPageController.text,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Current page update successfully',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 15,
                      ),
                    ),
                  ],
                ),
                // button
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Finish',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      var now = DateTime.now();
                      var formatedDate = DateFormat('dd MMM yyyy').format(now);
                      var yearFormate = DateFormat('yyyy').format(now);
                      await Book.finishReading(
                        readingStatus: 'Finished',
                        finishReadingDate: formatedDate,
                        year: yearFormate,
                        currentPage: widget.totalPage,
                        docID: widget.documentId,
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: const Color(0xffC5930B),
                    ),
                  ),
                ),
                //notes
                const SizedBox(
                  height: 8,
                ),
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
                'Pages Read : ' + widget.currentPage.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            Text(
              'Start Reading : ' + widget.startReadingDate,
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
