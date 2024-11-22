import 'package:li_fashion/features/fashion/fashion.dart';
import 'package:li_fashion/shared/services/favorite_service.dart';

class FashionService {
  Future<List<Fashion>> getFilteredData(
    List<Fashion> fashions,
    String category,
    String search,
  ) async {
    if (category == 'All' && search.isEmpty) {
      return fashions;
    }

    if (category == 'All' && search.isNotEmpty) {
      return fashions
          .where((value) =>
              value.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    if (search.isNotEmpty) {
      return fashions
          .where((value) =>
              value.category.contains(category) &&
              value.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    return fashions
        .where((value) => value.category.contains(category))
        .toList();
  }

  Future<List<Fashion>> getLovedFashionData(
    List<Fashion> fashions,
    String category,
    String search,
  ) async {
    List<Fashion> lovedFashions = [];

    final favoriteService = FavoriteService();

    for (var value in fashions) {
      final id = '${value.name}_${value.price}';
      bool isLoved = await favoriteService.getLoved(id);
      if (isLoved) {
        lovedFashions.add(value);
      }
    }

    return getFilteredData(lovedFashions, category, search);
  }
}
