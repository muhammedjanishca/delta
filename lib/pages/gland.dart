import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_hex/pages/bottom_sheet.dart';
import 'package:firebase_hex/pages/carousal_slider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../model.dart';
import '../provider/thumbnail.dart';
import 'gridview.dart';

class GlandPage extends StatelessWidget {
  GlandPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final BottomSheet= BottomSheett();
    final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);

    return Consumer(builder: (context, provider, child) {
      return FutureBuilder<ProduceNewModal>(
        future: context.read<DataProvider>().newglands,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final products = snapshot.data!.data;
            final nonNullProducts =
                products.where((product) => product != null).toList();

            return ListView(
              children: [
                Container(
                    // Customize the properties of your Container as needed
                    // color: Colors.blue,
                    width: MediaQuery.of(context).size.width / 4,
                    // height: 600,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: custCarosal(context, sliderGlands, Index)),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 13,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "HOME>>",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 54, 98, 98),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300),
                              )),
                          Text(
                            "GLANDS",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 54, 98, 98)),
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width <= 800
                          ? 2
                          : MediaQuery.of(context).size.width <= 1200
                              ? 3
                              : 4, // Set the number of columns in the grid
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

                          navigateToProductDetailsOfGlands(context, index);
                        },
                        child: Container(
                          height: 100,
                          // height: MediaQuery.of(context).size.height/20,
                          width: MediaQuery.of(context).size.width / 4,
                          color: Colors.white,
                          padding:
                              EdgeInsets.all(5.0), // Add spacing on all sides
                          margin:
                              EdgeInsets.all(5.0), // Add margin on all sides
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                productData.thumbnail ?? "",
                                height: 160,
                                // height: MediaQuery.of(context).size.height/4, // Adjust the height as needed
                                width: MediaQuery.of(context).size.width /
                                    5, // Adjust the width as needed
                                // fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 8,
                                width: MediaQuery.of(context).size.width / 4,
                              ), // Add spacing between image and text
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
                        : mobiledeskBottomSheett())
              ],
            );
          }
        },
      );
    });
  }
}
