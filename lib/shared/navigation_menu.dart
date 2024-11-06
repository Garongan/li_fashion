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
    return Scaffold(
      body: <Widget>[
        const FasionsList(),
        const WishList(),
      ][currentPageIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromRGBO(29, 170, 171, 1),
                width: 0.5,
              ),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(29, 170, 171, 1),
                offset: Offset(0, 1.5),
                blurRadius: 4,
              )
            ]),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: currentPageIndex,
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                size: 30,
                color: Color.fromRGBO(29, 170, 171, 1),
              ),
              icon: Icon(
                Icons.home_outlined,
                size: 30,
                color: Color.fromRGBO(29, 170, 171, 1),
              ),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.favorite,
                size: 30,
                color: Color.fromRGBO(29, 170, 171, 1),
              ),
              icon: Icon(
                Icons.favorite_outline_outlined,
                size: 30,
                color: Color.fromRGBO(29, 170, 171, 1),
              ),
              label: 'Favourite',
            ),
          ],
        ),
      ),
    );
  }
}
