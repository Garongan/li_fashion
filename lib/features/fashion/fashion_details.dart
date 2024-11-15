import 'package:flutter/material.dart';
import 'package:li_fashion/features/fashion/components/custom_app_bar.dart';
import 'package:li_fashion/features/fashion/components/favourite_button_component.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:url_launcher/url_launcher.dart';

class FashionDetails extends StatelessWidget {
  final String id;
  final Fashion fashion;

  const FashionDetails({super.key, required this.fashion, required this.id});

  Future<void> _openShopee(String link) async {
    final url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final double xPadding = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(
      backgroundColor: colorScheme.onSurface,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: topPadding + xPadding,
              left: xPadding,
              right: xPadding,
              bottom: xPadding,
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
                CustomAppBar(
                  action: FavouriteButtonComponent(
                    id: id,
                    padding: 7,
                    background: colorScheme.primary,
                  ),
                  title: 'Product',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(width * 0.07),
              ),
              padding: EdgeInsets.all(xPadding),
              child: Center(
                child: Text(fashion.name),
              ),
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
                onPressed: () => _openShopee(fashion.link),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      'Checkout',
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
    );
  }
}
