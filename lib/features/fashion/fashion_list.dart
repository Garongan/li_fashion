import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:li_fashion/core/google_sheets_api.dart';
import 'package:li_fashion/core/theme.dart';
import 'package:li_fashion/features/fashion/components/category_list_component.dart';
import 'package:li_fashion/features/fashion/components/custom_app_bar.dart';
import 'package:li_fashion/features/fashion/components/favourite_button_component.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/features/fashion/fashion_details.dart';

class FashionList extends StatefulWidget {
  const FashionList({super.key});

  @override
  State<FashionList> createState() => _FashionListState();
}

class _FashionListState extends State<FashionList> {
  final _api = GoogleSheetsApi();

  late Future<List<Fashion>> _futureFasion;

  @override
  void initState() {
    super.initState();
    _futureFasion = _api.getFashionData();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _futureFasion = _api.getFashionData();
    });
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
                const CustomAppBar(),
                SizedBox(
                  height: xPadding,
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
                      hintText: 'Search your needs',
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                      prefixIcon: IconTheme(
                        data: customIconThemeData,
                        child: Icon(Icons.search_outlined),
                      ),
                    ),
                    textAlignVertical: TextAlignVertical.center,
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
              margin: EdgeInsets.only(
                bottom: bottomPadding,
              ),
              padding: EdgeInsets.all(xPadding),
              child: RefreshIndicator(
                onRefresh: _pullRefresh,
                color: colorScheme.onSurface,
                child: FutureBuilder(
                  future: _futureFasion,
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
                      return Column(
                        children: <Widget>[
                          CategoryListComponent(
                            width: width,
                            xPadding: xPadding,
                          ),
                          SizedBox(
                            height: xPadding,
                          ),
                          Expanded(
                            child: MasonryGridView.count(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0),
                              crossAxisCount: 2,
                              itemCount: snapshot.data!.length,
                              mainAxisSpacing: xPadding,
                              crossAxisSpacing: xPadding,
                              itemBuilder: (context, index) {
                                final Fashion fashion = snapshot.data![index];
                                final id = '${fashion.name}_${fashion.price}';
                                return Container(
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: colorScheme.onSurface
                                            .withAlpha(100),
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(
                                      width * 0.07,
                                    ),
                                    color: colorScheme.surface,
                                  ),
                                  margin: const EdgeInsets.all(1),
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

                                      _pullRefresh();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                  width * 0.07,
                                                ),
                                                topRight: Radius.circular(
                                                  width * 0.07,
                                                ),
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: 0.9,
                                                child: Image.network(
                                                  fashion.mainImage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              right: 5,
                                              child: FavouriteButtonComponent(
                                                id: id,
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
                            ),
                          ),
                        ],
                      );
                    }
                  },
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
