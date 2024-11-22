import 'package:flutter/material.dart';
import 'package:li_fashion/shared/components/app_bar_component.dart';
import 'package:li_fashion/shared/components/favorite_button_component.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/shared/components/button_component.dart';
import 'package:li_fashion/shared/components/image_component.dart';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final xPadding = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1200) {
        return _dekstopView(
          colorScheme: colorScheme,
          width: width,
          topPadding: topPadding,
          xPadding: xPadding,
          height: height,
        );
      } else {
        return _mobileTabletView(
          colorScheme: colorScheme,
          width: width,
          topPadding: topPadding,
          xPadding: xPadding,
          height: height,
          bottomPadding: bottomPadding,
        );
      }
    }));
  }

  Widget _mobileTabletView({
    required ColorScheme colorScheme,
    required double width,
    required double topPadding,
    required double xPadding,
    required double height,
    required double bottomPadding,
  }) {
    return Container(
      color: colorScheme.onSurface,
      child: Column(
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
                  action: FavoriteButtonComponent(
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
                ImageComponent(
                  image: _activeImage,
                  isDetail: true,
                  height: height * 0.5,
                  radius: width * 0.07,
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
          Container(
            padding: EdgeInsets.only(
              top: xPadding,
              left: xPadding,
              right: xPadding,
              bottom: bottomPadding + xPadding,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * 0.07),
                topRight: Radius.circular(width * 0.07),
              ),
            ),
            child: ButtonComponent(
              text: 'Checkout',
              foregroundColor: const Color(0xff000000),
              backgroundColor: colorScheme.primary,
              radius: width * 0.07,
              onPressed: () => _openShopee(widget.fashion.link),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dekstopView({
    required ColorScheme colorScheme,
    required double width,
    required double topPadding,
    required double xPadding,
    required double height,
  }) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(28),
          constraints: const BoxConstraints(
            maxWidth: 1400,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(28),
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
                child: Column(
                  children: <Widget>[
                    AppBarComponent(
                      action: FavoriteButtonComponent(
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
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.all(28),
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
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.5,
                      width: 400,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: ImageComponent(
                              image: _activeImage,
                              isDetail: true,
                              height: height * 0.5,
                              width: 400,
                              radius: 7,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  widget.fashion.image.length,
                                  (index) {
                                    String imageUrl =
                                        widget.fashion.image[index];
                                    return InkWell(
                                      onTap: () => _changeMainImage(imageUrl),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7),
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
                      width: 28,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.fashion.name,
                                  style:
                                      Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.fashion.price,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Text(
                            widget.fashion.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          ButtonComponent(
                            text: 'Checkout',
                            foregroundColor: const Color(0xff000000),
                            backgroundColor: colorScheme.primary,
                            radius: 7,
                            onPressed: () => _openShopee(widget.fashion.link),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
