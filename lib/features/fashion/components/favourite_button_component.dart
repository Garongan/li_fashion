import 'package:flutter/material.dart';
import 'package:li_fashion/features/fashion/fashion_service.dart';

class FavouriteButtonComponent extends StatefulWidget {
  final String id;
  const FavouriteButtonComponent({super.key, required this.id});

  @override
  State<FavouriteButtonComponent> createState() =>
      _FavouriteButtonComponentState();
}

class _FavouriteButtonComponentState extends State<FavouriteButtonComponent> {
  final _fashionService = FashionService();
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    bool favoriteStatus = await _fashionService.getLoved(widget.id);
    if (mounted) {
      setState(() {
        isFavorite = favoriteStatus;
      });
    }
  }

  Future<void> _toggleLoved() async {
    if (mounted) {
      setState(() {
        isFavorite = !isFavorite;
      });
    }
    if (isFavorite == true) {
      await _fashionService.saveLoved(widget.id, true);
    } else {
      await _fashionService.deleteLoved(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: _toggleLoved,
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_outline,
        ),
      ),
    );
  }
}
