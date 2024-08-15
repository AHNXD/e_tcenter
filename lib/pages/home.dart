import 'package:flutter/material.dart';
import 'package:e_tcenter/pages/CoursesPage.dart';
import 'package:e_tcenter/pages/Trainers.dart';
import 'package:e_tcenter/pages/courses.dart';
import 'package:e_tcenter/pages/courses_and_Trainers.dart';
import 'package:e_tcenter/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [
    const TrainersPage(),
    const CoursesPage(),
    const CoursesAndTrainersPage(),
    const CourseForm(),
    const ProfilePage(),
  ];

  int _page = 2;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.person, size: 30, color: Colors.white),
          Icon(Icons.category, size: 30, color: Colors.white),
          Icon(Icons.book, size: 30, color: Colors.white),
          Icon(Icons.edit, size: 30, color: Colors.white),
          Icon(Icons.data_array, size: 30, color: Colors.white),
        ],
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
          child: SafeArea(child: pages[_page])),
    );
  }
}
