import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class TrainerDetailsPage extends StatelessWidget {
  static const routeName = '/trainerDet';
  const TrainerDetailsPage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Teacher>>(
        future: fetchTeachers(), // جلب بيانات المعلمين
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('خطأ في تحميل البيانات: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد معلومات عن المعلمين'));
          }

          final teachers = snapshot.data!;
          return TeacherCard(teacher: teachers[0]); // عرض المعلم الأول كمثال
        },
      ),
    );
  }

  Future<List<Teacher>> fetchTeachers() async {
    final response = await http.get(Uri.parse('http://192.168.227.168:8000/api/teacher/full-names'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['teachers'] != null) {
        List<Teacher> teachers = (jsonResponse['teachers'] as List)
            .map((teacherData) => Teacher.fromJson(teacherData))
            .toList();
        return teachers;
      } else {
        throw Exception('لا توجد بيانات للمعلمين');
      }
    } else {
      throw Exception('فشل في تحميل البيانات. الحالة: ${response.statusCode}');
    }
  }
}

class Teacher {
  final String? fullName;
  final String? previousPlaceOfWork;
  final String specialization;

  Teacher({
    required this.fullName,
    required this.previousPlaceOfWork,
    required this.specialization,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      fullName: json['full_name'],
      previousPlaceOfWork: json['previous_place_of_work'],
      specialization: json['specialization'],
    );
  }
}

class TeacherCard extends StatelessWidget {
  final Teacher teacher;

  const TeacherCard({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
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
            child: Column(
              children: [
                // الدائرة في الأعلى مع رمز الشخص
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                ),
                const SizedBox(height: 8),
                // اسم المدرب
                Text(
                  teacher.fullName ?? 'اسم غير متوفر',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // مستطيلان أسفل الاسم
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.book),
                              const SizedBox(width: 8),
                              Text(teacher.specialization),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              const SizedBox(width: 8),
                              Text(teacher.previousPlaceOfWork ?? 'غير متوفر'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // المستطيل النهدي
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // عدد الطلاب
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.group),
                    const SizedBox(height: 8),
                    Text('عدد الطلاب: 20'), // هنا يمكنك جلب العدد من الـ API
                    const Text('طالب'),
                  ],
                ),
                // عدد الدورات
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.video_library),
                    const SizedBox(height: 8),
                    Text('عدد الدورات: 5'), // هنا يمكنك جلب العدد من الـ API
                    const Text('دورات'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // نص الدورات في الأسفل
          Align(
            alignment: Alignment.topRight,
            child: Text(
              'الدورات:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // هنا يمكنك إضافة قائمة بالكورسات
          // مثال على قائمة بالكورسات
          Expanded(
            child: ListView.builder(
              itemCount: 5, // عدد الكورسات كمثال
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Course ${index + 1}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
