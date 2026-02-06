import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchHomeData() async {
  final response = await http.get(
    Uri.parse('https://69858e016964f10bf2538794.mockapi.io/home/1'),
  );

  print('STATUS: ${response.statusCode}');
  print('BODY: ${response.body}');

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Gagal load home data');
  }
}

Future<void> updateHomeData(Map<String, dynamic> homeData) async {
  final response = await http.put(
    Uri.parse('https://69858e016964f10bf2538794.mockapi.io/home/1'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(homeData),
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal update home data');
  }
}
