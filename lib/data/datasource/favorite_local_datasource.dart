import 'package:http/http.dart' as http;
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteLocalDatasource {
  // Menyimpan status favorit
  Future<void> saveFavoriteStatus(String itemId, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(itemId, isFavorite);
  }

  // Mengambil status favorit
  Future<bool> getFavoriteStatus(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(itemId) ?? false; // Default false jika belum ada
  }
}

Future<String> favoriteItem(int itemId) async {
  final local = AuthLocalDatasource();
  final token = await local.getToken();

  if (token == null) {
    print('[ERROR] Token tidak ditemukan!');
    return 'error'; // Return error status if no token found
  }

  final url = Uri.parse(
    'https://givebox.hanssu.my.id/api/items/$itemId/favorite',
  );

  try {
    final response = await http.post(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    print('[INFO] Status Code: ${response.statusCode}');
    print('[INFO] Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the response body as needed
      print('[SUCCESS] Item berhasil difavoritkan.');
      return 'favorited'; // Return "favorited" when successfully added
    } else {
      print('[ERROR] Gagal favorite item. Status: ${response.statusCode}');
      return 'error'; // Return error status in case of failure
    }
  } catch (e) {
    print('[ERROR] Error saat menghubungi API: $e');
    return 'error'; // Return error status if exception occurs
  }
}
