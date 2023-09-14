import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
final VoidCallback? onPressed;
final Color fgColor;
final Widget child;
  const TextButtonWidget({super.key, required this.onPressed, required this.fgColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStatePropertyAll(fgColor),
                    ),
                    child: child,
                  );
  }
}