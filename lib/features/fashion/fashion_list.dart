import 'package:flutter/material.dart';
import 'package:li_fashion/features/wish/wish_list.dart';

class FashionList extends StatelessWidget {
  const FashionList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double xPadding = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(
      backgroundColor: colorScheme.onSurface,
      body: Column(children: <Widget>[
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Li Fashion',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(7),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WishList(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.favorite_outline,
                        size: 30,
                      ),
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
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
                      border: InputBorder.none,
                      hintText: 'Search your needs',
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                      )),
                ),
              )
            ],
          ),
        ),
        Center(
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
      ]),
    );
  }
}
