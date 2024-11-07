import 'package:flutter/material.dart';
import 'package:li_fashion/shared/navigation_menu.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
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
                  Expanded(
                    child: ClipRRect(
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
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Li Fashion',
                        style: TextStyle(
                          color: colorScheme.surface,
                          fontSize: 32,
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
              height: bottomPadding + 100,
              width: width,
              child: FittedBox(
                fit: BoxFit.none,
                child: Text(
                  'COLLECTIO',
                  style: TextStyle(
                    fontSize: width * 0.22,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: false,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.07),
                  topRight: Radius.circular(width * 0.07),
                ),
                color: colorScheme.secondary,
              ),
              padding: EdgeInsets.only(bottom: bottomPadding),
              width: width,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationMenu(),
                    ),
                  );
                },
                child: SizedBox(
                  height: 80,
                  child: Center(
                    child: Text(
                      'Discover Now',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
