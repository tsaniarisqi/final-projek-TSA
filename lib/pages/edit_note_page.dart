import 'dart:io';

import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/services/database/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../widgets/selected_photo_options_screen.dart';

class EditNotePage extends StatefulWidget {
  final noteId;
  final bookId;
  final String currentNote;
  final int currentPage;
  final String currentDate;
  final String currentUrlNote;

  const EditNotePage({
    Key? key,
    this.noteId,
    this.bookId,
    required this.currentNote,
    required this.currentPage,
    required this.currentDate,
    required this.currentUrlNote,
  }) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _editNoteFormKey = GlobalKey<FormState>();

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

  File? _pickedImage;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _pickedImage = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectedPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
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
          key: _editNoteFormKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  // note
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
                    maxLines: 10,
                    minLines: 5,
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

                  // page
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

                  // date
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
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
                      _showDatePicker();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Note Image
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Center(
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.19,
                        // width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: _pickedImage == null
                              ? ClipRect(
                                  child: Image(
                                    image: NetworkImage(widget.currentUrlNote),
                                    fit: BoxFit.fitHeight,
                                  ),
                                )
                              : ClipRect(
                                  child: Image(
                                    image: FileImage(_pickedImage!),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 3,
                  // ),

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
                              if (_editNoteFormKey.currentState!.validate() &&
                                  _pickedImage == null) {
                                await Note.updateNote(
                                  note: noteController.text,
                                  page: int.tryParse(pageController.text),
                                  date: dateController.text,
                                  noteId: widget.noteId,
                                  bookId: widget.bookId,
                                );
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Note edited successfully'),
                                  ),
                                );
                              } else if (_editNoteFormKey.currentState!
                                      .validate() &&
                                  _pickedImage != null) {
                                await Note.updateNoteImg(
                                  note: noteController.text,
                                  page: int.tryParse(pageController.text),
                                  date: dateController.text,
                                  noteId: widget.noteId,
                                  bookId: widget.bookId,
                                  noteImg: _pickedImage,
                                );
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Note edited successfully'),
                                  ),
                                );
                              }
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
