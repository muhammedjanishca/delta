import 'package:firebase_hex/main.dart';
import 'package:firebase_hex/provider/thumbnail.dart';
import 'package:firebase_hex/search_api.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Widget searchBox(BuildContext context) {
  final productProvider = Provider.of<ProductProvider>(context, listen: false);
  final selectedThumbnailProvider = Provider.of<SelectedThumbnailProvider>(context);

  return Container(
    height: MediaQuery.of(context).size.height / 18,
    decoration: BoxDecoration(
      
        borderRadius: BorderRadius.circular(4), color: colorOne,),
    child: Row(
      children: [
        Expanded(
          child: TypeAheadFormField<Map<String, dynamic>>(
            textFieldConfiguration: TextFieldConfiguration(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "I'm searching for...",
                hintStyle: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 136, 136, 136),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                suffixIcon: const Icon(Icons.search,
                    color: Color.fromARGB(255, 170, 169, 169)),
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
              final thumbnail = suggestion["thumbnail"];
               
              selectedThumbnailProvider.setSelectedThumbnail("", index: null);
        
              navigateToProductDetailsFromSearch(
                  context, productNameWithUnderscores, type,thumbnail);
            },
          ),
        ),
      ],
    ),
  );
}
