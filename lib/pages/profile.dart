import 'package:flutter/material.dart';
import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/login.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الملف الشخصي'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('المعلومات الشخصية',
                style: TextStyle(color: Colors.pink)),
            const SizedBox(height: 20),
            Text("${studentData.firstName} ${studentData.lastName}",
                style: const TextStyle(color: Colors.pink, fontSize: 24)),
            const SizedBox(height: 10),
            Text(studentData.email,
                style: const TextStyle(color: Colors.pink, fontSize: 24)),
            const SizedBox(height: 10),
            Text(studentWalletData.value.toString(),
                style: const TextStyle(color: Colors.pink, fontSize: 24)),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('تعديل الحساب', style: TextStyle(color: Colors.pink)),
                Icon(Icons.edit, color: Colors.pink),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('عرض الكورسات المشتركه',
                    style: TextStyle(color: Colors.pink)),
                Icon(Icons.arrow_forward, color: Colors.pink),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('تسجيل الخروج',
                    style: TextStyle(color: Colors.pink)),
                IconButton(
                  onPressed: () {
                    resetData();
                    Navigator.popAndPushNamed(context, LoginPage.routeName);
                  },
                  icon: const Icon(Icons.logout, color: Colors.pink),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
