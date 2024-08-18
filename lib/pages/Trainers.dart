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
    final namesResponse = await http
        .get(Uri.parse('http://localhost:8000/api/teachers/full-names'));
    final coursesResponse = await http.get(Uri.parse(
        'http://localhost:8000/api/teachers/id')); //  تأكد من تعديل هذا الرابط
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
          'coursesCount': coursesData[i]
              ['coursesCount'], //  تغيير  'coursesCount'  إذا لزم الأمر
          'subject': coursesData[i]
              ['subject'], //  تغيير  'subject'  إذا لزم الأمر
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            //  العودة إلى الواجهة السابقة
          },
        ),
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: Container(
            color: Colors.blue, //  يمكنك تغيير اللون
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            alignment: Alignment.center,
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
            const Text(
              'نعرض جميع المعلمين المحترفين',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.person, size: 30),
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
