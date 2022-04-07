import 'package:flutter/material.dart';

class SubText extends StatelessWidget {
  final String name;
  const SubText({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 18,
        // fontWeight: FontWeight.w100,
        color: Colors.black,
      ),
    );
  }
}
