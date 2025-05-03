import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:project_sem2/data/model/recomends_model.dart';
import 'package:http/http.dart' as http;

class RecomendsDatasource {
  static Future<List<RecomendItems>?> getRecomends() async {
    String url = "https://givebox.hanssu.my.id/api/recommendation";
    final response = await http.get(Uri.parse(url));
    DMethod.logResponse(response);
    try {
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        
        // Langsung mengolah decoded yang berupa List
        if (decoded is List) {
          List<RecomendItems> recomendsItems =
              decoded.map((e) => RecomendItems.fromJson(Map.from(e))).toList();
          return recomendsItems;
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
