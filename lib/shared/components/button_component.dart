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
        bottom: bottomPadding == null ? 0 : bottomPadding!,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
