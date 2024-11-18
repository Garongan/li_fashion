import 'package:flutter/material.dart';
import 'package:li_fashion/shared/services/favorite_service.dart';

class FavoriteButtonComponent extends StatefulWidget {
  final String id;
  final double padding;
  final Color? background;
  const FavoriteButtonComponent({super.key, required this.id, required this.padding, this.background});

  @override
  State<FavoriteButtonComponent> createState() =>
      _FavoriteButtonComponentState();
}

class _FavoriteButtonComponentState extends State<FavoriteButtonComponent> {
  final _favoriteService = FavoriteService();
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    bool favoriteStatus = await _favoriteService.getLoved(widget.id);
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
      await _favoriteService.saveLoved(widget.id, true);
    } else {
      await _favoriteService.deleteLoved(widget.id);
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
