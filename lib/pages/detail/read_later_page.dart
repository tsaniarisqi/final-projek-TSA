import 'package:final_projek/pages/edit_book_page.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:flutter/material.dart';

class DetailReadLaterBook extends StatefulWidget {
  final documentId;
  final String title;
  final String author;
  final int totalPage;
  final String readingStatus;

  const DetailReadLaterBook({
    Key? key,
    this.documentId,
    required this.title,
    required this.author,
    required this.totalPage,
    required this.readingStatus,
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
                            await Book.deleteBook(docId: widget.documentId);
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
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // cover
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Center(
                  child: Image(
                    height: 300,
                    image: AssetImage('img/cover.jpeg'),
                  ),
                ),
              ),
              // title
              Padding(
                padding: EdgeInsets.only(bottom: 4.0),
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
                padding: EdgeInsets.only(bottom: 8.0),
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
                  'To Read Later',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
            ],
          ),
        ),
      ),
    );
  }
}
