import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class MainButtonWidget extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  const MainButtonWidget(
      {Key? key,
      required this.title,
      required this.color,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: APP_BORDER_RADIUS,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: screenSize(context).width / 1.15,
          height: 50,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
