import 'package:e_tcenter/pages/CoursesPage.dart';
import 'package:flutter/material.dart';
import 'package:e_tcenter/pages/Trainers.dart';
import 'package:e_tcenter/pages/courses.dart';
import 'package:e_tcenter/pages/courses_and_Trainers.dart';
import 'package:e_tcenter/pages/home.dart';
import 'package:e_tcenter/pages/profile.dart';

import 'pages/login.dart';
import 'pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Teach',
      theme: ThemeData(
        cardColor: const Color(0xFFF1AEFF),
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        CoursesAndTrainersPage.routeName: (context) =>
            const CoursesAndTrainersPage(),
        CoursesPage.routeName: (context) => const CoursesPage(),
        CourseForm.routeName: (context) => const CourseForm(),
        HomePage.routeName: (context) => const HomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        TrainersPage.routeName: (context) => const TrainersPage()
      },
    );
  }
}
