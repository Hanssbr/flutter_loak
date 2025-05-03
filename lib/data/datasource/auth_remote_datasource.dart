import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/data/model/user_model.dart';

class AuthRemoteDatasource {
  final AuthLocalDatasource _local = AuthLocalDatasource();
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://givebox.hanssu.my.id/api/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = json.decode(response.body);

    if (response.statusCode == 200 && data['token'] != null) {
      return {'token': data['token'], 'user': UserModel.fromJson(data['user'])};
    } else {
      throw Exception(data['message'] ?? 'Failed to login.');
    }
  }

  Future<void> logout() async {
    final token = await _local.getToken();
    if (token == null) throw Exception('Token not found');

    final response = await http.post(
      Uri.parse('https://givebox.hanssu.my.id/api/logout'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      await _local.removeToken();
    } else {
      throw Exception('Logout gagal');
    }
    
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await http.post(
      Uri.parse('https://givebox.hanssu.my.id/api/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    final data = json.decode(response.body);
    print('Response: $data');

    if (response.statusCode == 200 && data['token'] != null) {
      return {
        'token': data['token'],
        'user': data['data'], // Sesuaikan dengan struktur responsenya
      };
    } else {
      throw Exception(data['message'] ?? 'Failed to register.');
    }
  }
}
