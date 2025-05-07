import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/data/model/favorited_model.dart';

// Event
abstract class FavoriteEvent {}

class ToggleFavorite extends FavoriteEvent {
  final int itemId;
  final bool currentStatus;

  ToggleFavorite({required this.itemId, required this.currentStatus});
}

// State
abstract class FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Favorited> favoriteItems;

  FavoriteLoaded({required this.favoriteItems});
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
}

// Bloc
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteLoading());

  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is ToggleFavorite) {
      yield* _toggleFavorite(event.itemId, event.currentStatus);
    }
  }

  Stream<FavoriteState> _toggleFavorite(int itemId, bool currentStatus) async* {
    try {
      yield FavoriteLoading();
      final local = AuthLocalDatasource();
      final token = await local.getToken();

      if (token == null) {
        yield FavoriteError(message: 'Token tidak ditemukan!');
        return;
      }

      final url = Uri.parse(
        'https://givebox.hanssu.my.id/api/items/$itemId/favorite',
      );
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final favoriteItem = Favorited.fromJson(responseBody['data']);
        yield FavoriteLoaded(favoriteItems: [favoriteItem]);
      } else {
        yield FavoriteError(message: 'Gagal mengubah status favorit.');
      }
    } catch (e) {
      yield FavoriteError(message: 'Terjadi kesalahan: $e');
    }
  }
}
