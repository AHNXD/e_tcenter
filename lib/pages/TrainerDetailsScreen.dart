import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/courseDetails.dart';
import 'package:e_tcenter/services/apiService.dart';
import 'package:flutter/material.dart';

class TrainerDetailsPage extends StatefulWidget {
  static const routeName = '/trainerDet';
  const TrainerDetailsPage({Key? key}) : super(key: key);

  @override
  State<TrainerDetailsPage> createState() => _TrainerDetailsPageState();
}

class _TrainerDetailsPageState extends State<TrainerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
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
            padding: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.bottomCenter,
            child: const Text(
              "معلومات المدرب",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: ApiService.getTeacherData(id), // جلب بيانات المعلمين
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> teacher =
                snapshot.data as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
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
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person, size: 50),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // اسم المدرب
                        Text(
                          teacher['full_name'] ?? "",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        // مستطيلان أسفل الاسم
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.book),
                                      const SizedBox(width: 8),
                                      Text(teacher["specialization"] ?? ""),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8.0),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on),
                                      const SizedBox(width: 8),
                                      Text(teacher['previous_place_of_work'] ??
                                          ""),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // المستطيل النهدي
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // عدد الدورات
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.video_library),
                            const SizedBox(height: 8),
                            Text(
                                "${teacher["courses"].length}:عدد الدورات "), // هنا يمكنك جلب العدد من الـ API
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // نص الدورات في الأسفل
                  const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      ':الدورات',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // هنا يمكنك إضافة قائمة بالكورسات
                  // مثال على قائمة بالكورسات
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          teacher["courses"].length, // عدد الكورسات كمثال
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              CourseDetailsPage.routeName,
                              arguments: teacher["courses"][index]["id"],
                            );
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
                                    Text(teacher["courses"][index]["name"]),
                                    Text(teacher["courses"][index]
                                        ["discription"]),
                                    Text(teacher["courses"][index]["price"]
                                        .toString())
                                  ],
                                ),
                                const SizedBox()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
