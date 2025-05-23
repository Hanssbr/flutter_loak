import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:project_sem2/data/datasource/auth_local_datasource.dart';
import 'package:project_sem2/data/model/user_model.dart';

class AuthRemoteDatasource {
  final http.Client client;
  final AuthLocalDatasource _local = AuthLocalDatasource();

  AuthRemoteDatasource({http.Client? client})
    : client = client ?? http.Client();

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

  // Future<void> logout() async {
  //   final token = await _local.getToken();
  //   if (token == null) throw Exception('Token not found');

  //   final response = await http.post(
  //     Uri.parse('https://givebox.hanssu.my.id/api/logout'),
  //     headers: {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     await _local.removeToken();
  //   } else {
  //     throw Exception('Logout gagal');
  //   }
  // }

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
      await _local.clearToken();
    } else {
      await _local.clearToken();
      throw Exception('Logout gagal');
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
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
        'phone': phone,
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

  Future<UserModel> getCurrentUser(String token) async {
    final response = await client.get(
      Uri.parse('https://givebox.hanssu.my.id/api/user'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Gagal mengambil user: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String name,
    required String email,
    required String phone,
    Uint8List? photoBytes,
    String? photoFilename,
  }) async {
    var uri = Uri.parse('https://givebox.hanssu.my.id/api/profile/update');

    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone'] = phone;

    if (photoBytes != null && photoFilename != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'photo', // nama field yang diterima backend
          photoBytes,
          filename: photoFilename,
          contentType: MediaType(
            'image',
            'jpeg',
          ), // import dari package:http_parser/http_parser.dart
        ),
      );
    }

    final streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.bytesToString();
    final decoded = jsonDecode(responseBody);

    if (streamedResponse.statusCode == 200) {
      return decoded;
    } else {
      throw Exception(decoded['message'] ?? 'Gagal update profil');
    }
  }
}
