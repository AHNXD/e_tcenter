import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/courseDetails.dart';
import 'package:e_tcenter/services/apiService.dart';

import 'package:flutter/material.dart';

class ShowSubscribedCoursesPage extends StatefulWidget {
  static const routeName = '/ShowSubscribedCourses';
  const ShowSubscribedCoursesPage({super.key});

  @override
  State<ShowSubscribedCoursesPage> createState() =>
      _ShowSubscribedCoursesPageState();
}

class _ShowSubscribedCoursesPageState extends State<ShowSubscribedCoursesPage> {
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
            color: appColor, // Replace with your desired color
            padding: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.bottomCenter,
            child: const Text(
              "الكورسات المشترك بها",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: ApiService.getSubscribedCourses(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var courses = snapshot.data;
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CourseDetailsPage.routeName,
                      arguments: courses[index]["id"],
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.book,
                          color: appColor,
                        ),
                        Column(
                          children: [
                            Text(courses[index]["name"]),
                            Text(courses[index]["discription"]),
                          ],
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: appColor,
              ),
            );
          }
        },
      ),
    );
  }
}
