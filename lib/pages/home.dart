import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/CoursesPage.dart';
import 'package:e_tcenter/pages/showSubscribedCourses.dart';
import 'package:flutter/material.dart';
import 'package:e_tcenter/pages/Trainers.dart';
import 'package:e_tcenter/pages/coursesCategories.dart';
import 'package:e_tcenter/pages/courses_and_Trainers.dart';
import 'package:e_tcenter/pages/settings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List myPages = [];
  List<Widget> myIcons = [];
  @override
  void initState() {
    super.initState();
    if (isGuest) {
      myPages = [
        const TrainersPage(),
        const CoursesCategoriesPage(),
        const CoursesAndTrainersPage(),
        const SettingsPage(),
      ];
      myIcons = [
        const Icon(Icons.person, size: 30, color: Colors.white),
        const Icon(Icons.category, size: 30, color: Colors.white),
        const Icon(Icons.home, size: 30, color: Colors.white),
        const Icon(Icons.settings, size: 30, color: Colors.white),
      ];
    } else if (isTeacher) {
      myPages = [
        const TrainersPage(),
        const CoursesCategoriesPage(),
        const CoursesAndTrainersPage(),
        const CourseForm(),
        const SettingsPage(),
      ];
      myIcons = [
        const Icon(Icons.person, size: 30, color: Colors.white),
        const Icon(Icons.category, size: 30, color: Colors.white),
        const Icon(Icons.home, size: 30, color: Colors.white),
        const Icon(Icons.edit, size: 30, color: Colors.white),
        const Icon(Icons.settings, size: 30, color: Colors.white),
      ];
    } else {
      myPages = [
        const TrainersPage(),
        const CoursesCategoriesPage(),
        const CoursesAndTrainersPage(),
        const ShowSubscribedCoursesPage(),
        const SettingsPage(),
      ];
      myIcons = [
        const Icon(Icons.person, size: 30, color: Colors.white),
        const Icon(Icons.category, size: 30, color: Colors.white),
        const Icon(Icons.home, size: 30, color: Colors.white),
        const Icon(Icons.favorite, size: 30, color: Colors.white),
        const Icon(Icons.settings, size: 30, color: Colors.white),
      ];
    }
  }

  int _page = 2;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: myIcons,
        color: const Color(0xFFF1AEFF),
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
          color: Colors.grey.shade200,
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(child: myPages[_page])),
    );
  }
}
