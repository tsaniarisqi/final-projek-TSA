import 'package:final_projek/services/database/book.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditFinishedPage extends StatefulWidget {
  final documentId;
  final String currentTitle;
  final String currentAuthor;
  final int currentTotalPage;
  final String currentReadingStatus;
  final String currentStartReadingDate;
  final String currentFinishReadingDate;
  final String year;

  const EditFinishedPage({
    Key? key,
    this.documentId,
    required this.currentTitle,
    required this.currentAuthor,
    required this.currentTotalPage,
    required this.currentReadingStatus,
    required this.currentStartReadingDate,
    required this.currentFinishReadingDate,
    required this.year,
  }) : super(key: key);

  @override
  State<EditFinishedPage> createState() => _EditFinishedPageState();
}

class _EditFinishedPageState extends State<EditFinishedPage> {
  final _formKey = GlobalKey<FormState>();

  late var titleController = TextEditingController();
  late var authorController = TextEditingController();
  late var totalPageController = TextEditingController();
  late var startReadingDateController = TextEditingController();
  late var finishReadingDateController = TextEditingController();
  late var yearController = TextEditingController();

  DateTime? _dateTimeStart;
  DateTime? _dateTimeFinish;
  DateTime? _yearFinish;

  void _showDatePicker1() {
    if (widget.currentStartReadingDate == "") {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      ).then((value) {
        setState(() {
          _dateTimeStart = value!;
          startReadingDateController.text =
              DateFormat('dd MMM yyyy').format(_dateTimeStart!);
        });
      });
    } else {
      showDatePicker(
        context: context,
        initialDate:
            DateFormat('dd MMM yyyy').parse(widget.currentStartReadingDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      ).then((value) {
        setState(() {
          _dateTimeStart = value!;
          startReadingDateController.text =
              DateFormat('dd MMM yyyy').format(_dateTimeStart!);
        });
      });
    }
  }

  void _showDatePicker2() {
    if (widget.currentFinishReadingDate == "") {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      ).then((value) {
        setState(() {
          _dateTimeFinish = value;
          _yearFinish = value;
          finishReadingDateController.text =
              DateFormat('dd MMM yyyy').format(_dateTimeFinish!);
          yearController.text = DateFormat('yyyy').format(_yearFinish!);
        });
      });
    } else {
      showDatePicker(
        context: context,
        initialDate:
            DateFormat('dd MMM yyyy').parse(widget.currentFinishReadingDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      ).then((value) {
        setState(() {
          _dateTimeFinish = value!;
          _yearFinish = value;
          finishReadingDateController.text =
              DateFormat('dd MMM yyyy').format(_dateTimeFinish!);
          yearController.text = DateFormat('yyyy').format(_yearFinish!);
        });
      });
    }
  }

  @override
  void initState() {
    titleController = TextEditingController(text: widget.currentTitle);
    authorController = TextEditingController(text: widget.currentAuthor);
    totalPageController =
        TextEditingController(text: widget.currentTotalPage.toString());
    startReadingDateController =
        TextEditingController(text: widget.currentStartReadingDate);
    finishReadingDateController =
        TextEditingController(text: widget.currentFinishReadingDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill this section';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill this section';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill this section';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // start reading date
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: startReadingDateController,
                    decoration: InputDecoration(
                      labelText: 'Start Reading Date',
                      suffixIcon: const Icon(Icons.calendar_today_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusColor: const Color(0xffC5930B),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill this section';
                      }
                      return null;
                    },
                    onTap: () {
                      // Below line stops keyboard from appearing
                      FocusScope.of(context).requestFocus(FocusNode());
                      _showDatePicker1();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // finished reading date
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: finishReadingDateController,
                    decoration: InputDecoration(
                      labelText: 'Finish Reading Date',
                      suffixIcon: const Icon(Icons.calendar_today_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusColor: const Color(0xffC5930B),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill this section';
                      }
                      return null;
                    },
                    onTap: () {
                      // Below line stops keyboard from appearing
                      FocusScope.of(context).requestFocus(FocusNode());
                      _showDatePicker2();
                    },
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
                                fontSize: 18,
                                letterSpacing: 3,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: const Color(0xffC5930B),
                            ),
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
                                fontSize: 18,
                                letterSpacing: 3,
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  Book.updateBook(
                                    title: titleController.text,
                                    author: authorController.text,
                                    totalPage:
                                        int.tryParse(totalPageController.text),
                                    readingStatus: widget.currentReadingStatus,
                                    docID: widget.documentId,
                                    startReadingDate:
                                        startReadingDateController.text,
                                    finishReadingDate:
                                        finishReadingDateController.text,
                                    year: yearController.text,
                                  );
                                  Navigator.of(context).pop();
                                  // Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Book edited successfully'),
                                    ),
                                  );
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: const Color(0xffC5930B),
                            ),
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
