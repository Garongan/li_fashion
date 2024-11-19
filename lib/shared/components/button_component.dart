import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final double? bottomPadding;
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final double radius;
  final VoidCallback onPressed;
  const ButtonComponent({
    super.key,
    this.bottomPadding,
    required this.text,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.radius,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding ?? 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(text),
            ),
          ),
        ),
      ),
    );
  }
}
