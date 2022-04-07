import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    Key? key,
    required this.fieldName,
    required this.keyboardType,
    required this.passwordField,
    required this.validatorFn,
    required this.onSavedFn,
    this.initialValue,
    this.controller,
    this.onFieldSubmitted,
    this.focusNode,
    this.onEditingComplete,
  }) : super(key: key);

  String fieldName;
  TextInputType keyboardType;
  bool passwordField;
  String? Function(String?)? validatorFn;
  String? Function(String?)? onSavedFn;
  String? initialValue;
  TextEditingController? controller;
  Function(String)? onFieldSubmitted;
  FocusNode? focusNode;
  Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (controller == null)
          Container(
            width: 350,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              style: TextStyle(color: Colors.black54),
              controller: controller ?? null,
              onEditingComplete: onEditingComplete ?? null,
              textInputAction: TextInputAction.next,
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
              initialValue: initialValue ?? "",
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted ?? (value) => print(value),
              obscureText: passwordField,
              autocorrect: false,
              validator: validatorFn,
              onSaved: onSavedFn,
            ),
          ),
        if (controller != null)
          Container(
            width: 350,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              style: TextStyle(color: Colors.black54),
              controller: controller,
              focusNode: focusNode,
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
                errorBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted ?? (value) => print(value),
              textInputAction:
                  passwordField ? TextInputAction.next : TextInputAction.done,
              obscureText: passwordField,
              autocorrect: false,
              validator: validatorFn,
              onSaved: onSavedFn,
            ),
          ),
        sizedBoxPadding(),
      ],
    );
  }

  //! Padding widget
  SizedBox sizedBoxPadding() {
    return SizedBox(
      height: 12,
    );
  }
}
