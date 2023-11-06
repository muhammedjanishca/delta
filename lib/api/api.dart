
import 'dart:convert';
import '../model.dart';
import 'package:http/http.dart' as http;

Future<ProduceNewModal?> getProduct(String apiUrl) async {
  Uri url = Uri.parse(apiUrl);

  final response = await http.get(url, headers: {});

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final ProduceNewModal product = ProduceNewModal.fromJson(jsonResponse);

    return product;
  } else {
    throw Exception('Failed to fetch product');
  }
}