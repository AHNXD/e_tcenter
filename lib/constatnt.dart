import 'package:e_tcenter/models/student.dart';
import 'package:e_tcenter/models/student_wallets.dart';
import 'package:flutter/material.dart';

Color appColor = const Color(0xFFF1AEFF);
Student studentData = const Student(
  id: 0,
  firstName: "Guest",
  lastName: "",
  email: "Guest@gmail.com",
);
StudentWallet studentWalletData =
    const StudentWallet(id: 0, student_id: 0, value: 0);

void resetData() {
  studentData = const Student(
    id: 0,
    firstName: "Guest",
    lastName: "",
    email: "Guest@gmail.com",
  );
  studentWalletData = const StudentWallet(id: 0, student_id: 0, value: 0);
}

void message(String error, Color c, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: c,
    content: Center(child: Text(error)),
    duration: const Duration(seconds: 2),
  ));
}
