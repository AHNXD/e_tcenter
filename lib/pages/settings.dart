import 'package:e_tcenter/models/teacher.dart';
import 'package:e_tcenter/pages/charge_wallet.dart';

import 'package:flutter/material.dart';
import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/pages/login.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/profile';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch data here (e.g., from local storage or a quick network call)
    fetchData();
  }

  void fetchData() async {
    // Implement your data fetching logic here
    // Update studentData and studentWalletData based on the fetched data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "الإعدادات",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('المعلومات الشخصية',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            const SizedBox(height: 20),
            Text(
                isGuest
                    ? "Guest"
                    : isTeacher
                        ? "${teacherData.firstName} ${teacherData.lastName}"
                        : "${studentData.firstName} ${studentData.lastName}",
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text(
                isGuest
                    ? "Guest@gmail.com"
                    : isTeacher
                        ? teacherData.email
                        : studentData.email,
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text(WalletData.value.toString(),
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            const Divider(
              thickness: 5,
            ),
            if (!isGuest && !isTeacher)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('شحن الحساب',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ChargeWalletPage.routeName)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      icon: const Icon(Icons.wallet),
                      color: appColor),
                ],
              ),
            if (!isGuest) const SizedBox(height: 20),
            if (!isGuest)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('تعديل الحساب',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      color: appColor),
                ],
              ),
            if (!isGuest) const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('تسجيل الخروج',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {
                    resetData();
                    Navigator.popAndPushNamed(context, LoginPage.routeName);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: appColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
