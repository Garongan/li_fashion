import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:li_fashion/core/google_sheets_api.dart';
import 'package:li_fashion/core/theme.dart';
import 'package:li_fashion/features/favourite/favourite_list.dart';

class FashionList extends StatefulWidget {
  const FashionList({super.key});

  @override
  State<FashionList> createState() => _FashionListState();
}

class _FashionListState extends State<FashionList> {
  final _api = GoogleSheetsApi();

  List<List<dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await _api.getSpreadsheetData('Sheet1');
      setState(() {
        _data = data.skip(1).toList();
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
                        child: Icon(Icons.favorite_outline_outlined),
                      ),
                    ),
                  ),
                ],
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
            child: _data.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.onSurface,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: xPadding,
                    ),
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: xPadding,
                        ),
                        title: Text(
                          _data[index].join('|'),
                          textAlign: TextAlign.justify,
                        ),
                      );
                    },
                  ),
          ),
        ),
      ]),
    );
  }
}
