import 'package:flutter/material.dart';

class DetailCurrentlyReadingBook extends StatefulWidget {
  const DetailCurrentlyReadingBook({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      style: TextStyle(fontSize: 25, color: Colors.amber)),
                  const Text(' / 200', style: TextStyle(fontSize: 17)),
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
              Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: -19,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Notes',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_vert,
                            size: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: -19,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Notes',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_vert,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
