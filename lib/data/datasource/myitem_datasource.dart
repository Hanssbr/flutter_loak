import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';

import '../model/myitem_model.dart';

class MyItemDatasource {
  static Future<List<MyItems>?> getMyItems() async {
    final token = await AuthLocalDatasource().getToken(); // Ambil token login
    final url = Uri.parse('https://givebox.hanssu.my.id/api/my-items');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> itemsJson = data['data'];

        return itemsJson.map((json) => MyItems.fromJson(json)).toList();
      } else {
        print('Gagal mengambil data. Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error saat mengambil data: $e');
      return null;
    }
  }

  static Future<bool> deleteMyItem(int itemId) async {
    final token = await AuthLocalDatasource().getToken();
    final url = Uri.parse('https://givebox.hanssu.my.id/api/my-items/$itemId');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Item berhasil dihapus');
        return true;
      } else {
        print('Gagal menghapus item. Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error saat menghapus item: $e');
      return false;
    }
  }
}
