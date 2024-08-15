import 'package:flutter/material.dart';
import 'package:e_tcenter/constatnt.dart';
import '../services/apiService.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false; // حالة إظهار كلمة المرور
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // لون زهري غامق
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30), // مسافة من أعلى الشاشة
            const Icon(Icons.book, size: 100, color: Color(0xFF77379C)),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xCBF3F3FC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  buildInputField(
                      Icons.person, 'First Name', firstNameController),
                  buildInputField(
                      Icons.person_outline, 'Last Name', lastNameController),
                  buildInputField(Icons.email, 'Email', emailController),
                  buildInputField(Icons.lock, 'Password', passwordController,
                      isPassword: true),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("You have an account ? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Let's Login.",
                    style: TextStyle(color: Color(0xFFF1AEFF)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () async {
                  var status = await ApiService.register(
                      firstNameController.text,
                      lastNameController.text,
                      emailController.text,
                      passwordController.text);
                  message(
                      status == 200
                          ? 'Account created successfully!'
                          : 'Failed to create account. Please try again.',
                      status == 200 ? Colors.green : Colors.red,
                      context);
                  if (status == 200) {
                    Navigator.pop(context);
                  }
                }, // استدعاء وظيفة التسجيل
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF77379C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                      color: Color(0xFFEFEAED),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
        color: const Color(0xFFBA63CB), // لون زهري فاتح
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword && !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'Arial'),
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
        ],
      ),
    );
  }
}
