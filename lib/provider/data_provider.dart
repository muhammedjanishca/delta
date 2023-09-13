import 'package:flutter/material.dart';
import 'dart:convert';
import '../api.dart';
import '../model.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  late var newlugs = _fetchLugsData();
  late var newglands = _fetchglandsApiUrl();
  late var newaccessories = _fetchaccessoriesApiUrl();
  late var newconnecters = _fetchconnectersApiUrl();
  late var newcrimpingtool = _fetchcrimpingtoolApiUrl();


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
 final response = await http
      .get(Uri.parse('http://newdelta.ap-south-1.elasticbeanstalk.com/$type'));
  print("++++++++++++++++++++++++++++++");
  print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    ProduceNewModal pro = ProduceNewModal.fromJson(json.decode(response.body));
    return pro;
  } else {
    throw Exception('Failed to load data');
  } 
  }

  Future<dynamic> _fetchDataFromApi(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));
    print("++++++++++++++++++++++++++++++");
    print(response.statusCode);
    // print(response.body);
    print('gggggggggggggggggg');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  late Future lugsdata = getProduct(lugsApiUrl);

  Future<dynamic> fetchLugsData() async {
    final lugsData = await _fetchDataFromApi(lugsApiUrl);
    return lugsData;
  }

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
    // ignore: curly_braces_in_flow_control_structures
    //for (int i = 0; i < currentUser; i++)
    notifyListeners();
  }

  // ... Define fetch methods for other data types
}
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ytalk/Model/FeedModal/Image_Model.dart';

// Future<ImageModel?> getImage() async {
//   // log("bsnvgfds");
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final retrieve = prefs.getString('access_token');
//   Uri url = Uri.parse('https://thewhytalks.com/api/feed/images');
//   final response = await http.get(url, headers: {
//     'Authorization': 'Bearer $retrieve',
//   });
//   print(response.statusCode);
//   print('llllllll');
//   if (response.statusCode == 200) {
//     print(response);
//     ImageModel? imageapi = imageModelFromJson(response.body);
//     print(imageapi);

//     return imageapi;
//   } else {
//     throw Exception();
//   }
// }

Future<ProduceNewModal> _fetchLugsData() async {
  final response = await http
      .get(Uri.parse('http://newdelta.ap-south-1.elasticbeanstalk.com/lugs'));
  print("++++++++++++++++++++++++++++++");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    ProduceNewModal pro = ProduceNewModal.fromJson(json.decode(response.body));
    return pro;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ProduceNewModal> _fetchglandsApiUrl() async {
  final response = await http
      .get(Uri.parse('http://newdelta.ap-south-1.elasticbeanstalk.com/glands'));
  print("++++++++++++++++++++++++++++++");
  print(response.statusCode);
  print(response.body);
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
  print("++++++++++++++++++++++++++++++");
  print(response.statusCode);
  print(response.body);
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
  print("++++++++++++++++++++++++++++++");
  print(response.statusCode);
  print(response.body);
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
  print("++++++++++++++++++++++++++++++");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    ProduceNewModal pro = ProduceNewModal.fromJson(json.decode(response.body));
    return pro;
  } else {
    throw Exception('Failed to load data');
  }
}