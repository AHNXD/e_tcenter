import 'package:flutter/material.dart';

class ShowCoursesFromCategoryPage extends StatefulWidget {
  static const routeName = '/showCoursesFromCategory';
  const ShowCoursesFromCategoryPage({super.key});

  @override
  State<ShowCoursesFromCategoryPage> createState() =>
      _ShowCoursesFromCategoryPageState();
}

class _ShowCoursesFromCategoryPageState
    extends State<ShowCoursesFromCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
        centerTitle: true,
      ),
    );
  }
}
