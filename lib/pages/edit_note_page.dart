import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/services/database/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditNotePage extends StatefulWidget {
  final noteId;
  final bookId;
  final String currentNote;
  final int currentPage;
  final String currentDate;

  const EditNotePage({
    Key? key,
    this.noteId,
    this.bookId,
    required this.currentNote,
    required this.currentPage,
    required this.currentDate,
  }) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late var noteController = TextEditingController();
  late var pageController = TextEditingController();
  late var dateController = TextEditingController();

  DateTime? _dateTime;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        dateController.text = DateFormat('dd MMM yyyy').format(_dateTime!);
      });
    });
  }

  @override
  void initState() {
    noteController = TextEditingController(text: widget.currentNote);
    pageController = TextEditingController(text: widget.currentPage.toString());
    dateController = TextEditingController(text: widget.currentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title form
                const Text(
                  'Edit a Note',
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
                  controller: noteController,
                  decoration: InputDecoration(
                    labelText: 'Note',
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
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  controller: pageController,
                  decoration: InputDecoration(
                    labelText: 'Page',
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
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today_rounded),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusColor: const Color(0xffC5930B),
                  ),
                  onTap: () {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(FocusNode());
                    _showDatePicker();
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
                            await Note.updateNote(
                              note: noteController.text,
                              page: int.tryParse(pageController.text),
                              date: dateController.text,
                              noteId: widget.noteId,
                              bookId: widget.bookId,
                            );
                            Navigator.of(context).pop();
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
    );
  }
}
