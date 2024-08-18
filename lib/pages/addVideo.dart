import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddVideoPage extends StatefulWidget {
  static const routeName = '/addVideo';
  const AddVideoPage({super.key});

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  final TextEditingController TitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController videoController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();

  final imagePicker = ImagePicker();

  Future<void> pickVideo() async {
    final XFile? pickedVideo =
        await imagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        // Update UI state with the selected video
        video = pickedVideo;
      });
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        // Update UI state with the selected image
        image = pickedImage;
      });
    }
  }

  XFile? video;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (video != null) {
            // Check for both video and image
            int state = await ApiService.addVideo(id, TitleController.text,
                descriptionController.text, video!, image!);
            if (state == 200) {
              message("Succes!", Colors.green, context);
            } else {
              message("There was an error.", Colors.red, context);
            }
          }
        },
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
              "اضافة فيديو",
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
            buildInputField(Icons.abc, "Title", TitleController),
            buildInputField(Icons.abc, "Description", descriptionController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: pickVideo, child: Text("Set Video")),
                ElevatedButton(
                    onPressed: pickImage, child: Text("Set Thumbnail"))
              ],
            )
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
