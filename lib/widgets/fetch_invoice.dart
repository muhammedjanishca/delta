import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Services> fetchServices() async {
  final response =
      await http.post(Uri.parse('https://deltabackend.com/store_invoice'));

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
  String? u_id;

  Services({
    this.invoiceNumber,
    this.u_id,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        invoiceNumber: json["invoice_id"],
        u_id: json["u_id"],
      );

  Map<String, dynamic> toJson() => {
        "invoiceNumber": invoiceNumber,
        "u_id": u_id,
      };
}
