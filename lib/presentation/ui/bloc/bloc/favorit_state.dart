part of 'favorit_bloc.dart';

@immutable
sealed class FavoritState {}

final class FavoritInitial extends FavoritState {}

final class FavoritLoading extends FavoritState {}

final class FavoritFailure extends FavoritState {
  final String message;
  FavoritFailure(this.message);
}

class FavoritLoaded extends FavoritState {
  final List<Favorit> favorits;
  FavoritLoaded(this.favorits);
}

