import 'package:flutter/material.dart';
import 'dart:convert';
import '../api.dart';
import '../model.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  late var newlugs = fetchLugsData();
  late var newglands = fetchglandsApiUrl();
  late var newaccessories = fetchaccessoriesApiUrl();
  late var newconnecters = fetchconnectersApiUrl();
  late var newcrimpingtool = fetchcrimpingtoolApiUrl();
  late var newconduits = fetchconduitsApiUrl();
  late var newelpsAccessories = fetchElpsAssessoriesData();
  late var newElps = fetchElpsData();
  late var newSsctm = fetchSsctmData();
  late var newCjtkc = fetchCjtkcData();
  late var newSbcpa = fetchsbcpaData();
  late var news = fetchCjtkcData();
  
  Color addedColor = Colors.white;
  Color changedColor = Colors.blue;
  List<Color> colors = [];
  addColor(int length) {
    colors.clear();
    colors = List.generate(length, (index) => addedColor);
  }
  changeTappedColor(int index) {
    colors[index] = changedColor;
    notifyListeners();
  }

  Future<ProduceNewModal> fetchsbcpaData() async {
    final response =
        await http.get(Uri.parse('https://deltabackend.com/sb_cpa'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProduceNewModal> fetchElpsData() async {
    final response = await http.get(Uri.parse('https://deltabackend.com/elps'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProduceNewModal> fetchCjtkcData() async {
    final response =
        await http.get(Uri.parse('https://deltabackend.com/cj_tkc'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }
  // Future<ProduceNewModal> fetchsbcpaData() async {
  //   final response = await http
  //       .get(Uri.parse('https://deltabackend.com/sb_cpa'));

  //   if (response.statusCode == 200) {
  //     ProduceNewModal pro =
  //         ProduceNewModal.fromJson(json.decode(response.body));
  //     return pro;
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  Future<ProduceNewModal> fetchSsctmData() async {
    final response =
        await http.get(Uri.parse('https://deltabackend.com/ssctm'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProduceNewModal> fetchLugsData() async {
    final response = await http.get(Uri.parse('https://deltabackend.com/lugs'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProduceNewModal> fetchElpsAssessoriesData() async {
    final response =
        await http.get(Uri.parse('https://deltabackend.com/elps-accessories'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProduceNewModal> fetchglandsApiUrl() async {
    final response =
        await http.get(Uri.parse('https://deltabackend.com/glands'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProduceNewModal> fetchconnectersApiUrl() async {
    final response =
        await http.get(Uri.parse('https://deltabackend.com/connectors'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProduceNewModal> fetchaccessoriesApiUrl() async {
    final response =
        await http.get(Uri.parse('https://deltabackend.com/accessories'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProduceNewModal> fetchcrimpingtoolApiUrl() async {
    final response =
        await http.get(Uri.parse('https://deltabackend.com/crimpingtools'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ProduceNewModal> fetchconduitsApiUrl() async {
    final response =
        await http.get(Uri.parse('https://deltabackend.com/conduits'));

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

//for set up the product type for the product details
  Future<ProduceNewModal> setTypeOfProducts(type) async {
    // print("fdghjk");
    // print(type);
    final response =
        await http.get(Uri.parse('https://deltabackend.com/$type'));

    if (response.statusCode == 200) {
      // print(response.body);
      // print("lnjl");
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> _fetchDataFromApi(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  int currentUser = 1;

  updateCurrentUser(context, id) {
    currentUser = id;
    notifyListeners();
  }
  // ... Define fetch methods for other data types
}
