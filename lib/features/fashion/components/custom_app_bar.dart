import 'package:flutter/material.dart';
import 'package:li_fashion/features/favourite/favourite_list.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Padding(
              padding: EdgeInsets.all(7),
              child: Icon(Icons.arrow_back_outlined),
            ),
          ),
        ),
        Text(
          'Li Fashion',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouriteList(),
                ),
              );
            },
            icon: const Padding(
              padding: EdgeInsets.all(7),
              child: Icon(Icons.bookmarks_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
