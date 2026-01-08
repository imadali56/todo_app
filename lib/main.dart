import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/splash_screen/splash_screen.dart';

void main() async {
  // 1. Flutter Hive initialization
  await Hive.initFlutter();

  // 2. Open the box
  var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo App',
      theme: ThemeData(
        // Yellow theme consistency ke liye
        primarySwatch: Colors.yellow,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}