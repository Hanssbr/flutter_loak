part of 'favorit_bloc.dart';

@immutable
abstract class FavoritEvent {}

class LoadFavorit extends FavoritEvent {
  final String token;

  LoadFavorit({required this.token});
}
