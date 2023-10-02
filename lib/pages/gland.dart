import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_hex/pages/bottom_sheet.dart';
import 'package:firebase_hex/pages/carousal_slider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import '../main.dart';
import '../model.dart';
import '../provider/thumbnail.dart';
import 'gridview.dart';
// ... (Your imports and other code)

class GlandPage extends StatefulWidget {
  GlandPage({super.key});

  @override
  State<GlandPage> createState() => _GlandPageState();
}

class _GlandPageState extends State<GlandPage> {
  int selectedImageIndex = -1;

  @override
  Widget build(BuildContext context) {
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
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: custCarosal(context, sliderGlands, Index),
                ),
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
                              color: const Color.fromARGB(255, 54, 98, 98),
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Text(
                          "GLANDS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: janishcolor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width <= 800
                          ? 2
                          : MediaQuery.of(context).size.width <= 1200
                              ? 3
                              : 4,
                    ),
                    itemCount: snapshot.data!.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var productData = snapshot.data!.data[index];

                      return GestureDetector(
                        onTap: () {
                          selectedThumbnailProvider.setSelectedThumbnail(
                            productData.thumbnail ?? "",
                          );

                          navigateToProductDetailsOfGlands(context, index);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          color: Colors.white,
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.all(5.0),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MouseRegion(
                                    onEnter: (_) {
                                      setState(() {
                                        selectedImageIndex = index;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        selectedImageIndex = -1;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      height: selectedImageIndex == index
                                          ? 210
                                          : 160,
                                      width: selectedImageIndex == index
                                          ? MediaQuery.of(context).size.width /
                                              4
                                          : MediaQuery.of(context).size.width /
                                              5,
                                      child: Image.network(
                                        productData.thumbnail ?? "",
                                        height: 160,
                                        width: MediaQuery.of(context).size.width / 5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                    width: MediaQuery.of(context).size.width / 4,
                                  ),
                                  Text(
                                    productData.productName ?? "",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              // Asset image as foreground decoration
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
                Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: MediaQuery.of(context).size.width >= 700
                      ? deskBottomSheett()
                      : mobiledeskBottomSheett(),
                )
              ],
            );
          }
        },
      );
    });
  }
}
