import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_hex/provider/Text_color.dart';
import 'package:firebase_hex/widgets/bottom_sheet.dart';
import 'package:firebase_hex/widgets/carousal_slider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/provider/hover_image_provider.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../model.dart';
import '../../provider/thumbnail.dart';
import 'package:http/http.dart' as http;

class CrimpingToolPage extends StatelessWidget {
  CrimpingToolPage({super.key});

  int selectedImageIndex = -1;
  // Initialize with an invalid index
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
        var screenSize = MediaQuery.of(context).size;
 double thumbnailSize = screenSize.width * 0.11; 
    final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);
         final selectedPriceNotifieru =
        Provider.of<SelectedPriceNotifier>(context, listen: false);
    final ImageHoverProvider = Provider.of<ImageHoveroProvider>(context);

    return Consumer(builder: (context, provider, child) {
      return FutureBuilder<ProduceNewModal>(
        future: context.read<DataProvider>().newcrimpingtool,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: lottieSuccess()
 
            // SpinKitCubeGrid(size: 140, 
            // color: Color.fromRGBO(249, 156, 6, 1.0),)
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final products = snapshot.data!.data;
            final pro = snapshot.data!.data.length;
            final nonNullProducts =
                products.where((product) => product != null).toList();

            return ListView(
              children: [
                 SizedBox(
                  child:Image.network('https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/lugs+Canva.png') ,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 26),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "HOME>>",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Text(
                          "Crimping Tools",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: colorProductName
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width >= 600 ? 30 : 10,
                  ),
                  child: GridView.builder(
                    physics: const ScrollPhysics(),
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
                        onTap: () async {
                          selectedThumbnailProvider.setSelectedThumbnail(
                              productData.thumbnail ?? "",
                              index: index);
                                selectedPriceNotifieru.resetSelectedPrice();

                         navigateToProductDetailsOfTools(context, index,
                              productname: snapshot
                                  .data!.data[index].productName!
                                  .replaceAll(" ", "_"));
                        },
                        child: Container(
                          //  height: 200,
                          width: _width / 4,
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
                                  // MouseRegion(
                                  //   onEnter: (_) {
                                  //       ImageHoverProvider  .setSelectedImageIndex(index);
                                  //   },
                                  //   onExit: (_) {
                                  //      ImageHoverProvider   .setSelectedImageIndex(-1);
                                  //   },
                                  //   child: AnimatedContainer(
                                  //     duration: Duration(milliseconds: 200),
                                  //     height:ImageHoverProvider.selectedImageIndex == index? 210: 160,
                                  //     width:ImageHoverProvider.selectedImageIndex == index
                                  //         ? MediaQuery.of(context).size.width / 4
                                  //         : MediaQuery.of(context).size.width / 5,
                                  //     child: Image.network(
                                  //       productData.thumbnail ?? "",
                                  //       height: 150,
                                  //       width:MediaQuery.of(context).size.width /5,
                                  //     ),
                                  //   ),
                                  // ),
                                  Image.network(
                                    productData.thumbnail ?? "",
                                    width: thumbnailSize,
                                    height: thumbnailSize,
                                  ),

                                  Text(
                                    productData.productName ?? "",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              45,
                                    ),
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
                  // height: MediaQuery.of(context).size.width >= 700
                  //     ? MediaQuery.of(context).size.height / 1.5
                  //     : 950,
                  child: MediaQuery.of(context).size.width >= 700
                      ? deskBottomSheett()
                      : mobiledeskBottomSheett(),
                ),
              ],
            );
          }
        },
      );
    });
  }
}
