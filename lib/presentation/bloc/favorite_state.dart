abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final Map<int, bool> favoriteStatus;

  FavoriteLoaded({required this.favoriteStatus});
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
}
