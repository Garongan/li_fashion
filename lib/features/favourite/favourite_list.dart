import 'package:flutter/material.dart';
import 'package:li_fashion/core/theme.dart';
import 'package:li_fashion/features/fashion/components/custom_app_bar.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double xPadding = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(
      backgroundColor: colorScheme.onSurface,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: topPadding,
              left: xPadding,
              right: xPadding,
              bottom: topPadding / 2,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * 0.07),
                bottomRight: Radius.circular(width * 0.07),
              ),
            ),
            child: Column(
              children: <Widget>[
                const CustomAppBar(
                  action: SizedBox(
                    width: 60,
                  ),
                ),
                SizedBox(
                  height: topPadding / 2,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.07),
                    color: colorScheme.primary,
                  ),
                  padding: const EdgeInsets.all(7),
                  child: TextField(
                    cursorColor: colorScheme.onSurface,
                    decoration: const InputDecoration(
                      hintText: 'Search your favourite',
                      prefixIcon: IconTheme(
                        data: customIconThemeData,
                        child: Icon(Icons.search_outlined),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                MediaQuery.platformBrightnessOf(context).name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.surface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
