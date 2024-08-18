import 'package:e_tcenter/constatnt.dart';

import 'package:flutter/material.dart';
import 'package:e_tcenter/models/course.dart';

class CourseForm extends StatefulWidget {
  static const routeName = '/select';
  const CourseForm({super.key});

  @override
  _CourseFormState createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController teacherIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool accepted = false;
  double rate = 0.0;

  void submitData() async {
    try {
      Course course = Course(
        categoryId: int.parse(categoryIdController.text),
        teacherId: int.parse(teacherIdController.text),
        name: nameController.text,
        price: double.parse(priceController.text),
        description: descriptionController.text,
        accepted: accepted,
        rate: rate,
      );

      //Course createdCourse = await createCourse(course);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Course created: name')));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create course.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          color: appColor, // Replace with your desired color
          padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
          alignment: Alignment.bottomCenter,
          child: Text(
            'انشاء كورس',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: categoryIdController,
              decoration: const InputDecoration(labelText: 'Category ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: teacherIdController,
              decoration: const InputDecoration(labelText: 'Teacher ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Course Name'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            Row(
              children: [
                Checkbox(
                  value: accepted,
                  onChanged: (value) {
                    setState(() {
                      accepted = value!;
                    });
                  },
                ),
                const Text('Accepted'),
              ],
            ),
            Slider(
              value: rate,
              min: 0,
              max: 5,
              divisions: 5,
              label: rate.toString(),
              onChanged: (value) {
                setState(() {
                  rate = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: submitData,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
