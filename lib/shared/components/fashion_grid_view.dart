import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/features/fashion/fashion_details.dart';
import 'package:li_fashion/shared/components/category_list_component.dart';
import 'package:li_fashion/shared/components/favorite_button_component.dart';
import 'package:li_fashion/shared/components/image_component.dart';

class FashionGridView extends StatelessWidget {
  final Future<List<Fashion>> futureFasion;
  final RefreshCallback pullRefresh;
  final Function(String) updateActiveCategory;
  final String activeCategory;
  final double radius;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<BoxShadow>? boxShadow;
  final double categorySpacing;
  final double padding;
  final double cardPadding;
  final bool isMobileView;
  const FashionGridView({
    super.key,
    required this.pullRefresh,
    required this.futureFasion,
    required this.updateActiveCategory,
    required this.activeCategory,
    required this.radius,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    this.boxShadow,
    required this.categorySpacing,
    required this.padding,
    required this.cardPadding,
    required this.isMobileView,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final double xPadding = MediaQuery.of(context).size.width * 0.03;

    return isMobileView
        ? _mobileTabletView(
            colorScheme: colorScheme,
            bottomPadding: bottomPadding,
            width: width,
            xPadding: xPadding,
          )
        : _desktopView(
            colorScheme: colorScheme,
            bottomPadding: bottomPadding,
            width: width,
            xPadding: xPadding,
          );
  }

  Widget _mobileTabletView({
    required ColorScheme colorScheme,
    required double bottomPadding,
    required double width,
    required double xPadding,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: boxShadow,
        ),
        margin: EdgeInsets.only(
          bottom: bottomPadding,
        ),
        padding: EdgeInsets.all(padding),
        child: Column(
          children: <Widget>[
            CategoryListComponent(
              width: width,
              xPadding: xPadding,
              updateActiveCategory: updateActiveCategory,
              activeCategory: activeCategory,
              radius: radius,
              spacing: categorySpacing,
            ),
            SizedBox(
              height: xPadding,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: pullRefresh,
                color: colorScheme.onSurface,
                child: FutureBuilder(
                  future: futureFasion,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.onSurface,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Failed to fetch data'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No data avaible'),
                      );
                    } else {
                      return MasonryGridView.count(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        crossAxisCount: crossAxisCount,
                        itemCount: snapshot.data!.length,
                        mainAxisSpacing: mainAxisSpacing,
                        crossAxisSpacing: crossAxisSpacing,
                        itemBuilder: (context, index) {
                          final Fashion fashion = snapshot.data![index];
                          final id = '${fashion.name}_${fashion.price}';
                          return Container(
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 2,
                                  color: colorScheme.onSurface.withAlpha(100),
                                  offset: const Offset(1, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                radius,
                              ),
                              color: colorScheme.surface,
                            ),
                            margin: const EdgeInsets.only(
                              left: 1,
                              right: 1,
                              bottom: 5,
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FashionDetails(
                                      id: id,
                                      fashion: fashion,
                                    ),
                                  ),
                                );

                                pullRefresh();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: <Widget>[
                                      ImageComponent(
                                        image: fashion.image[0],
                                        isDetail: false,
                                        height: 200,
                                        radius: radius,
                                      ),
                                      Positioned(
                                        top: 7,
                                        right: 7,
                                        child: FavoriteButtonComponent(
                                          id: id,
                                          padding: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: cardPadding / 2,
                                      horizontal: cardPadding,
                                    ),
                                    child: Text(
                                      fashion.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: cardPadding,
                                      right: cardPadding,
                                      bottom: cardPadding,
                                    ),
                                    child: Text(
                                      fashion.price,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _desktopView({
    required ColorScheme colorScheme,
    required double bottomPadding,
    required double width,
    required double xPadding,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: boxShadow,
      ),
      margin: EdgeInsets.only(
        bottom: bottomPadding,
      ),
      padding: EdgeInsets.all(padding),
      child: Column(
        children: <Widget>[
          CategoryListComponent(
            width: width,
            xPadding: xPadding,
            updateActiveCategory: updateActiveCategory,
            activeCategory: activeCategory,
            radius: radius,
            spacing: categorySpacing,
          ),
          SizedBox(
            height: xPadding,
          ),
          RefreshIndicator(
            onRefresh: pullRefresh,
            color: colorScheme.onSurface,
            child: FutureBuilder(
              future: futureFasion,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.onSurface,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Failed to fetch data'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No data avaible'),
                  );
                } else {
                  return MasonryGridView.count(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    crossAxisCount: crossAxisCount,
                    itemCount: snapshot.data!.length,
                    mainAxisSpacing: mainAxisSpacing,
                    crossAxisSpacing: crossAxisSpacing,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final Fashion fashion = snapshot.data![index];
                      final id = '${fashion.name}_${fashion.price}';
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 2,
                              color: colorScheme.onSurface.withAlpha(100),
                              offset: const Offset(1, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                            radius,
                          ),
                          color: colorScheme.surface,
                        ),
                        margin: const EdgeInsets.only(
                          left: 1,
                          right: 1,
                          bottom: 5,
                        ),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FashionDetails(
                                  id: id,
                                  fashion: fashion,
                                ),
                              ),
                            );
              
                            pullRefresh();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: <Widget>[
                                  ImageComponent(
                                    image: fashion.image[0],
                                    isDetail: false,
                                    height: 200,
                                    radius: radius,
                                  ),
                                  Positioned(
                                    top: 7,
                                    right: 7,
                                    child: FavoriteButtonComponent(
                                      id: id,
                                      padding: 0,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: cardPadding / 2,
                                  horizontal: cardPadding,
                                ),
                                child: Text(
                                  fashion.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: cardPadding,
                                  right: cardPadding,
                                  bottom: cardPadding,
                                ),
                                child: Text(
                                  fashion.price,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
