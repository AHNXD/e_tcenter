import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/TrainerDetailsScreen.dart';
import 'package:e_tcenter/services/apiService.dart';
import 'package:flutter/material.dart';

class TrainersPage extends StatefulWidget {
  static const routeName = '/trainer';
  const TrainersPage({super.key});

  @override
  _TrainersPageState createState() => _TrainersPageState();
}

class _TrainersPageState extends State<TrainersPage> {
  List<dynamic> teachers = [];

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
        body: FutureBuilder(
            future: ApiService.getTeachersData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                for (var i = 0; i < data.length; i++) {
                  teachers.add({
                    'id': data[i]["id"],
                    'full_name': data[i]["full_name"],
                    'specialization': data[i]['specialization'],
                  });
                }
                return Padding(
                  padding: const EdgeInsets.all(0.0),
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
                              Icon(Icons.person, size: 30),
                            ],
                          ),
                        ),
                        title: Text(teacher['full_name'] ?? ""),
                        subtitle:
                            Text(teacher['specialization']), //  مادة التدريس
                        onTap: () {
                          Navigator.pushNamed(
                              context, TrainerDetailsPage.routeName,
                              arguments: teacher["id"]);
                        },
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: appColor,
                  ),
                );
              }
            }));
  }
}
