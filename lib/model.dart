
import 'dart:convert';

ProduceNewModal produceNewModalFromJson(String str) =>
    ProduceNewModal.fromJson(json.decode(str));

String produceNewModalToJson(ProduceNewModal data) =>
    json.encode(data.toJson());

class ProduceNewModal {
  List<Datum> data;

  ProduceNewModal({
    required this.data,
  });

  factory ProduceNewModal.fromJson(Map<String, dynamic> json) =>
      ProduceNewModal(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? productName;
  String? thumbnail;
  List<String>? images;
  String? description;
  String? priceofproduct;
  List<CodesAndPrice>? codesAndPrice;
  String? pdf;
  Datum({
    this.id,
    this.productName,
    this.thumbnail,
    this.images,
    this.description,
    this.codesAndPrice,
    this.priceofproduct,
    this.pdf,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productName: json["product_name"],
        thumbnail: json["thumbnail"],
        images: List<String>.from(json["images"].map((x) => x)),
        description: json["description"],
        codesAndPrice: List<CodesAndPrice>.from(
            json["codes_and_price"].map((x) => CodesAndPrice.fromJson(x))),
            priceofproduct: json["priceofproduct"],
        pdf: json["pdf"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "thumbnail": thumbnail,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "description": description,
        "codes_and_price":
            List<dynamic>.from(codesAndPrice!.map((x) => x.toJson())),
            "priceofproduct":priceofproduct,
        "pdf": pdf,
      };
}

class CodesAndPrice {
  String? productCode;
  String? price;

  CodesAndPrice({
    this.productCode,
    this.price,
  });

  factory CodesAndPrice.fromJson(Map<String, dynamic> json) => CodesAndPrice(
        productCode: json["product_code"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "product_code": productCode,
        "price": price,
      };
}

// To parse this JSON data, do
//
//     final services = servicesFromJson(jsonString);


Services servicesFromJson(String str) => Services.fromJson(json.decode(str));

String servicesToJson(Services data) => json.encode(data.toJson());

class Services {
    List<ProductSearch>? data;

    Services({
        this.data,
    });

    factory Services.fromJson(Map<String, dynamic> json) => Services(
        data: json["data"] == null ? [] : List<ProductSearch>.from(json["data"]!.map((x) => ProductSearch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ProductSearch {
    int? idNum;
    String? productName;
    String? thumbnail;

    ProductSearch({
        this.idNum,
        this.productName,
        this.thumbnail,
    });

    factory ProductSearch.fromJson(Map<String, dynamic> json) => ProductSearch(
        idNum: json["id_num"],
        productName: json["product_name"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id_num": idNum,
        "product_name": productName,
        "thumbnail": thumbnail,
    };
}
