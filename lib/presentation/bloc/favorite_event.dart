abstract class FavoriteEvent {}

class ToggleFavorite extends FavoriteEvent {
  final int itemId;
  final bool currentStatus;

  ToggleFavorite({required this.itemId, required this.currentStatus});
}

class LoadFavorites extends FavoriteEvent {}
