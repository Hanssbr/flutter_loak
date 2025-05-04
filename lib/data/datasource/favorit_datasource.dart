import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:project_sem2/data/model/favorit_model.dart';
import 'package:http/http.dart' as http;

class FavoritDatasource {

    static Future<List<Favorit>?> getFavorits(String token) async {
    String url = "https://givebox.hanssu.my.id/api/favorit";
    final response = await http.get(Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });
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
      DMethod.log(e.toString());
      return null;
    }
  }
  
}