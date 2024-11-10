import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:li_fashion/core/google_sheets_api.dart';
import 'package:li_fashion/core/theme.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/features/fashion/fashion_details.dart';
import 'package:li_fashion/features/favourite/favourite_list.dart';

class FashionList extends StatefulWidget {
  const FashionList({super.key});

  @override
  State<FashionList> createState() => _FashionListState();
}

class _FashionListState extends State<FashionList> {
  final _api = GoogleSheetsApi();
  bool toggleFavourite = false;

  late Future<List<Fashion>> _futureFasion;

  List<List<dynamic>> _category = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
    _futureFasion = _api.getFashionData();
  }

  Future<void> _fetchData() async {
    try {
      final category = await _api.getSpreadsheetData('Sheet2');
      setState(() {
        _category = category.skip(1).toList();
      });
    } catch (e) {
      log('Error fetching data: $e');
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
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: topPadding,
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
              Row(
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
              ),
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
                    prefixIcon: IconTheme(
                      data: customIconThemeData,
                      child: Icon(Icons.search_outlined),
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
            margin: EdgeInsets.only(
              bottom: bottomPadding,
            ),
            padding: EdgeInsets.all(xPadding),
            child: Expanded(
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
                        SizedBox(
                          width: width - (xPadding * 2),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: xPadding,
                              children: List.generate(
                                _category.length,
                                (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.07),
                                      color: colorScheme.surface,
                                      border: Border.all(
                                        width: 1,
                                        color:
                                            colorScheme.onSurface.withAlpha(50),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: Text(
                                          _category[index].join(''),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
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
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FashionDetails(
                                        name: fashion.name,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              width * 0.07),
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: colorScheme.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  toggleFavourite =
                                                      !toggleFavourite;
                                                });
                                              },
                                              icon: Icon(
                                                toggleFavourite
                                                    ? Icons
                                                        .favorite_outline_outlined
                                                    : Icons.favorite_outlined,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: xPadding,
                                      ),
                                      child: Text(fashion.name),
                                    ),
                                    Text(fashion.price),
                                  ],
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
      ]),
    );
  }
}
