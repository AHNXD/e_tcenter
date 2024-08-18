import 'package:flutter/material.dart';

class TextForm1 extends StatelessWidget {
  TextForm1(
      {Key? key,
      this.text,
      this.textInputType,
      required this.controller,
      this.iconData,
      required TextInputType,
      this.ontap,
      required this.validate1})
      : super(key: key);
  String? text;
  IconData? iconData;
  TextEditingController? controller;
  TextInputType? textInputType;
  Function? ontap;
  final String? Function(String? v)? validate1;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate1,
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                20)), //InputBorder.none//OutlineInputBorder
        labelText: text, //hintText
        prefixIcon: Icon(iconData),
      ),
    );
  }
}
