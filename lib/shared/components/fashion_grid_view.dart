import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/features/fashion/fashion_details.dart';
import 'package:li_fashion/shared/components/category_list_component.dart';
import 'package:li_fashion/shared/components/favorite_button_component.dart';
import 'package:li_fashion/shared/components/image_component.dart';

class FashionGridView extends StatelessWidget {
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
  final PagingController<int, Fashion> pagingController;
  const FashionGridView({
    super.key,
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
    required this.pagingController,
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
                onRefresh: () async => pagingController.refresh(),
                color: colorScheme.onSurface,
                child: PagedMasonryGridView<int, Fashion>.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                      animateTransitions: true,
                      itemBuilder: (context, item, index) {
                        final Fashion fashion = item;
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

                              pagingController.refresh();
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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
            onRefresh: () async => pagingController.refresh(),
            color: colorScheme.onSurface,
            child: PagedMasonryGridView<int, Fashion>.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                  animateTransitions: true,
                  itemBuilder: (context, item, index) {
                    final Fashion fashion = item;
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

                          pagingController.refresh();
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
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
