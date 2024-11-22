import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:li_fashion/core/theme.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/shared/components/app_bar_component.dart';
import 'package:li_fashion/shared/components/fashion_grid_view.dart';
import 'package:li_fashion/shared/services/api_service.dart';
import 'package:li_fashion/shared/services/fashion_service.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  final _api = ApiService();
  final _fashionService = FashionService();
  String _activeCategory = 'Trending';
  late TextEditingController _textEditingController;
  bool _isSearch = true;
  static const pageSize = 12;
  final PagingController<int, Fashion> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _api.getFashionData(
        pageKey,
        pageSize,
      );
      final isLastPage = newItems.isEmpty;
      final lovedData = await _fashionService.getLovedFashionData(
        newItems,
        _activeCategory,
        _textEditingController.text,
      );

      if (isLastPage) {
        _pagingController.appendLastPage(lovedData);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(lovedData, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _updateActiveCategory(String category) {
    setState(() {
      _activeCategory = category;
    });
    _pagingController.refresh();
  }

  Future<void> _onSearch() async {
    _pagingController.refresh();
    setState(() {
      _isSearch = !_isSearch;
    });
  }

  void _clearSearch() {
    _textEditingController.clear();
    _pagingController.refresh();
    setState(() {
      _isSearch = !_isSearch;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final topPadding = MediaQuery.of(context).padding.top;
    final xPadding = MediaQuery.of(context).size.width * 0.03;

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
                const AppBarComponent(
                  action: SizedBox(
                    width: 60,
                  ),
                  title: 'Favorites',
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
                    controller: _textEditingController,
                    onSubmitted: (value) => _onSearch(),
                    style: const TextStyle(
                      color: Color(0xff000000),
                    ),
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
            pagingController: _pagingController,
          ),
          const SizedBox(
            height: 5,
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
                pagingController: _pagingController,
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
