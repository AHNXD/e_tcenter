import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/services/apiService.dart';

import 'package:flutter/material.dart';
import 'package:e_tcenter/models/course.dart';

class CreateCoursPage extends StatefulWidget {
  static const routeName = '/select';
  const CreateCoursPage({super.key});

  @override
  _CourseFormState createState() => _CourseFormState();
}

class _CourseFormState extends State<CreateCoursPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool accepted = false;
  double rate = 0.0;
  var cat = [];
  int selectedCatIndex = 0;
  int selectedValue = 0;

  void submitData() async {
    try {
      Course course = Course(
        categoryId: selectedCatIndex,
        teacherId: teacherData.id,
        name: nameController.text,
        price: int.parse(priceController.text),
        description: descriptionController.text,
      );

      int state = await ApiService.createCourse(course.categoryId,
          course.teacherId, course.name, course.price, course.description);
      if (state == 200) {
        message("Succes!", Colors.green, context);
      } else {
        message("There was an error check you data.", Colors.red, context);
      }
    } catch (error) {
      message("There was an error please try again.", Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: submitData,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: Container(
            color: appColor, // Replace with your desired color
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'انشاء كورس',
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
          children: [
            Text(selectedCatIndex.toString()),
            FutureBuilder(
              future: ApiService.getAllCategories(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  cat = snapshot.data["categories"];
                  selectedCatIndex = cat[0]['id'];
                  return DropdownButton<int>(
                    isExpanded: true,
                    value: selectedCatIndex,
                    icon: Icon(
                      Icons.category,
                      color: appColor,
                    ),
                    items: cat
                        .map((item) => DropdownMenuItem<int>(
                              value: item['id'],
                              child: Text(item["name"]),
                            ))
                        .toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedCatIndex = newValue!;
                      });
                    },
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
            buildInputField(Icons.abc, "Name", nameController),
            buildInputField(Icons.abc, "Price", priceController),
            buildInputField(Icons.abc, "Description", descriptionController),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(
      IconData icon, String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: appColor, // لون زهري فاتح
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
