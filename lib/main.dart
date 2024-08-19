import 'package:e_tcenter/pages/addVideo.dart';
import 'package:e_tcenter/pages/createCourse.dart';
import 'package:e_tcenter/pages/TrainerDetailsScreen.dart';
import 'package:e_tcenter/pages/charge_wallet.dart';
import 'package:e_tcenter/pages/courseDetails.dart';
import 'package:e_tcenter/pages/setYourIp.dart';
import 'package:e_tcenter/pages/showCoursesFromCategory.dart';
import 'package:e_tcenter/pages/showSubscribedCourses.dart';
import 'package:e_tcenter/pages/showTeacherCourses.dart';
import 'package:e_tcenter/pages/showVideo.dart';
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
          cardColor: const Color(0xFFF1AEFF), fontFamily: "cocon-next-arabic"),
      initialRoute: LoginPage.routeName,
      routes: {
        CoursesAndTrainersPage.routeName: (context) =>
            const CoursesAndTrainersPage(),
        CoursesCategoriesPage.routeName: (context) =>
            const CoursesCategoriesPage(),
        CreateCoursPage.routeName: (context) => const CreateCoursPage(),
        HomePage.routeName: (context) => const HomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        TrainersPage.routeName: (context) => const TrainersPage(),
        ChargeWalletPage.routeName: (context) => const ChargeWalletPage(),
        ShowCoursesFromCategoryPage.routeName: (context) =>
            const ShowCoursesFromCategoryPage(),
        CourseDetailsPage.routeName: (context) => const CourseDetailsPage(),
        ShowSubscribedCoursesPage.routeName: (context) =>
            const ShowSubscribedCoursesPage(),
        ShowVideoPage.routeName: (context) => const ShowVideoPage(),
        TrainerDetailsPage.routeName: (context) => const TrainerDetailsPage(),
        ShowTeacherCoursesPage.routeName: (context) =>
            const ShowTeacherCoursesPage(),
        AddVideoPage.routeName: (context) => const AddVideoPage(),
        SetYourIpPage.routeName: (context) => SetYourIpPage(),
      },
    );
  }
}
