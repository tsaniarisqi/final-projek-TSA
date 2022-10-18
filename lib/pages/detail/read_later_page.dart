import 'package:flutter/material.dart';

class DetailReadLaterBook extends StatefulWidget {
  const DetailReadLaterBook({Key? key}) : super(key: key);

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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(),
                  //   ),
                  // );
                  // if value 2 show dialog
                } else if (value == 2) {
                  // delete book
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
              const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Center(
                  child: Text(
                    'Pulang',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              // author
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Center(
                  child: Text(
                    'By Tere Liye',
                    style: TextStyle(
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
