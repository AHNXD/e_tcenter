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
        centerTitle: true,
        title: const Text('أنواع الكورسات'),
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
                          context, ShowCoursesFromCategoryPage.routeName);
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
              return CircularProgressIndicator(
                color: appColor,
              );
            }
          },
        ),
      ),
    );
  }
}
