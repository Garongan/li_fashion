import 'package:flutter/material.dart';
import 'package:li_fashion/shared/components/app_bar_component.dart';
import 'package:li_fashion/shared/components/favourite_button_component.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/shared/components/custom_button_component.dart';
import 'package:li_fashion/shared/components/custom_image_component.dart';
import 'package:url_launcher/url_launcher.dart';

class FashionDetails extends StatefulWidget {
  final String id;
  final Fashion fashion;

  const FashionDetails({super.key, required this.fashion, required this.id});

  @override
  State<FashionDetails> createState() => _FashionDetailsState();
}

class _FashionDetailsState extends State<FashionDetails> {
  String _activeImage = '';

  @override
  void initState() {
    super.initState();
    _activeImage = widget.fashion.image[0];
  }

  void _changeMainImage(String url) {
    setState(() {
      _activeImage = url;
    });
  }

  Color? _checkIfMainImage(String url) {
    if (_activeImage == url) {
      return Colors.black.withAlpha(100);
    }
    return null;
  }

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
    final double height = MediaQuery.of(context).size.height;
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
                AppBarComponent(
                  action: FavouriteButtonComponent(
                    id: widget.id,
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
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(width * 0.07),
            ),
            height: height * 0.5,
            child: Stack(
              children: <Widget>[
                CustomImageComponent(
                  image: _activeImage,
                  isDetail: true,
                  height: height * 0.5,
                ),
                Padding(
                  padding: EdgeInsets.all(xPadding),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        widget.fashion.image.length,
                        (index) {
                          String imageUrl = widget.fashion.image[index];
                          return InkWell(
                            onTap: () => _changeMainImage(imageUrl),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(width * 0.07),
                              child: Image.network(
                                imageUrl,
                                height: (height * 0.5) / 6,
                                color: _checkIfMainImage(imageUrl),
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
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
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.fashion.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.fashion.price,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: xPadding,
                  ),
                  Text(
                    widget.fashion.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomButtonComponent(
            bottomPadding: bottomPadding,
            text: 'Checkout',
            foregroundColor: colorScheme.onSurface,
            backgroundColor: colorScheme.primary,
            onPressed: () => _openShopee(widget.fashion.link),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
