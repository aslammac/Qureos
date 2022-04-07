import 'package:flutter/material.dart';

import '../../constants.dart';

class PaddingWidget extends StatelessWidget {
  final double count;
  const PaddingWidget({Key? key, this.count = 1.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: defaultPadding * count,
    );
  }
}
