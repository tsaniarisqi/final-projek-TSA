import 'package:final_projek/pages/login_page.dart';
import 'package:final_projek/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reading Tracker',
      home: AuthService(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}
