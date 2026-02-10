import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeService {
  static const _url = 'https://69858e016964f10bf2538794.mockapi.io/home/1';

  static Future<Map<String, dynamic>> fetchHome() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal load home data');
    }
  }

  static Future<void> updateHome(Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update home data');
    }
  }
}
