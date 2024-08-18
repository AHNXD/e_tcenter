import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/courseDetails.dart';
import 'package:e_tcenter/services/apiService.dart';

import 'package:flutter/material.dart';

class ShowCoursesFromCategoryPage extends StatefulWidget {
  static const routeName = '/showCoursesFromCategory';
  const ShowCoursesFromCategoryPage({super.key});

  @override
  State<ShowCoursesFromCategoryPage> createState() =>
      _ShowCoursesFromCategoryPageState();
}

class _ShowCoursesFromCategoryPageState
    extends State<ShowCoursesFromCategoryPage> {
  @override
  Widget build(BuildContext context) {
    Map category = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          color: appColor, // Replace with your desired color
          padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
          alignment: Alignment.bottomCenter,
          child: Text(
            category["name"],
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ),
      body: FutureBuilder(
        future: ApiService.getCoursesByCategory(category["id"]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var cources = snapshot.data["course_names"];
            return ListView.builder(
              itemCount: cources.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CourseDetailsPage.routeName,
                        arguments: {
                          "id": cources[index]["id"],
                          "teacher_id": cources[index]["teacher_id"]
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
                            Text(cources[index]["name"]),
                            Text(cources[index]["discription"]),
                            Text(cources[index]["price"].toString())
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
