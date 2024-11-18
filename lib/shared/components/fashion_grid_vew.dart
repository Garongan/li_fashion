import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/features/fashion/fashion_details.dart';
import 'package:li_fashion/shared/components/category_list_component.dart';
import 'package:li_fashion/shared/components/favorite_button_component.dart';
import 'package:li_fashion/shared/components/image_component.dart';

class FashionGridVew extends StatelessWidget {
  final Future<List<Fashion>> futureFasion;
  final RefreshCallback pullRefresh;
  final Function(String) updateActiveCategory;
  final String activeCategory;
  const FashionGridVew({
    super.key,
    required this.pullRefresh,
    required this.futureFasion,
    required this.updateActiveCategory,
    required this.activeCategory,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final double xPadding = MediaQuery.of(context).size.width * 0.03;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(width * 0.07),
        ),
        margin: EdgeInsets.only(
          bottom: bottomPadding,
        ),
        padding: EdgeInsets.all(xPadding),
        child: Column(
          children: <Widget>[
            CategoryListComponent(
              width: width,
              xPadding: xPadding,
              updateActiveCategory: updateActiveCategory,
              activeCategory: activeCategory,
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
                        crossAxisCount: 2,
                        itemCount: snapshot.data!.length,
                        mainAxisSpacing: xPadding - 5,
                        crossAxisSpacing: xPadding - 2,
                        itemBuilder: (context, index) {
                          final Fashion fashion = snapshot.data![index];
                          final id = '${fashion.name}_${fashion.price}';
                          return Container(
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 2,
                                  color:
                                      colorScheme.onSurface.withAlpha(100),
                                  offset: const Offset(1, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                width * 0.07,
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
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: <Widget>[
                                      ImageComponent(
                                        image: fashion.image[0],
                                        isDetail: false,
                                        height: 200,
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
                                      vertical: xPadding / 2,
                                      horizontal: xPadding,
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
                                      left: xPadding,
                                      right: xPadding,
                                      bottom: xPadding,
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
}
