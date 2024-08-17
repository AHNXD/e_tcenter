import 'package:e_tcenter/pages/CoursesPage.dart';
import 'package:e_tcenter/pages/charge_wallet.dart';
import 'package:flutter/material.dart';
import 'package:e_tcenter/pages/Trainers.dart';
import 'package:e_tcenter/pages/coursesCategories.dart';
import 'package:e_tcenter/pages/courses_and_Trainers.dart';
import 'package:e_tcenter/pages/home.dart';
import 'package:e_tcenter/pages/settings.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'E-TCenter',
      theme: ThemeData(
        cardColor: const Color(0xFFF1AEFF),
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        CoursesAndTrainersPage.routeName: (context) =>
            const CoursesAndTrainersPage(),
        CoursesCategoriesPage.routeName: (context) =>
            const CoursesCategoriesPage(),
        CourseForm.routeName: (context) => const CourseForm(),
        HomePage.routeName: (context) => const HomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        TrainersPage.routeName: (context) => const TrainersPage(),
        ChargeWalletPage.routeName: (context) => ChargeWalletPage()
      },
    );
  }
}
