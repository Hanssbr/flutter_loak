import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart' as http;
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/data/model/item_model.dart';

class ItemsSource {
  static Future<List<Items>?> getItems() async {
    String url = "https://givebox.hanssu.my.id/api/all-items";
    final response = await http.get(Uri.parse(url));
    DMethod.logResponse(response);

    try {
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        List list = decoded['data'];
        List<Items> items =
            list.map((e) => Items.fromJson(Map.from(e))).toList();
        return items;
      } else {
        return null;
      }
    } catch (e) {
      DMethod.log(e.toString());
      return null;
    }
  }

  Future<void> favoriteItem(int itemId) async {
    final local = AuthLocalDatasource();
    final token = await local.getToken();

    if (token == null) {
      print('[ERROR] Token tidak ditemukan!');
      return;
    }

    final url = Uri.parse(
      'https://givebox.hanssu.my.id/api/items/$itemId/favorite',
    );

    final response = await http.post(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print('[SUCCESS] Item berhasil difavoritkan.');
      print('[INFO] Response Body: ${response.body}');
    } else {
      print('[ERROR] Gagal favorite item. Status: ${response.statusCode}');
      print('[BODY] ${response.body}');
    }
  }
}
