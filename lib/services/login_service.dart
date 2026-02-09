import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const _binId = '69897ff5d0ea881f40ac5ddb';
  static const _apiKey =
      r'$2a$10$SBxHBCT/sN.tdizqTt46jOxqkaJviXhoWzn9yoSY.GO4z4Nmy5CEO';

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final res = await http.get(
      Uri.parse('https://api.jsonbin.io/v3/b/$_binId/latest'),
      headers: {'X-Master-Key': _apiKey},
    );

    if (res.statusCode != 200) {
      throw Exception('Gagal koneksi ke server');
    }

    final body = json.decode(res.body);
    final List users = body['record']['users'];

    final user = users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => null,
    );

    if (user == null) {
      throw Exception('Email atau Username atau Password salah');
    }

    return user;
  }
}
