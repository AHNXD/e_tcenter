import 'package:flutter/material.dart';

class ButtonMaterial extends StatelessWidget {
  final Color? color;
  final String? text;
  final void Function()? onpressed;
  final String? Function(String?)? validate1;
  final void Function()? suffixPressed;

  ButtonMaterial({
    Key? key,
    this.color,
    this.text,
    required this.onpressed,  // هذا المتغير مطلوب الآن
    this.validate1,
    this.suffixPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      height: 50,
      minWidth: double.infinity,
      onPressed: onpressed,  // استخدم المتغير هنا
      child: Text(
        text ?? '',  // تأكد من أن النص ليس null
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
