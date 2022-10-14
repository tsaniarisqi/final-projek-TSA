import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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
                  autofocus: true,
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

                // submit button
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
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