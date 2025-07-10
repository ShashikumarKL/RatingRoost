import 'package:flutter/material.dart';
import 'screens/book_list_screen.dart';

void main() {
  runApp(const RatingRoostApp());
}

class RatingRoostApp extends StatelessWidget {
  const RatingRoostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RatingRoost',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BookListScreen(),
    );
  }
}
