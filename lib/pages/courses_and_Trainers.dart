import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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
          FutureBuilder<Course>(
            future: fetchCourse(6), // هنا نستخدم ID الدورة
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('خطأ في تحميل البيانات'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('لا توجد معلومات عن الدورة'));
              }

              final course = snapshot.data!;

              return CourseCard(course: course);
            },
          ),
        ],
      ),
    );
  }

  Future<Course> fetchCourse(int id) async {
    var headers = {'Content-Type': 'application/json'};
    final response =
        await http.get(Uri.parse('http://192.168.227.168:8000/api/courses'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Course.fromJson(jsonResponse['course']);
    } else {
      throw Exception('فشل في تحميل البيانات');
    }
  }
}

class Course {
  final String teacherName;
  final String courseName;
  final String description;
  final double price;
  final String category;

  Course({
    required this.teacherName,
    required this.courseName,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      teacherName: json['teacher_name'],
      courseName: json['course_name'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.courseName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 8),
            Text('المدرس: ${course.teacherName}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('الوصف: ${course.description}',
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            Text('السعر: \$${course.price}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('الفئة: ${course.category}', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
