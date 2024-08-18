import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/showCoursesFromCategory.dart';
import 'package:e_tcenter/services/apiService.dart';

import 'package:flutter/material.dart';

class CoursesCategoriesPage extends StatelessWidget {
  static const routeName = '/courses';
  const CoursesCategoriesPage({super.key});

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
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'أنواع الكورسات',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: ApiService.getAllCategories(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var categories = snapshot.data["categories"];
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ShowCoursesFromCategoryPage.routeName,
                          arguments: {
                            "id": categories[index]["id"],
                            "name": categories[index]["name"]
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 197, 197, 197),
                          borderRadius: BorderRadius.circular(50)),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 64,
                            color: appColor,
                          ),
                          Text(categories[index]["name"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Icon(
                            Icons.category_outlined,
                            size: 64,
                            color: appColor,
                          ),
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
      ),
    );
  }
}
