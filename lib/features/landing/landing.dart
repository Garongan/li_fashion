import 'package:flutter/material.dart';
import 'package:li_fashion/features/fashion/fashion_list.dart';
import 'package:li_fashion/shared/components/button_component.dart';
import 'package:marquee/marquee.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double xPadding = MediaQuery.of(context).size.width * 0.03;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: topPadding + xPadding),
                    child: const Align(
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
              height: 100,
              child: Marquee(
                text: 'TRENDY COLLECTION',
                style: TextStyle(
                  fontSize: 60,
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
            ButtonComponent(
              bottomPadding: bottomPadding,
              text: 'Discover Now',
              foregroundColor: colorScheme.onSurface,
              backgroundColor: colorScheme.secondary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FashionList(),
                  ),
                );
              },
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
