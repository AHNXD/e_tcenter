import 'package:e_tcenter/constatnt.dart';
import 'package:e_tcenter/services/apiService.dart';
import 'package:flutter/material.dart';

class ChargeWalletPage extends StatefulWidget {
  static const routeName = '/charge';
  ChargeWalletPage({super.key});

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
        title: const Text("شحن المحفظة"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(studentData.id.toString()),
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
