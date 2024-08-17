import 'package:flutter/material.dart';
import 'package:e_tcenter/pages/CoursesPage.dart';
import 'package:e_tcenter/pages/Trainers.dart';

class CoursesAndTrainersPage extends StatelessWidget {
  static const routeName = '/coursesAndTrainers';
  const CoursesAndTrainersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الكورسات والمدربين'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.search, color: Color(0xFF77379C)),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseForm()),
                      );
                    },
                    child: const Text(
                      'THE COURSES',
                      style: TextStyle(
                          color: Color(0xFFBA63CB),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TrainersPage()),
                      );
                    },
                    child: const Text(
                      'THE TEACHER',
                      style: TextStyle(
                          color: Color(0xFFBA63CB),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
