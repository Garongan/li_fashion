import 'package:flutter/material.dart';
import 'package:li_fashion/shared/services/api_service.dart';
import 'package:li_fashion/core/theme.dart';
import 'package:li_fashion/shared/components/app_bar_component.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/shared/components/custom_fashion_grid_vew.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  final _api = ApiService();
  String _activeCategory = 'Trending';
  late Future<List<Fashion>> _futureFasion;

  @override
  void initState() {
    super.initState();
    _futureFasion = _api.getFashionData(_activeCategory, '');
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _futureFasion = _api.getFashionData(_activeCategory, '');
    });
  }

  void _updateActiveCategory(String category) {
    setState(() {
      _activeCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double width = MediaQuery.of(context).size.width;
    final double topPadding = MediaQuery.of(context).padding.top;
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
                    cursorColor: colorScheme.onSurface,
                    decoration: const InputDecoration(
                      hintText: 'Search your favourite',
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
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
          CustomFashionGridVew(
            pullRefresh: _pullRefresh,
            futureFasion: _futureFasion,
            updateActiveCategory: _updateActiveCategory,
            activeCategory: _activeCategory,
          ),
        ],
      ),
    );
  }
}
