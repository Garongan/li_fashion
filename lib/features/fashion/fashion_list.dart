import 'package:flutter/material.dart';
import 'package:li_fashion/core/google_sheets_api.dart';
import 'package:li_fashion/core/theme.dart';
import 'package:li_fashion/features/fashion/components/custom_app_bar.dart';
import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/shared/components/custom_fashion_grid_vew.dart';

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
          CustomFashionGridVew(
            pullRefresh: _pullRefresh,
            futureFasion: _futureFasion,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
