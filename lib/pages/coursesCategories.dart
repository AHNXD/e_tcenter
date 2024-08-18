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
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          color: appColor, // Replace with your desired color
          padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
          alignment: Alignment.bottomCenter,
          child: Text(
            'أنواع الكورسات',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
                      margin: const EdgeInsets.all(16),
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 50,
                            color: appColor,
                          ),
                          Text(categories[index]["name"]),
                          Icon(
                            Icons.category_outlined,
                            size: 50,
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
