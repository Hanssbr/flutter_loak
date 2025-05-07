import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  static const _keyToken = 'token';

  Future<void> saveToken(String token) async {
    final sharedpreferences = await SharedPreferences.getInstance();
    await sharedpreferences.setString(_keyToken, token);
    print('[SAVE] Token: $token');
  }

  Future<String?> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_keyToken);
  }

  // Future<void> removeToken() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.remove(_keyToken);
  // }

  Future<void> clearAll() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear(); // Menghapus semua data
    print('[CLEAR] Semua data di SharedPreferences telah dihapus.');
  }
  
}
