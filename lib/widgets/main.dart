import 'package:flutter/material.dart';
import 'package:todolist_app/widgets/login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 53, 109)),
        scaffoldBackgroundColor: Color.fromARGB(239, 193, 193, 199),
      ),
      home: const Login(),
    );
  }
}
