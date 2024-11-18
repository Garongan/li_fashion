import 'package:flutter/material.dart';
import 'package:li_fashion/core/google_sheets_api.dart';

class CategoryListComponent extends StatefulWidget {
  final double width;
  final double xPadding;
  final Function(String) updateActiveCategory;
  final String activeCategory;
  const CategoryListComponent({
    super.key,
    required this.width,
    required this.xPadding,
    required this.updateActiveCategory,
    required this.activeCategory,
  });

  @override
  State<CategoryListComponent> createState() => _CategoryListComponentState();
}

class _CategoryListComponentState extends State<CategoryListComponent> {
  final _api = GoogleSheetsApi();
  List<List<dynamic>> _category = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final category = await _api.getSpreadsheetData('Sheet2');
      setState(() {
        _category = category;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  bool _checkActiveCategory(String category) {
    if (widget.activeCategory == category) {
      return true;
    }
    return false;
  }

  void _changeCategory(String category) {
    widget.updateActiveCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: widget.width - (widget.xPadding * 2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: widget.xPadding,
          children: List.generate(
            _category.length,
            (index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.width * 0.07),
                  color: _checkActiveCategory(_category[index].join(''))
                      ? colorScheme.onSurface
                      : colorScheme.surface,
                  border: Border.all(
                    width: 1,
                    color: colorScheme.onSurface.withAlpha(50),
                  ),
                ),
                child: TextButton(
                  onPressed: () => _changeCategory(_category[index].join('')),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text(
                      _category[index].join(''),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.15,
                        color: _checkActiveCategory(_category[index].join(''))
                            ? colorScheme.surface
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
