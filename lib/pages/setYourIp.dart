import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/services/apiService.dart';
import 'package:e_tcenter/services/save.dart';
import 'package:flutter/material.dart';

class SetYourIpPage extends StatelessWidget {
  static const routeName = '/setIp';
  SetYourIpPage({super.key});
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.text.isEmpty) {
            message("Please enter the IP", Colors.red, context);
            return;
          } else {
            ApiService.ip = _controller.text;
            SaveService.save("ip", ApiService.ip);
            message("Succses", Colors.green, context);
          }
        },
        child: const Icon(Icons.save),
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
            padding: const EdgeInsets.only(bottom: 15),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'تحديد المسار',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("htttp://192.168.1.1:8000/api"),
            buildInputField(Icons.numbers, "Enter the IP", _controller)
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
