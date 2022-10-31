import 'package:final_projek/services/database/book.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final documentId;
  final String currentTitle;
  final String currentAuthor;
  final int currentTotalPage;
  final String currentReadingStatus;

  const EditPage({
    Key? key,
    this.documentId,
    required this.currentTitle,
    required this.currentAuthor,
    required this.currentTotalPage,
    required this.currentReadingStatus,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late var titleController = TextEditingController();
  late var authorController = TextEditingController();
  late var totalPageController = TextEditingController();
  late var readingStatusController = TextEditingController();

  List<String> readingStatusList = [
    'Currently Reading',
    'To Read Later',
    'Finished',
    'Give Up'
  ];
  String? selectedVal = '';

  @override
  void initState() {
    titleController = TextEditingController(text: widget.currentTitle);
    authorController = TextEditingController(text: widget.currentAuthor);
    totalPageController =
        TextEditingController(text: widget.currentTotalPage.toString());
    selectedVal = widget.currentReadingStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title form
                  const Text(
                    'Edit a Book',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // author form
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: authorController,
                    decoration: InputDecoration(
                      labelText: 'Author',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // number of page forms
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: totalPageController,
                    decoration: InputDecoration(
                      labelText: 'Total Page',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusColor: const Color(0xffC5930B),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // reading status dropdown
                  DropdownButtonFormField(
                    items: readingStatusList
                        .map(
                          (e) => DropdownMenuItem(child: Text(e), value: e),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedVal = val as String;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Reading Status',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // tombol batal
                        Container(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 3),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        // tombol simpan
                        Container(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 3),
                            ),
                            onPressed: () async {
                              if (selectedVal != null) {
                                await Book.updateBook(
                                  title: titleController.text,
                                  author: authorController.text,
                                  totalPage:
                                      int.tryParse(totalPageController.text),
                                  readingStatus: selectedVal,
                                  docID: widget.documentId,
                                );
                                Navigator.of(context).pop();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Message"),
                                    content: Text("Please choose a category"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
