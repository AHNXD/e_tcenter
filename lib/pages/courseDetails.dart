import 'package:e_tcenter/constatnt.dart';
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
    Map id = ModalRoute.of(context)!.settings.arguments as Map;
    return FutureBuilder(
      future: ApiService.getCourseDetail(id["id"]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var course = snapshot.data["course"];
          return Scaffold(
            floatingActionButton: !isGuest
                ? FloatingActionButton(
                    onPressed: () async {
                      int state =
                          await ApiService.subscribe(studentData.id, id["id"]);
                      if (state == 200) {
                        state =
                            await ApiService.getStudentWallet(studentData.id);
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
                    child: const Icon(
                        Icons.add), // if the couse here make it Icon.check
                  )
                : null,
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
                  const Divider(
                    thickness: 5,
                  ),
                  Text("Play List: ${course["videos"].length}"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: course["videos"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(16),
                        height: 75,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Image.network(
                                course["videos"][index]["thumbnail_path"],
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            Column(
                              children: [
                                Text(course["videos"][index]["title"]),
                                Text(course["videos"][index]["discription"])
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
                                    icon: const Icon(Icons.play_arrow))
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
