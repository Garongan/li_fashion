import 'package:flutter/material.dart';

class CustomButtonComponent extends StatelessWidget {
  final double? bottomPadding;
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  const CustomButtonComponent({
    super.key,
    this.bottomPadding,
    required this.text,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding == null ? 0 : bottomPadding!,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.07),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
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
