import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/addVideo.dart';
import 'package:e_tcenter/pages/showVideo.dart';
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
    int id = ModalRoute.of(context)!.settings.arguments as int;
    return FutureBuilder(
      future: ApiService.getCourseDetail(id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var course = snapshot.data["course"];
          return Scaffold(
            floatingActionButton: !isGuest
                ? !isTeacher
                    ? FloatingActionButton(
                        onPressed: () async {
                          int state =
                              await ApiService.subscribe(studentData.id, id);
                          if (state == 200) {
                            state = await ApiService.getStudentWallet(
                                studentData.id);
                            message("Succes.", Colors.green, context);
                          } else if (state == 400) {
                            message(
                                "You dont have enough money in your wallet.",
                                Colors.red,
                                context);
                          } else {
                            message(
                                "There was an error with subscribtion please try again.",
                                Colors.red,
                                context);
                          }
                        },
                        child: const Icon(
                            Icons.add), // if the couse here make it Icon.check
                      )
                    : FloatingActionButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, AddVideoPage.routeName,
                              arguments: id);
                        },
                        child: const Icon(
                            Icons.add), // if the couse here make it Icon.check
                      )
                : null,
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
                  child: Text(
                    course["course_name"],
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  Text(
                    "Teacher Name: ${course["teacher_name"]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text("Description: ${course["description"]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25)),
                  Text("Price: ${course["price"]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25)),
                  Text("Lang: ${course["category"]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25)),
                  const Divider(
                    thickness: 5,
                  ),
                  Text("Play List: ${course["videos"].length}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: course["videos"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 197, 197, 197)),
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(8),
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  course["videos"][index]["thumbnail_path"]),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(course["videos"][index]["title"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Text(course["videos"][index]["discription"],
                                    style: const TextStyle(fontSize: 16))
                              ],
                            ),
                            isGuest
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      videoToShow =
                                          course["videos"][index]["video_path"];
                                      Navigator.pushNamed(
                                          context, ShowVideoPage.routeName,
                                          arguments: course["videos"][index]
                                              ["video_path"]);
                                    },
                                    icon: Icon(
                                      Icons.play_arrow,
                                      size: 64,
                                      color: appColor,
                                    ))
                          ],
                        ),
                      );
                    },
                  ),
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
