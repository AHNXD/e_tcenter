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
        title: const Text("الكورسات المشترك بها"),
        centerTitle: true,
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
                    Navigator.pushNamed(context, CourseDetailsPage.routeName,
                        arguments: {
                          "id": courses[index]["id"],
                          "teacher_id": courses[index]["teacher_id"]
                        });
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
