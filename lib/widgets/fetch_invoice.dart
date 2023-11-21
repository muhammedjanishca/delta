import 'dart:convert';

import 'package:http/http.dart' as http;

// Future<String> fetchInvoiceNumber() async {
//   final response = await http.get(
//     Uri.parse('https://deltabackend.com/fetchinvoice'),
//   );

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = json.decode(response.body);
//     final String invoiceNumber = data['invoiceNumber'].toString();
//     return invoiceNumber;
//   } else {
//     print('Failed to fetch latest invoice number');
//     return 'N/A'; // Handle the case when fetching fails
//   }
// }

class Album {
  final String id;

  const Album({
    required this.id,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'invoiceNumber': String id,
      } =>
        Album(
          id: id,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

Future<Services> fetchServices() async {
  final response =
      await http.get(Uri.parse('https://deltabackend.com/fetchinvoice'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    return Services.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // throw an exception.
    throw Exception('Failed to load services');
  }
}

Services servicesFromJson(String str) => Services.fromJson(json.decode(str));

String servicesToJson(Services data) => json.encode(data.toJson());

class Services {
  int? invoiceNumber;

  Services({
    this.invoiceNumber,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        invoiceNumber: json["invoiceNumber"],
      );

  Map<String, dynamic> toJson() => {
        "invoiceNumber": invoiceNumber,
      };
}
