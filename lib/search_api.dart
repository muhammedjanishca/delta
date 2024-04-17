import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  final TextEditingController easySearchController = TextEditingController();
  List<Map<String, dynamic>> products = [];

  Future<List<Map<String, dynamic>>> fetchData(String query) async {
    try {
      final response = await http.get(
        Uri.parse('https://ready.deltabackend.com/searching?query=$query'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load search data');
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  void searchProducts(String query) async {
    try {
      final data = await fetchData(query);
      products = data;
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
}
