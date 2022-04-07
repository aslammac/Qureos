import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String name;
  const TitleText({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        // color: Color(0xff73544C).withOpacity(0.8),
      ),
    );
  }
}
