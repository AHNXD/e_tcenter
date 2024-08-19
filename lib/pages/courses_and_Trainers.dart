import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/TrainerDetailsScreen.dart';
import 'package:e_tcenter/pages/courseDetails.dart';
import 'package:e_tcenter/services/apiService.dart';
import 'package:flutter/material.dart';

class CoursesAndTrainersPage extends StatelessWidget {
  static const routeName = '/coursesAndTrainers';
  const CoursesAndTrainersPage({super.key});

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
            color: appColor,
            padding: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'الكورسات والمدربين',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: 280,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      "assets/images/poster.png",
                    )),
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'الكورسات',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: ApiService.getAllCourses(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> courses =
                      snapshot.data as Map<String, dynamic>;

                  return Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: courses["courses"].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, CourseDetailsPage.routeName,
                                      arguments: courses['courses'][index]
                                          ['id']);
                                },
                                child: Container(
                                  width: 120,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          courses['courses'][index]['name'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            'السعر: \$${courses['courses'][index]['price']}',
                                            style:
                                                const TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'المعلمين',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: ApiService.getTeachersData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List trainers = snapshot.data as List;

                  return Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trainers.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, TrainerDetailsPage.routeName,
                                      arguments: trainers[index]['id']);
                                },
                                child: Container(
                                  width: 120,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 50,
                                          color: appColor,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          trainers[index]['full name'] ?? "",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          trainers[index]["specialization"],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
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
          ],
        ),
      ),
    );
  }
}
