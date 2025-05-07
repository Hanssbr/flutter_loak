import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:project_sem2/data/model/item_model.dart';

class CreateitemsDatasource {
  static Future<bool> createItem(
    Items item,
    dynamic photoFile,
    String token,
  ) async {
    try {
      final uri = Uri.parse('https://givebox.hanssu.my.id/api/all-items');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['name'] = item.name ?? '';
      request.fields['description'] = item.description ?? '';
      request.fields['category'] = item.category ?? '';
      request.fields['condition'] = item.condition ?? '';
      request.fields['location'] = item.location ?? '';
      request.fields['user_id'] = item.userId ?? '';

      if (!kIsWeb && photoFile is File) {
        final mimeType = lookupMimeType(photoFile.path)?.split('/');
        request.files.add(
          await http.MultipartFile.fromPath(
            'photo',
            photoFile.path,
            contentType:
                mimeType != null ? MediaType(mimeType[0], mimeType[1]) : null,
          ),
        );
      } else if (kIsWeb && photoFile is Uint8List) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'photo',
            photoFile,
            filename: 'upload.jpg',
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('Status: ${response.statusCode}');
      print('Body: $responseBody');

      return response.statusCode == 200;
    } catch (e) {
      print("Create Item Exception: $e");
      return false;
    }
  }
}
