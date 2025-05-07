import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_sem2/presentation/bloc/favorite_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final int itemId;

  FavoriteButton({required this.itemId});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return CircularProgressIndicator();
        } else if (state is FavoriteLoaded) {
          // Check if the item is in the loaded favorite items list
          isFavorite = state.favoriteItems.any((item) => item.id == widget.itemId);
          return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              // Dispatch event to toggle favorite status
              context.read<FavoriteBloc>().add(ToggleFavorite(
                itemId: widget.itemId,
                currentStatus: isFavorite,
              ));
            },
          );
        } else if (state is FavoriteError) {
          return Icon(Icons.error, color: Colors.red);
        }
        return IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.grey),
          onPressed: () {
            context.read<FavoriteBloc>().add(ToggleFavorite(
              itemId: widget.itemId,
              currentStatus: isFavorite,
            ));
          },
        );
      },
    );
  }
}
