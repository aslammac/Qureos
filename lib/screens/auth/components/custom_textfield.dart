import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    Key? key,
    required this.fieldName,
    required this.keyboardType,
    required this.passwordField,
    required this.controller,
  }) : super(key: key);
  final String fieldName;
  final TextInputType keyboardType;
  final bool passwordField;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        style: TextStyle(color: Colors.black54),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          filled: true,
          labelText: fieldName,
          fillColor: Colors.grey.shade100,
          hintStyle: TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
        keyboardType: keyboardType,
        textInputAction:
            passwordField ? TextInputAction.next : TextInputAction.done,
        obscureText: passwordField,
        controller: controller,
        autocorrect: false,
      ),
    );
  }
}
