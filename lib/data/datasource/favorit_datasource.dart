import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart' as http;
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/data/model/favorit_model.dart';

class FavoritDatasource {
  static Future<List<Favorit>?> getFavorits(String token) async {
    String url = "https://givebox.hanssu.my.id/api/favorit";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer $token',
      },
    );
    DMethod.logResponse(response);
    try {
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        // Langsung mengolah decoded yang berupa List
        if (decoded is List) {
          List<Favorit> favoritItems =
              decoded.map((e) => Favorit.fromJson(Map.from(e))).toList();
          return favoritItems;
        } else {
          return null; // Jika decoded bukan List
        }
      } else {
        return null;
      }
    } catch (e) {
      DMethod.log("Response body: ${response.body}");

      DMethod.log(e.toString());
      return null;
    }
  }

  Future<bool> checkFavoriteStatusFromApi(int itemId) async {
    final local = AuthLocalDatasource();
    final token = await local.getToken();

    if (token == null) {
      throw Exception("Token tidak ditemukan");
    }

    final favorites = await FavoritDatasource.getFavorits(token);

    if (favorites == null) return false;

    return favorites.any((favorit) => favorit.itemId == itemId.toString());
  }
}
