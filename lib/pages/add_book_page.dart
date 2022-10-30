import 'package:final_projek/pages/main_page.dart';
import 'package:final_projek/services/database/book.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _addBookFormKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title form
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
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_addBookFormKey.currentState!.validate()) {
                        await Book.addBook(
                          title: titleController.text,
                          author: authorController.text,
                          totalPage: int.tryParse(totalPageController.text),
                          readingStatus: selectedVal,
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
                      }
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
