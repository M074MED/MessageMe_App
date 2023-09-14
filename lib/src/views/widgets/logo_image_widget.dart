import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class LogoImageWidget extends StatelessWidget {
  final double height;

  const LogoImageWidget({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      LOGO_PATH,
      height: height,
    );
  }
}
