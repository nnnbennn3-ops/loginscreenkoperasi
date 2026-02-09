import 'dart:convert';
import 'package:http/http.dart' as http;

const _baseUrl = 'https://69858e016964f10bf2538794.mockapi.io';

Future<Map<String, dynamic>> fetchLoanDetail() async {
  final res = await http.get(Uri.parse('$_baseUrl/pinjaman'));

  print('Status Code: ${res.statusCode}');
  print('Response Body: ${res.body}');

  if (res.statusCode == 200) {
    final List list = json.decode(res.body);
    return list.first;
  } else {
    throw Exception('Gagal load data pinjaman');
  }
}

Future<void> updateLoanDetail(Map<String, dynamic> data) async {
  final id = data['id'];

  final res = await http.put(
    Uri.parse('$_baseUrl/pinjaman/$id'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data),
  );

  if (res.statusCode != 200) {
    throw Exception('Gagal update data pinjaman');
  }
}
