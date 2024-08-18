import 'package:flutter/material.dart';
import 'package:e_tcenter/pages/courseDetails.dart';
import 'package:e_tcenter/pages/showCoursesFromCategory.dart';
import 'package:e_tcenter/pages/showSubscribedCourses.dart';
import 'package:flutter/material.dart';
import 'package:e_tcenter/pages/Trainers.dart';
import 'package:e_tcenter/pages/coursesCategories.dart';
import 'package:e_tcenter/pages/courses_and_Trainers.dart';
import 'package:e_tcenter/pages/home.dart';
import 'package:e_tcenter/pages/settings.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainersPage extends  StatefulWidget {
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
    final namesResponse = await http.get(Uri.parse('http://192.168.227.168:8000/api/teachers/full-names'));
    final coursesResponse = await http.get(Uri.parse('http://192.168.227.168:8000/api/teachers/id')); //  تأكد من تعديل هذا الرابط
    var headers = {'Content-Type': 'application/json'};
    print('Status Code: ${namesResponse.statusCode}');
    print('Status Code: ${coursesResponse.statusCode}');
    if (namesResponse.statusCode == 200 && coursesResponse.statusCode == 200) {
      final namesData = json.decode(namesResponse.body);
      final coursesData = json.decode(coursesResponse.body);

      //  دمج البيانات  (قد تحتاج إلى تعديل هذه الخطوة بناءً على بنية البيانات من  API)
      for (var i = 0; i < namesData.length; i++) {
        teachers.add({
          'name': namesData[i],
          'coursesCount': coursesData[i]['coursesCount'], //  تغيير  'coursesCount'  إذا لزم الأمر
          'subject': coursesData[i]['subject'], //  تغيير  'subject'  إذا لزم الأمر
        });
      }

      setState(() {});
    } else {
   print("not good");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            //  العودة إلى الواجهة السابقة
          },
        ),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          child: Container(
            color: Colors.blue, //  يمكنك تغيير اللون
            padding: EdgeInsets.only(left: 20, bottom: 20),
            alignment: Alignment.center,
            child: Text(
              'المعلمين',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'نعرض جميع المعلمين المحترفين',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  final teacher = teachers[index];
                  return ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${teacher['coursesCount']}', //  عدد الدورات
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.person, size: 30),
                        ],
                      ),
                    ),
                    title: Text(teacher['name']),
                    subtitle: Text(teacher['subject']), //  مادة التدريس
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