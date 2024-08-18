import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/TrainerDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainersPage extends StatefulWidget {
  static const routeName = '/trainer';
  const TrainersPage({super.key});

  @override
//  State<TrainersPage> createState() => _TrainersPageState();
  _TrainersPageState createState() => _TrainersPageState();
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _TrainersPageState extends State<TrainersPage> {
  List<dynamic> teachers = [];

  @override
  void initState() {
    super.initState();
    fetchTeachersData();
  }

  Future<void> fetchTeachersData() async {
    // جلب بيانات المعلمين من الروابط
    final namesResponse =
        await http.get(Uri.parse('http://192.168.1.3:8000/api/teacher/search'));
    //  تأكد من تعديل هذا الرابط
    var headers = {'Content-Type': 'application/json'};
    print('Status Code: ${namesResponse.statusCode}');

    if (namesResponse.statusCode == 200) {
      final namesData = json.decode(namesResponse.body);
      var data = namesData["teachers"];
      print(data);
      //  دمج البيانات  (قد تحتاج إلى تعديل هذه الخطوة بناءً على بنية البيانات من  API)
      for (var i = 0; i < data.length; i++) {
        teachers.add({
          'full_name': data[i]["full_name"],
          // 'course_names': coursesData[i]['coursesCount'], //  تغيير  'coursesCount'  إذا لزم الأمر
          'specialization': data[i]
              ['specialization'], //  تغيير  'subject'  إذا لزم الأمر
        });
      }

      setState(() {});
    } else {
      //  print("not good");
    }
  }

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
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'المعلمين',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  final teacher = teachers[index];
                  return ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   '${teacher['coursesCount']}', //  عدد الدورات
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          Icon(Icons.person, size: 30),
                        ],
                      ),
                    ),
                    title: Text(teacher['full_name'] ?? ""),
                    subtitle: Text(teacher['specialization']), //  مادة التدريس
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          TrainerDetailsPage
                              .routeName); //  تأكد من  أن  teacher['id']  موجود  في  البيانات
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
