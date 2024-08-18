import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/services/apiService.dart';

import 'package:flutter/material.dart';

class ChargeWalletPage extends StatefulWidget {
  static const routeName = '/charge';
  const ChargeWalletPage({super.key});

  @override
  State<ChargeWalletPage> createState() => _ChargeWalletPageState();
}

class _ChargeWalletPageState extends State<ChargeWalletPage> {
  final TextEditingController _controller = TextEditingController();

  String state = "Enter The Amount of Charge.";

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
              "شحن المحفظة",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
            ),
            IconButton(
                onPressed: () async {
                  int code = await ApiService.chargeWallet(
                      int.parse(_controller.text));

                  if (code == 200) {
                    state = "Success.";
                    await ApiService.getStudentWallet(studentData.id);
                  } else {
                    state = "There Was An Error, Please Try Again.";
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.add)),
            Text(state)
          ],
        ),
      ),
    );
  }
}
