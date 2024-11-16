import 'package:flutter/material.dart';
import 'package:li_fashion/features/fashion/components/custom_app_bar.dart';
import 'package:li_fashion/features/fashion/components/favourite_button_component.dart';
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
            child: SizedBox(
              height: 500,
              child: Stack(children: <Widget>[
                CustomImageComponent(
                  image: widget.fashion.image[0],
                  isDetail: true,
                  width: double.infinity,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(xPadding),
                    child: Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(widget.fashion.image.length, (index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: colorScheme.onSurface,
                                ),
                                borderRadius:
                                    BorderRadius.circular(width * 0.07)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(width * 0.07),
                              child: Image.network(
                                widget.fashion.image[index],
                                height: 85,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                )
              ]),
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
