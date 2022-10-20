import 'package:final_projek/services/database/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNote extends StatefulWidget {
  final documentId;
  const AddNote({Key? key, this.documentId}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final noteController = TextEditingController();
  final pageController = TextEditingController();
  final dateController = TextEditingController();

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
                  'Add a Note',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
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

                // Page form
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

                // date
                const SizedBox(
                  height: 8,
                ),
                TextField(
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
                    hintText: 'Choose Date',
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

                // submit button
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Note.addNote(
                        note: noteController.text,
                        page: int.tryParse(pageController.text),
                        date: dateController.text,
                        docId: widget.documentId,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Submit',
                    ),
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
      ),
    );
  }
}