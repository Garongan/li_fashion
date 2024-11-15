import 'package:flutter/material.dart';
import 'package:li_fashion/features/fashion/fashion_list.dart';
import 'package:marquee/marquee.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return Scaffold(
      backgroundColor: colorScheme.onSurface,
      body: Container(
        color: colorScheme.onSurface,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(width * 0.07),
                      bottomRight: Radius.circular(width * 0.07),
                    ),
                    child: Image.asset(
                      'assets/images/landing.jpg',
                      fit: BoxFit.cover,
                      width: width,
                      height: double.infinity,
                    ),
                  ),
                  const SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Li Fashion',
                        style: TextStyle(
                          color: Color(0xfffefff3),
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.07),
                color: colorScheme.primary,
              ),
              alignment: Alignment.topCenter,
              height: width * aspectRatio * 0.6,
              child: Marquee(
                text: 'TRENDY COLLECTION',
                style: TextStyle(
                  fontSize: width * aspectRatio * 0.4,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 20.0,
                velocity: 50.0,
                startPadding: 10.0,
                accelerationDuration: const Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: bottomPadding,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.07),
                  color: colorScheme.secondary,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FashionList(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        'Discover Now',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
