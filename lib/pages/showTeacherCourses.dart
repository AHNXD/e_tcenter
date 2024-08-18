import 'package:e_tcenter/constatnt.dart';
import 'package:flutter/material.dart';

class ShowTeacherCoursesPage extends StatefulWidget {
  static const routeName = '/ShowTeacherCourses';
  const ShowTeacherCoursesPage({super.key});

  @override
  State<ShowTeacherCoursesPage> createState() => _ShowTeacherCoursesPageState();
}

class _ShowTeacherCoursesPageState extends State<ShowTeacherCoursesPage> {
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
            color: appColor, //  يمكنك تغيير اللون
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'كورسات المدرس',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
