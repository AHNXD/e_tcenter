import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/courseDetails.dart';
import 'package:e_tcenter/services/apiService.dart';
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
            padding: const EdgeInsets.only(bottom: 15),
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
      body: FutureBuilder(
        future: ApiService.getTeacherData(teacherData.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data["courses"];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CourseDetailsPage.routeName,
                        arguments: data[index]["id"],
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 197, 197, 197),
                          borderRadius: BorderRadius.circular(50)),
                      width: double.infinity,
                      height: 100,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.book,
                            color: appColor,
                            size: 64,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(data[index]["name"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text(data[index]["discription"],
                                  style: const TextStyle(fontSize: 16)),
                              Text("Price: ${data[index]["price"].toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: appColor))
                            ],
                          ),
                          const SizedBox()
                        ],
                      ),
                    ),
                  );
                },
              ),
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
