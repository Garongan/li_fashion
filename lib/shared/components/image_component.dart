import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  final String image;
  final bool isDetail;
  final double height;
  final double? width;
  final double radius;
  const ImageComponent({
    super.key,
    required this.image,
    required this.isDetail,
    required this.height,
    required this.radius,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isDetail
          ? BorderRadius.circular(radius)
          : BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        height: height,
        width: width ?? double.infinity,
      ),
    );
  }
}
