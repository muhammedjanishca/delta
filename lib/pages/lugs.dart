import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../model.dart';
import '../provider/data_provider.dart';
import '../provider/thumbnail.dart';
import 'bottom_sheet.dart';
import 'carousal_slider.dart';


class LugsPage extends StatelessWidget {
  LugsPage({super.key});

  @override
  Widget build(BuildContext context) {
     final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);

    return Consumer(builder: (context, provider, child) {
      return FutureBuilder<ProduceNewModal>(
        future: context.read<DataProvider>().newlugs,
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
              final products = snapshot.data!.data;
            final nonNullProducts = products.where((product) => product != null).toList();

            return ListView(
              children: [
                Container(
                  // Customize the properties of your Container as needed
                  // color: Colors.blue,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: custCarosal(context, sliderlugs, Index)
                  // child: Image.network(
                  //   'https://thumbs.dreamstime.com/b/electrical-tools-components-website-banner-format-shot-assortment-electrical-contractors-tools-house-plans-85133897.jpg',
                  //   width: 200,
                  //   height: 200,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          4, // Set the number of columns in the grid
                    ),
                    itemCount: snapshot.data!.data.length,
                    shrinkWrap:
                        true, // Allow the GridView to be scrollable within the ListView
                    itemBuilder: (context, index) {
                      var productData = snapshot.data!.data[index];

                      return GestureDetector(
                        onTap: () {
                          // Set the selected thumbnail for this product
                          selectedThumbnailProvider.setSelectedThumbnail(
                            productData.thumbnail ?? "",
                          );

                          navigateToProductDetailsofLugs(context, index);
                        },
                        child: Container(
                          color: Colors.white,
                          padding:
                              EdgeInsets.all(8.0), // Add spacing on all sides
                          margin:
                              EdgeInsets.all(8.0), // Add margin on all sides
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                productData.thumbnail ?? "",
                                height: 200, // Adjust the height as needed
                                width: 200, // Adjust the width as needed
                                // fit: BoxFit.cover,
                              ),
                              SizedBox(
                                  height:
                                      8.0), // Add spacing between image and text
                              Text(
                                productData.productName ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
  color: const Color.fromARGB(255, 255, 255, 255),
  height: MediaQuery.of(context).size.height / 1.5,
  child: MediaQuery.of(context).size.width >= 700
      ? deskBottomSheett()
      : mobiledeskBottomSheett()
)
              ],
            );          }
        },
      );
    });
  }
}