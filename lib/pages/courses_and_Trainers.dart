import 'package:e_tcenter/constatnt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoursesAndTrainersPage extends StatelessWidget {
  static const routeName = '/coursesAndTrainers';
  const CoursesAndTrainersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: Container(
            color: appColor,
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'الكورسات والمدربين',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'الكورسات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Course>>(
              future: fetchCourses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('خطأ في تحميل البيانات: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('لا توجد معلومات عن الدورات'));
                }

                final courses = snapshot.data!;

                return Column(
                  children: [
                    Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return CourseCard(course: courses[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'المعلمين:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    FutureBuilder<List<Trainer>>(
                      future: fetchTrainers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                                  'خطأ في تحميل البيانات: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('لا توجد معلومات عن المعلمين'));
                        }

                        final trainers = snapshot.data!;

                        return Container(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: trainers.length,
                            itemBuilder: (context, index) {
                              return TrainerCard(trainer: trainers[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Course>> fetchCourses() async {
    var headers = {'Content-Type': 'application/json'};
    final response = await http.get(
        Uri.parse('http://192.168.45.33:8000/api/courses'),
        headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['courses'] != null) {
        List<Course> courses = (jsonResponse['courses'] as List)
            .map((courseData) => Course.fromJson(courseData))
            .toList();
        return courses;
      } else {
        throw Exception('لا توجد بيانات للدورات');
      }
    } else {
      throw Exception('فشل في تحميل البيانات. الحالة: ${response.statusCode}');
    }
  }

  Future<List<Trainer>> fetchTrainers() async {
    var headers = {'Content-Type': 'application/json'};
    final response = await http.get(
        Uri.parse('http://192.168.45.33:8000/api/teacher/search'),
        headers: headers); // تأكد من صحة الـ API

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['teachers'] != null) {
        List<Trainer> trainers = (jsonResponse['teachers'] as List)
            .map((trainerData) => Trainer.fromJson(trainerData))
            .toList();
        return trainers;
      } else {
        throw Exception('لا توجد بيانات للمعلمين');
      }
    } else {
      throw Exception('فشل في تحميل البيانات. الحالة: ${response.statusCode}');
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
      teacherName: json['teacher_name'] ?? 'Unknown',
      courseName: json['name'] ?? 'Unnamed Course',
      description: json['discription'] ?? 'No description available',
      price: json['price'].toDouble(),
      category: json['category_id'].toString(),
    );
  }
}

class Trainer {
  final String fullName; // اسم المعلم
  final String specialization; // تخصص المعلم
  final String email; // بريد المعلم

  Trainer({
    required this.fullName,
    required this.specialization,
    required this.email,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      fullName: json['full_name'] ?? 'Unnamed Teacher',
      specialization: json['specialization'] ?? 'No specialization',
      email: json['email'] ?? 'No email',
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.courseName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text('السعر: \$${course.price}',
                style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class TrainerCard extends StatelessWidget {
  final Trainer trainer;

  const TrainerCard({Key? key, required this.trainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              Icons.person,
              size: 50,
              color: appColor,
            ),
            const SizedBox(height: 8),
            Text(
              trainer.fullName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              trainer.specialization,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
