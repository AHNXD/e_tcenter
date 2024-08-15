import 'package:flutter/material.dart';
import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/home.dart';
import 'package:e_tcenter/pages/register.dart';

import 'package:e_tcenter/services/apiService.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        obscureText: true,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
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
                          child: const Text(
                            "Create One.",
                            style: TextStyle(color: Color(0xFFF1AEFF)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () async {
                        var status = await ApiService.login(
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
                        backgroundColor: const Color(0xFFF1AEFF), // لون الزر
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'LOG IN',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFFBA63CB)),
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
}
