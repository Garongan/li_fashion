import 'package:flutter/material.dart';
import 'package:li_fashion/shared/services/api_service.dart';
import 'package:li_fashion/core/theme.dart';
import 'package:li_fashion/shared/components/app_bar_component.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/shared/components/fashion_grid_view.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  final _api = ApiService();
  String _activeCategory = 'Trending';
  late Future<List<Fashion>> _futureFasion;
  late TextEditingController _textEditingController;
  bool _isSearch = true;

  @override
  void initState() {
    super.initState();
    _futureFasion = _api.getLovedFashionData(_activeCategory, '');
    _textEditingController = TextEditingController();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _futureFasion = _api.getLovedFashionData(_activeCategory, '');
    });
  }

  void _updateActiveCategory(String category) {
    setState(() {
      _activeCategory = category;
    });
    _pullRefresh();
  }

  void _onSearch() {
    setState(() {
      _futureFasion = _api.getFilteredData(
        null,
        _activeCategory,
        _textEditingController.text,
      );
      _isSearch = !_isSearch;
    });
  }

  void _clearSearch() {
    _textEditingController.clear();
    _pullRefresh();
    setState(() {
      _isSearch = !_isSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double xPadding = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1200) {
        return _dekstopView(
            colorScheme: colorScheme,
            width: width,
            topPadding: topPadding,
            xPadding: xPadding);
      } else {
        return _mobileTabletView(
            colorScheme: colorScheme,
            width: width,
            topPadding: topPadding,
            xPadding: xPadding);
      }
    }));
  }

  Widget _mobileTabletView({
    required ColorScheme colorScheme,
    required double width,
    required double topPadding,
    required double xPadding,
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
              bottom: topPadding / 2,
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
                const AppBarComponent(
                  action: SizedBox(
                    width: 60,
                  ),
                  title: 'Favorites',
                ),
                SizedBox(
                  height: topPadding / 2,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.07),
                    color: colorScheme.primary,
                  ),
                  padding: const EdgeInsets.all(7),
                  child: TextField(
                    controller: _textEditingController,
                    onSubmitted: (value) => _onSearch(),
                    decoration: InputDecoration(
                      hintText: 'Search your favorite',
                      contentPadding: const EdgeInsets.all(16),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_isSearch) {
                            _onSearch();
                          } else {
                            _clearSearch();
                          }
                        },
                        icon: IconTheme(
                          data: customIconThemeData,
                          child: Icon(
                            _textEditingController.text.isEmpty
                                ? Icons.search_outlined
                                : Icons.highlight_remove_outlined,
                          ),
                        ),
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
          FashionGridView(
            pullRefresh: _pullRefresh,
            futureFasion: _futureFasion,
            updateActiveCategory: _updateActiveCategory,
            activeCategory: _activeCategory,
            radius: width * 0.07,
            crossAxisCount: 2,
            mainAxisSpacing: xPadding - 5,
            crossAxisSpacing: xPadding - 2,
            categorySpacing: xPadding,
            padding: xPadding,
            cardPadding: xPadding,
            isMobileView: true,
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
                    const AppBarComponent(
                      action: SizedBox(
                        width: 60,
                      ),
                      title: 'Favorites',
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: colorScheme.primary,
                      ),
                      padding: const EdgeInsets.all(7),
                      child: TextField(
                        controller: _textEditingController,
                        onSubmitted: (value) => _onSearch(),
                        decoration: InputDecoration(
                          hintText: 'Search your favorite',
                          contentPadding: const EdgeInsets.all(16),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (_isSearch) {
                                _onSearch();
                              } else {
                                _clearSearch();
                              }
                            },
                            icon: IconTheme(
                              data: customIconThemeData,
                              child: Icon(
                                _textEditingController.text.isEmpty
                                    ? Icons.search_outlined
                                    : Icons.highlight_remove_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              FashionGridView(
                pullRefresh: _pullRefresh,
                futureFasion: _futureFasion,
                updateActiveCategory: _updateActiveCategory,
                activeCategory: _activeCategory,
                radius: 7,
                crossAxisCount: 4,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,
                categorySpacing: 7,
                padding: 28,
                cardPadding: 7,
                isMobileView: false,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 8,
                    color: colorScheme.onSurface,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
