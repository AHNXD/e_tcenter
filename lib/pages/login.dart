import 'package:flutter/material.dart';
import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/home.dart';
import 'package:e_tcenter/pages/register.dart';

import 'package:e_tcenter/services/apiService.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white60, Colors.white70], // درجات النهدي
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -100,
              left: -100,
              child: CircleAvatar(
                radius: 150,
                backgroundColor: Color(0xFFBA63CB),
              ),
            ),
            const Positioned(
              top: -50,
              left: -50,
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Color(0xFFF1AEFF),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 150),
                    const Text(
                      'WELCOME',
                      style: TextStyle(
                        fontSize: 32,
                        color: Color(0xFFBA63CB),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Color(0xFFF1AEFF),
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color(0xCBF3F3FC),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: buildInputField(Icons.email,
                                    "Enter your email", emailController)),
                            const SizedBox(height: 20.0),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: buildInputField(Icons.password,
                                    "Enter your password", passwordController,
                                    isPassword: true)),
                          ],
                        )),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account ? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RegisterPage.routeName);
                          },
                          child: Text(
                            "Create One.",
                            style: TextStyle(color: appColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            var status = await ApiService.loginStudent(
                                emailController.text, passwordController.text);
                            message(
                                status == 200
                                    ? 'Welcome!'
                                    : 'Invalid email or password.',
                                status == 200 ? Colors.green : Colors.red,
                                context);
                            if (status == 200) {
                              Navigator.popAndPushNamed(
                                  context, HomePage.routeName);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColor, // لون الزر
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Student',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            var status = await ApiService.loginTeacher(
                                emailController.text, passwordController.text);
                            message(
                                status == 200
                                    ? 'Welcome!'
                                    : 'Invalid email or password.',
                                status == 200 ? Colors.green : Colors.red,
                                context);
                            if (status == 200) {
                              Navigator.popAndPushNamed(
                                  context, HomePage.routeName);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColor, // لون الزر
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Teacher',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.popAndPushNamed(context, HomePage.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor, // لون الزر
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Guest',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
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
