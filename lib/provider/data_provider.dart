import 'package:flutter/material.dart';
import 'dart:convert';
import '../api.dart';
import '../model.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  late var newlugs = fetchLugsData();
  late var newglands = _fetchglandsApiUrl();
  late var newaccessories = _fetchaccessoriesApiUrl();
  late var newconnecters = _fetchconnectersApiUrl();
  late var newcrimpingtool = _fetchcrimpingtoolApiUrl();

  Future<ProduceNewModal> fetchLugsData() async {
    final response = await http
        .get(Uri.parse('http://newdelta.ap-south-1.elasticbeanstalk.com/lugs'),
    //      headers: {
    //   "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    //   "Access-Control-Allow-Credentials":
    //       'true', // Required for cookies, authorization headers with HTTPS
    //   "Access-Control-Allow-Headers":
    //       "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    //   "Access-Control-Allow-Methods": "POST, OPTIONS"
    // }
        );

    if (response.statusCode == 200) {
      ProduceNewModal pro =
          ProduceNewModal.fromJson(json.decode(response.body));
      return pro;
    } else {
      throw Exception('Failed to load data');
    }
  }

  final String lugsApiUrl =
      'http://newdelta.ap-south-1.elasticbeanstalk.com/lugs';
  final String connectorsApiUrl =
      'http://newdelta.ap-south-1.elasticbeanstalk.com/connectors';
  final String glandsApiUrl =
      'http://newdelta.ap-south-1.elasticbeanstalk.com/glands';
  final String accessoriesApiUrl =
      'http://newdelta.ap-south-1.elasticbeanstalk.com/accessories';
  final String crimpingtoolsApiUrl =
      'http://newdelta.ap-south-1.elasticbeanstalk.com/crimpingtools';
  // ... Define URLs for other data types

//for set up the product type for the product details
  Future<ProduceNewModal> setTypeOfProducts(type) async {
    print("fdghjk");
    print(type);
    final response = await http.get(
        Uri.parse('http://newdelta.ap-south-1.elasticbeanstalk.com/$type'));

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

  late Future lugsdata = getProduct(lugsApiUrl);
  late Future connectorsData = getProduct(connectorsApiUrl);

  Future<dynamic> fetchConnectorsData() async {
    final connectorsData = await _fetchDataFromApi(connectorsApiUrl);
    return connectorsData;
  }

  late Future glandData = getProduct(glandsApiUrl);

  Future<dynamic> fetchGlandsData() async {
    final glandData = await _fetchDataFromApi(glandsApiUrl);
    return glandData;
  }

  late Future accessoriesData = getProduct(accessoriesApiUrl);

  Future<dynamic> fetchAccssoriesData() async {
    final accessoriesData = await _fetchDataFromApi(accessoriesApiUrl);
    return accessoriesData;
  }

  late Future crimpingtoolData = getProduct(crimpingtoolsApiUrl);

  Future<dynamic> fetchCrimpingtoolData() async {
    final crimpingtoolData = await _fetchDataFromApi(crimpingtoolsApiUrl);
    return crimpingtoolData;
  }

  int currentUser = 1;

  updateCurrentUser(context, id) {
    currentUser = id;
    notifyListeners();
  }
  // ... Define fetch methods for other data types
}

Future<ProduceNewModal> _fetchglandsApiUrl() async {
  final response = await http
      .get(Uri.parse('http://newdelta.ap-south-1.elasticbeanstalk.com/glands'));

  if (response.statusCode == 200) {
    ProduceNewModal pro = ProduceNewModal.fromJson(json.decode(response.body));
    return pro;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ProduceNewModal> _fetchaccessoriesApiUrl() async {
  final response = await http.get(
      Uri.parse('http://newdelta.ap-south-1.elasticbeanstalk.com/accessories'));

  if (response.statusCode == 200) {
    ProduceNewModal pro = ProduceNewModal.fromJson(json.decode(response.body));
    return pro;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ProduceNewModal> _fetchconnectersApiUrl() async {
  final response = await http.get(
      Uri.parse('http://newdelta.ap-south-1.elasticbeanstalk.com/connectors'));

  if (response.statusCode == 200) {
    ProduceNewModal pro = ProduceNewModal.fromJson(json.decode(response.body));
    return pro;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ProduceNewModal> _fetchcrimpingtoolApiUrl() async {
  final response = await http.get(Uri.parse(
      'http://newdelta.ap-south-1.elasticbeanstalk.com/crimpingtools'));

  if (response.statusCode == 200) {
    ProduceNewModal pro = ProduceNewModal.fromJson(json.decode(response.body));
    return pro;
  } else {
    throw Exception('Failed to load data');
  }
}
