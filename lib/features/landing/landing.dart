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

    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
      if (boxConstraints.maxWidth > 1200) {
        return _DekstopView(
          colorScheme: colorScheme,
          width: width,
          topPadding: topPadding,
          xPadding: xPadding,
          bottomPadding: bottomPadding,
        );
      } else {
        return _MobileTabletView(
          colorScheme: colorScheme,
          width: width,
          topPadding: topPadding,
          xPadding: xPadding,
          bottomPadding: bottomPadding,
        );
      }
    }));
  }
}

class _MobileTabletView extends StatelessWidget {
  final ColorScheme colorScheme;
  final double width;
  final double topPadding;
  final double xPadding;
  final double bottomPadding;
  const _MobileTabletView({
    required this.colorScheme,
    required this.width,
    required this.topPadding,
    required this.xPadding,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff000000),
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
                    alignment: Alignment.topCenter,
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
              style: const TextStyle(
                fontSize: 60,
                color: Color(0xff000000),
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
            radius: width * 0.07,
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
    );
  }
}

class _DekstopView extends StatelessWidget {
  final ColorScheme colorScheme;
  final double width;
  final double topPadding;
  final double xPadding;
  final double bottomPadding;
  const _DekstopView({
    required this.colorScheme,
    required this.width,
    required this.topPadding,
    required this.xPadding,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 8,
              color: colorScheme.onSurface,
              offset: const Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(7),
        ),
        margin: const EdgeInsets.all(28),
        constraints: const BoxConstraints(
          maxWidth: 1000,
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                'assets/images/landing.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text(
                    'Li Fashion',
                    style: TextStyle(
                      color: Color(0xfffefff3),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.15,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: colorScheme.primary,
                        ),
                        alignment: Alignment.topCenter,
                        height: 100,
                        width: double.infinity,
                        child: Marquee(
                          text: 'TRENDY COLLECTION',
                          style: const TextStyle(
                            fontSize: 60,
                            color: Color(0xff000000),
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
                          decelerationDuration:
                              const Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ButtonComponent(
                          bottomPadding: bottomPadding,
                          text: 'Discover Now',
                          foregroundColor: colorScheme.onSurface,
                          backgroundColor: colorScheme.secondary,
                          radius: 7,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FashionList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
