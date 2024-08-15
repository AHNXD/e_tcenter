import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  static const routeName = '/courses';
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('أنواع الكورسات'),
      ),
      body: const Center(
        child: Text(
          'هنا يمكنك رؤية أنواع الكورسات.',
          style: TextStyle(color: Colors.pink, fontSize: 20),
        ),
      ),
    );
  }
}
