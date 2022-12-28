import 'dart:io';

import 'package:final_projek/services/database/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/selected_photo_options_screen.dart';

class EditReadLater extends StatefulWidget {
  final documentId;
  final String currentTitle;
  final String currentAuthor;
  final int currentTotalPage;
  final String currentUrlCoverBook;
  final String currentReadingStatus;

  const EditReadLater({
    Key? key,
    this.documentId,
    required this.currentTitle,
    required this.currentAuthor,
    required this.currentTotalPage,
    required this.currentReadingStatus,
    required this.currentUrlCoverBook,
  }) : super(key: key);

  @override
  State<EditReadLater> createState() => _EditReadLaterState();
}

class _EditReadLaterState extends State<EditReadLater> {
  final _formKey = GlobalKey<FormState>();

  late var titleController = TextEditingController();
  late var authorController = TextEditingController();
  late var totalPageController = TextEditingController();

  File? _pickedImage;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _pickedImage = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
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
    titleController = TextEditingController(text: widget.currentTitle);
    authorController = TextEditingController(text: widget.currentAuthor);
    totalPageController =
        TextEditingController(text: widget.currentTotalPage.toString());
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

                  // Book Cover
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.19,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: _pickedImage == null 
                              ? ClipRect(
                                  child: Image(
                                    image: NetworkImage(
                                        widget.currentUrlCoverBook),
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
                  const SizedBox(
                    height: 16,
                  ),

                  // title form
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
                    keyboardType: TextInputType.number,
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
                              if (_formKey.currentState!.validate() &&
                                  _pickedImage == null) {
                                await Book.updateBook(
                                  title: titleController.text,
                                  author: authorController.text,
                                  totalPage:
                                      int.tryParse(totalPageController.text),
                                  readingStatus: widget.currentReadingStatus,
                                  docID: widget.documentId,
                                );
                                Navigator.of(context).pop();
                                // Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Book edited successfully'),
                                  ),
                                );
                              } else if (_formKey.currentState!.validate() &&
                                  _pickedImage != null) {
                                await Book.updateBookImage(
                                  title: titleController.text,
                                  author: authorController.text,
                                  totalPage:
                                      int.tryParse(totalPageController.text),
                                  readingStatus: widget.currentReadingStatus,
                                  bookCover: _pickedImage,
                                  docID: widget.documentId,
                                );
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Book edited successfully'),
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
