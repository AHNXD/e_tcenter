import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TrainerDetailsPage extends StatelessWidget {
  const  TrainerDetailsPage ({super.key});
  static const routeName = '/trainerDet';
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
// final int trainerId;
//
// const TrainerProfileScreen({Key? key, required this.trainerId})
//     : super(key: key);
//
// @override
// _TrainerProfileScreenState createState() => _TrainerProfileScreenState();
// }
//
// class _TrainerProfileScreenState extends State<TrainerProfileScreen> {
// Map<String, dynamic> trainerData = {};
// List<dynamic> coursesData = [];
//
// @override
// void initState() {
// super.initState();
// fetchTrainerData();
// }
//
// Future<void> fetchTrainerData() async {
// final trainerResponse = await http.get(Uri.parse(
// 'http://0.0.0.0:8000/api/teacher/9'));
//
// final coursesResponse = await http.get(Uri.parse(
// 'http://0.0.0.0:8000/api/teacher/9'));
//
// if (trainerResponse.statusCode == 200 &&
// coursesResponse.statusCode == 200) {
// final jsonData = json.decode(trainerResponse.body);
// final coursesJsonData = json.decode(coursesResponse.body);
//
// setState(() {
// trainerData = jsonData as Map<String, dynamic>;
// coursesData = coursesJsonData;
// });
// } else {
// //  معالجة الأخطاء
// }
// }
//
// @override
// Widget build(BuildContext context) {
// return Scaffold(
// backgroundColor: Colors.white,
// appBar: AppBar(
// backgroundColor: Colors.transparent,
// elevation: 0,
// leading: IconButton(
// icon: const Icon(Icons.arrow_back, color: Colors.black),
// onPressed: () {
// Navigator.pop(context);
// },
// ),
// ),
// body: SingleChildScrollView(
// // لتفادي مشاكل overflow عند وجود محتوى كبير
// child: Padding(
// padding: const EdgeInsets.all(16.0),
// child: Column(
// children: [
// // بطاقة معلومات المدرب
// Container(
// padding:
// const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(20.0),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.3),
// spreadRadius: 2,
// blurRadius: 5,
// offset: const Offset(0, 3),
// ),
// ],
// ),
// child: Column(
// children: [
// // صورة المدرب واسمه
// Align(
// alignment: Alignment.topCenter,
// child: Column(
// children: [
// const CircleAvatar(
// radius: 40,
// backgroundColor: Colors.grey,
// child: Icon(Icons.person, size: 40),
// ),
// const SizedBox(height: 10),
// Text(
// trainerData['full_name'] ?? "",
// style: const TextStyle(
// fontSize: 20, fontWeight: FontWeight.bold),
// ),
// ],
// ),
// ),
// const SizedBox(height: 20),
//
// // مكان العمل ومادة التدريس
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// // مادة التدريس
// Expanded(
// child: Container(
// padding: const EdgeInsets.all(10.0),
// decoration: BoxDecoration(
// color: Colors.grey[200],
// borderRadius: BorderRadius.circular(10.0),
// ),
// child: Column(
// children: [
// const Icon(Icons.book, size: 30),
// const SizedBox(height: 5),
// Text(
// trainerData['specialization'] ?? "",
// textAlign: TextAlign.center,
// ),
// ],
// ),
// ),
// ),
// const SizedBox(width: 10),
//
// // مكان العمل
// Expanded(
// child: Container(
// padding: const EdgeInsets.all(10.0),
// decoration: BoxDecoration(
// color: Colors.grey[200],
// borderRadius: BorderRadius.circular(10.0),
// ),
// child: Column(
// children: [
// const Icon(Icons.location_on, size: 30),
// const SizedBox(height: 5),
// const Text(
// "مكان العمل", //  استبدل  ببيانات  API  الحقيقية
// textAlign: TextAlign.center,
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// const SizedBox(height: 20),
//
// // معلومات الطلاب والدورات
// Container(
// padding: const EdgeInsets.all(15.0),
// decoration: BoxDecoration(
// color: Colors.blue,
// borderRadius: BorderRadius.circular(10.0),
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// // معلومات الطلاب
// Column(
// children: [
// const Icon(Icons.people,
// size: 30, color: Colors.white),
// const SizedBox(height: 5),
// Text(
// "${trainerData['students_count'] ?? 0}",
// style: const TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold),
// ),
// const Text(
// "طالب",
// style: TextStyle(color: Colors.white),
// ),
// ],
// ),
// const VerticalDivider(
// color: Colors.white,
// thickness: 1,
// indent: 10,
// endIndent: 10,
// ),
//
// // معلومات الدورات
// Column(
// children: [
// const Icon(Icons.video_call,
// size: 30, color: Colors.white),
// const SizedBox(height: 5),
// Text(
// "${trainerData['courses_count'] ?? 0}",
// style: const TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold),
// ),
// const Text(
// "دورات",
// style: TextStyle(color: Colors.white),
// ),
// ],
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// const SizedBox(height: 20),
// // قائمة الدورات
// Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
// child: Align(
// alignment: Alignment.topRight,
// child: const Text(
// "دورات :",
// style:
// TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// )),
// ),
//
// ListView.builder(
// physics: const NeverScrollableScrollPhysics(),
// shrinkWrap: true,
// itemCount: coursesData.length,
// itemBuilder: (context, index) {
// final course = coursesData[index];
// return ListTile(
// title: Text(course['name'] ?? ""),
// );
// },
// ),
// ],
// ),
// ),
// ),
// );
// }
// }