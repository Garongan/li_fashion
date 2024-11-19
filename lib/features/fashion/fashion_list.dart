import 'package:flutter/material.dart';
import 'package:li_fashion/core/theme.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/shared/components/app_bar_component.dart';
import 'package:li_fashion/shared/components/fashion_grid_view.dart';
import 'package:li_fashion/shared/services/api_service.dart';

class FashionList extends StatefulWidget {
  const FashionList({super.key});

  @override
  State<FashionList> createState() => _FashionListState();
}

class _FashionListState extends State<FashionList> {
  final _api = ApiService();
  String _activeCategory = 'Trending';
  late Future<List<Fashion>> _futureFasion;
  late TextEditingController _textEditingController;
  bool _isSearch = true;

  @override
  void initState() {
    super.initState();
    _futureFasion = _api.getFilteredData(null, _activeCategory, '');
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _futureFasion = _api.getFilteredData(null, _activeCategory, '');
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double xPadding = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1200) {
        return _DekstopView(
          colorScheme: colorScheme,
          width: width,
          topPadding: topPadding,
          xPadding: xPadding,
          textEditingController: _textEditingController,
          onSearch: _onSearch,
          isSearch: _isSearch,
          clearSearch: _clearSearch,
          pullRefresh: _pullRefresh,
          futureFasion: _futureFasion,
          updateActiveCategory: _updateActiveCategory,
          activeCategory: _activeCategory,
        );
      } else {
        return _MobileTabletView(
          colorScheme: colorScheme,
          width: width,
          topPadding: topPadding,
          xPadding: xPadding,
          textEditingController: _textEditingController,
          onSearch: _onSearch,
          isSearch: _isSearch,
          clearSearch: _clearSearch,
          pullRefresh: _pullRefresh,
          futureFasion: _futureFasion,
          updateActiveCategory: _updateActiveCategory,
          activeCategory: _activeCategory,
        );
      }
    }));
  }
}

class _MobileTabletView extends StatelessWidget {
  final ColorScheme colorScheme;
  final double width;
  final double topPadding;
  final double xPadding;
  final TextEditingController textEditingController;
  final Function onSearch;
  final bool isSearch;
  final Function clearSearch;
  final RefreshCallback pullRefresh;
  final Future<List<Fashion>> futureFasion;
  final Function(String) updateActiveCategory;
  final String activeCategory;

  const _MobileTabletView({
    required this.colorScheme,
    required this.width,
    required this.topPadding,
    required this.xPadding,
    required this.textEditingController,
    required this.onSearch,
    required this.isSearch,
    required this.clearSearch,
    required this.pullRefresh,
    required this.futureFasion,
    required this.updateActiveCategory,
    required this.activeCategory,
  });

  @override
  Widget build(BuildContext context) {
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
                const AppBarComponent(),
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
                    controller: textEditingController,
                    onSubmitted: (value) => onSearch(),
                    decoration: InputDecoration(
                      hintText: 'Search your needs',
                      contentPadding: const EdgeInsets.all(16),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (isSearch) {
                            onSearch();
                          } else {
                            clearSearch();
                          }
                        },
                        icon: IconTheme(
                          data: customIconThemeData,
                          child: Icon(
                            textEditingController.text.isEmpty
                                ? Icons.search_outlined
                                : Icons.highlight_remove_outlined,
                          ),
                        ),
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
          FashionGridView(
            pullRefresh: pullRefresh,
            futureFasion: futureFasion,
            updateActiveCategory: updateActiveCategory,
            activeCategory: activeCategory,
            radius: width * 0.07,
            crossAxisCount: 2,
            mainAxisSpacing: xPadding - 5,
            crossAxisSpacing: xPadding - 2,
            categorySpacing: xPadding,
            padding: xPadding,
            cardPadding: xPadding,
            isMobileView: true,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

class _DekstopView extends StatelessWidget {
  final ColorScheme colorScheme;
  final double width;
  final double topPadding;
  final double xPadding;
  final TextEditingController textEditingController;
  final Function onSearch;
  final bool isSearch;
  final Function clearSearch;
  final RefreshCallback pullRefresh;
  final Future<List<Fashion>> futureFasion;
  final Function(String) updateActiveCategory;
  final String activeCategory;

  const _DekstopView({
    required this.colorScheme,
    required this.width,
    required this.topPadding,
    required this.xPadding,
    required this.textEditingController,
    required this.onSearch,
    required this.isSearch,
    required this.clearSearch,
    required this.pullRefresh,
    required this.futureFasion,
    required this.updateActiveCategory,
    required this.activeCategory,
  });

  @override
  Widget build(BuildContext context) {
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
                    const AppBarComponent(),
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
                        controller: textEditingController,
                        onSubmitted: (value) => onSearch(),
                        decoration: InputDecoration(
                          hintText: 'Search your needs',
                          contentPadding: const EdgeInsets.all(16),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (isSearch) {
                                onSearch();
                              } else {
                                clearSearch();
                              }
                            },
                            icon: IconTheme(
                              data: customIconThemeData,
                              child: Icon(
                                textEditingController.text.isEmpty
                                    ? Icons.search_outlined
                                    : Icons.highlight_remove_outlined,
                              ),
                            ),
                          ),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              FashionGridView(
                pullRefresh: pullRefresh,
                futureFasion: futureFasion,
                updateActiveCategory: updateActiveCategory,
                activeCategory: activeCategory,
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
