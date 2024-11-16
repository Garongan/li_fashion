import 'package:flutter/material.dart';

class CustomImageComponent extends StatelessWidget {
  final String image;
  final bool isDetail;
  final double height;
  const CustomImageComponent({
    super.key,
    required this.image,
    required this.isDetail,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: isDetail
          ? BorderRadius.circular(width * 0.07)
          : BorderRadius.only(
              topLeft: Radius.circular(width * 0.07),
              topRight: Radius.circular(width * 0.07),
            ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        height: height,
      ),
    );
  }
}
