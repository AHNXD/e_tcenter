import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/services/apiService.dart';
import 'package:flutter/material.dart';

class CourseDetailsPage extends StatefulWidget {
  static const routeName = '/courseDetails';
  const CourseDetailsPage({super.key});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Map id = ModalRoute.of(context)!.settings.arguments as Map;
    return FutureBuilder(
      future: ApiService.getCourseDetail(id["id"]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var course = snapshot.data["course"];
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                int state =
                    await ApiService.subscribe(studentData.id, id["id"]);
                if (state == 200) {
                  state = await ApiService.getStudentWallet(studentData.id);
                  message("Succes.", Colors.green, context);
                } else if (state == 400) {
                  message("You dont have enough money in your wallet.",
                      Colors.red, context);
                } else {
                  message(
                      "There was an error with subscribtion please try again.",
                      Colors.red,
                      context);
                }
              },
              child:
                  const Icon(Icons.add), // if the couse here make it Icon.check
            ),
            appBar: AppBar(
              title: Text(course["course_name"]),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                children: [
                  Text("Teacher Name: ${course["teacher_name"]}"),
                  Text("Description: ${course["description"]}"),
                  Text("Price: ${course["price"]}"),
                  Text("Lang: ${course["category"]}"),
                ],
              ),
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
    );
  }
}
