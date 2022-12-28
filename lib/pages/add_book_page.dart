import 'dart:io';

import 'package:final_projek/pages/main_page.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:final_projek/widgets/selected_photo_options_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _addBookFormKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final totalPageController = TextEditingController();
  final readingStatusList = [
    'Currently Reading',
    'To Read Later',
    'Finished',
    'Give Up'
  ];
  String? selectedVal = '';
  File? _pickedImage;

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _addBookFormKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add a Book',
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
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.camera_alt),
                                    Text('Add Cover')
                                  ],
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

                  // reading status dropdown
                  const SizedBox(
                    height: 8,
                  ),
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
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose this reading status';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // submit button
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_addBookFormKey.currentState!.validate() &&
                            _pickedImage != null) {
                          await Book.addBook(
                            title: titleController.text,
                            author: authorController.text,
                            totalPage: int.tryParse(totalPageController.text),
                            readingStatus: selectedVal,
                            bookCover: _pickedImage,
                            startReadingDate: "",
                            finishReadingDate: "",
                            year: "",
                            currentPage: 0,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Book added successfully'),
                            ),
                          );
                        } else if (_pickedImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill book cover'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 3,
                        ),
                      ),
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
          ),
        ),
      ),
    );
  }
}
