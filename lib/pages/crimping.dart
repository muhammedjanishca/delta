import 'package:firebase_hex/main.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/provider/thumbnail.dart';
import 'package:firebase_hex/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model.dart';
import 'gridview.dart';

class CrimpingToolPage extends StatefulWidget {
  CrimpingToolPage({super.key});

  @override
  
  State<CrimpingToolPage> createState() => _CrimpingToolPageState();
}

class _CrimpingToolPageState extends State<CrimpingToolPage> {
  int selectedImageIndex = -1; // Initialize with an invalid index

  @override
  Widget build(BuildContext context) {
    final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);

    return Consumer(builder: (context, provider, child) {
      return FutureBuilder<ProduceNewModal>(
        future: context.read<DataProvider>().newcrimpingtool,
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final products = snapshot.data!.data;
            final nonNullProducts =
                products.where((product) => product != null).toList();

            return Padding(
  padding: EdgeInsets.symmetric(
    horizontal: MediaQuery.of(context).size.width >= 600 ? 0 : 0,
  ),
  child: Column(
    children: [
      // Add your container here
      Container(
        height: 20,
        color: janishcolor,
        // Container properties here
      ),
      Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width <= 700
                ? 2
                : MediaQuery.of(context).size.width <= 1200
                    ? 3
                    : 4,
          ),
          itemCount: snapshot.data!.data.length,
          itemBuilder: (context, index) {
            var productData = snapshot.data!.data[index];

            return GestureDetector(
              onTap: () {
                // Set the selected thumbnail for this product
                selectedThumbnailProvider.setSelectedThumbnail(
                  productData.thumbnail ?? "",
                );

                navigateToProductDetailsOfCrimpinTools(context, index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 229, 229, 229)
                          .withOpacity(
                              0.5), // Set the shadow color here
                      spreadRadius:
                          5, // Set the spread radius of the shadow
                      blurRadius:
                          7, // Set the blur radius of the shadow
                      offset: Offset(
                          0, 3), // Set the offset of the shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width >= 700
                      ? 15.0
                      : 5.0,
                ),
                margin: EdgeInsets.all(
                  MediaQuery.of(context).size.width >= 700
                      ? 15.0
                      : 5.0,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          productData.thumbnail ?? "",
                          // height: 150,
                          width: MediaQuery.of(context).size.width / 5,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        Text(
                          productData.productName ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/image/images.png',
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  ),
);

          }
        },
      );
    });
  }
}
