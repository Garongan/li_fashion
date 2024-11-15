import 'package:flutter/material.dart';
import 'package:li_fashion/features/fashion/fashion_service.dart';

class FavouriteButtonComponent extends StatefulWidget {
  final String id;
  final double padding;
  final Color? background;
  const FavouriteButtonComponent({super.key, required this.id, required this.padding, this.background});

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
        color: widget.background == null ? colorScheme.outline : widget.background!,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: _toggleLoved,
        icon: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_outline,
          ),
        ),
      ),
    );
  }
}
