import 'package:flutter/material.dart';

class TrainersPage extends StatelessWidget {
  static const routeName = '/trainer';
  const TrainersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('المدربين'),
      ),
      body: const Center(
        child: Text(
          'هنا يمكنك رؤية قائمة المدربين.',
          style: TextStyle(color: Colors.pink, fontSize: 20),
        ),
      ),
    );
  }
}
