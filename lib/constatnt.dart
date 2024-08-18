import 'package:e_tcenter/models/student.dart';
import 'package:e_tcenter/models/teacher.dart';
import 'package:e_tcenter/models/wallets.dart';
import 'package:flutter/material.dart';

//Color appColor = const Color(0xFFF1AEFF);
Color appColor = Colors.deepPurple;
bool isTeacher = false;
bool isGuest = true;
String videoToShow = "";
String VideoTestUrl =
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
Student studentData = const Student(
  id: 0,
  firstName: "Guest",
  lastName: "",
  email: "Guest@gmail.com",
);
Teacher teacherData = const Teacher(
    id: 0,
    firstName: "Guest",
    lastName: "",
    email: "Guest@gmail.com",
    placeOfWork: "",
    specialization: "",
    years: 0);
Wallet WalletData = const Wallet(id: 0, student_id: 0, value: 0);

void resetData() {
  studentData = const Student(
    id: 0,
    firstName: "Guest",
    lastName: "",
    email: "Guest@gmail.com",
  );
  teacherData = const Teacher(
      id: 0,
      firstName: "Guest",
      lastName: "",
      email: "Guest@gmail.com",
      placeOfWork: "",
      specialization: "",
      years: 0);
  WalletData = const Wallet(id: 0, student_id: 0, value: 0);
  isTeacher = false;
  isGuest = true;
}

void message(String error, Color c, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: c,
    content: Center(child: Text(error)),
    duration: const Duration(seconds: 2),
  ));
}
