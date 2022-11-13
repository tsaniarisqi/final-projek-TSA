import 'package:final_projek/pages/home_page.dart';
import 'package:final_projek/pages/notes_page.dart';
import 'package:final_projek/pages/add_book_page.dart';
import 'package:final_projek/pages/profile_page.dart';
import 'package:final_projek/pages/statistic_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    // NotesPage(),
    AddPage(),
    // StatisticPage(),
    ProfilePage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        selectedFontSize: 12,
        selectedItemColor: const Color(0xffC5930B),
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          // BottomNavigationBarItem(label: 'Notes', icon: Icon(Icons.receipt)),
          BottomNavigationBarItem(label: 'Add', icon: Icon(Icons.add_circle)),
          // BottomNavigationBarItem(
          //     label: 'Statistic', icon: Icon(Icons.stacked_bar_chart)),
          BottomNavigationBarItem(
              label: 'Profile', icon: Icon(Icons.person_pin))
        ],
      ),
    );
  }
}
