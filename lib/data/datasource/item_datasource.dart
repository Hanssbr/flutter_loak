import 'dart:convert';

import 'package:project_sem2/data/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:d_method/d_method.dart';

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
}
