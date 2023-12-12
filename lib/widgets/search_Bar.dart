import 'package:firebase_hex/main.dart';
import 'package:firebase_hex/provider/thumbnail.dart';
import 'package:firebase_hex/search_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

Widget searchBox(BuildContext context) {
  final productProvider = Provider.of<ProductProvider>(context, listen: false);
  final selectedThumbnailProvider =
      Provider.of<SelectedThumbnailProvider>(context);

  return Container(
    height: MediaQuery.of(context).size.height / 18,
    // width: MediaQuery.of(context).size.width/2,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4), color: Colors.white),
    child: Row(
      children: [
        Expanded(
          child: TypeAheadFormField<Map<String, dynamic>>(
            textFieldConfiguration: TextFieldConfiguration(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                suffixIcon: Icon(Icons.search,
                    color: Color.fromARGB(255, 155, 154, 154)),
              ),
            ),
            suggestionsCallback: (query) async {
              // Only call the fetchData() method if the search query is not empty.
              if (query.isNotEmpty) {
                return await productProvider.fetchData(query);
              } else {
                return [];
              }
            },
            itemBuilder: (context, suggestion) {
              return SizedBox(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(suggestion['thumbnail']),
                  ),
                  title: Text(suggestion['product_name']),
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              final productName = suggestion['product_name'];
              final type = suggestion['type'];
              final productNameWithUnderscores =
                  productName.replaceAll(" ", "_");
              // final thumbnail = suggestion["thumbnail"];
               
              selectedThumbnailProvider.setSelectedThumbnail("", index: null);

              navigateToProductDetailsFromSearch(
                  context, productNameWithUnderscores, type);
            },
          ),
        ),
      ],
    ),
  );
}
