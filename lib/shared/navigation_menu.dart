import 'package:flutter/material.dart';
import 'package:li_fashion/features/fashion/fasion_list.dart';
import 'package:li_fashion/features/wish/wish_list.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: <Widget>[
        const FasionList(),
        const WishList(),
      ][currentPageIndex],
      bottomNavigationBar: Container(
        color: colorScheme.onSurface,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * 0.07),
              topRight: Radius.circular(width * 0.07),
            ),
            color: colorScheme.primary,
          ),
          child: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            selectedIndex: currentPageIndex,
            backgroundColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            destinations: <Widget>[
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.home_outlined,
                  size: 30,
                  color: colorScheme.onSurface,
                ),
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                  color: colorScheme.secondary,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.favorite_outline,
                  size: 30,
                  color: colorScheme.onSurface,
                ),
                icon: Icon(
                  Icons.favorite_outline,
                  size: 30,
                  color: colorScheme.secondary,
                ),
                label: 'Favourite',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
