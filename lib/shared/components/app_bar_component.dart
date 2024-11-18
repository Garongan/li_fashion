import 'package:flutter/material.dart';
import 'package:li_fashion/features/favorite/favorite_list.dart';

class AppBarComponent extends StatelessWidget {
  final Widget? action;
  final String? title;
  const AppBarComponent({super.key, this.action, this.title});

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
              child: Icon(
                Icons.arrow_back_outlined,
              ),
            ),
          ),
        ),
        Text(
          title == null ? 'Li Fashion' : title!,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        action == null
            ? Container(
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoriteList(),
                      ),
                    );
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(7),
                    child: Icon(
                      Icons.bookmarks_outlined,
                    ),
                  ),
                ),
              )
            : action!,
      ],
    );
  }
}
