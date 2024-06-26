import 'package:firebase_hex/provider/Text_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../model.dart';
import '../../provider/data_provider.dart';
import '../../provider/hover_image_provider.dart';
import '../../provider/thumbnail.dart';
import '../../widgets/style.dart';
import '../../widgets/bottom_sheet.dart';

class LugsPage extends StatelessWidget {
  LugsPage({super.key});

  // int selectedImageIndex = -1;
  // Initialize with an invalid index
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double thumbnailSize = screenSize.width * 0.11; // Adjust the factor as needed
    // double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);
    // final ImageHoverProvider = Provider.of<ImageHoveroProvider>(context);
    final selectedPriceNotifieru =
        Provider.of<SelectedPriceNotifier>(context, listen: false);

    return SizedBox(
      child: Consumer(builder: (context, provider, child) {
        return FutureBuilder<ProduceNewModal>(
          future: context.read<DataProvider>().newlugs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: lottieSuccess()
              //      SpinKitCubeGrid(
              //   size: 140,
              //   color: Color.fromRGBO(249, 156, 6, 1.0),
              // )
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final products = snapshot.data!.data;
              final nonNullProducts =
                  products.where((product) => product != null).toList();
    
              return ListView(
              children: [
                // Container(
                //   width: MediaQuery.of(context).size.width / 4,
                //   height: MediaQuery.of(context).size.height / 2.5,
                //   child:Image.asset('https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/lugs+Canva.png')
                //   //  custCarosal(context, sliderLugs, Index),
                // ),
                SizedBox(
                  child:Image.network('https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/lugs+Canva.png') ,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  // height: MediaQuery.of(context).size.height / 13,
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
                          "Lugs",
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: colorProductName),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width >= 600 ? 30 : 10,
                  ),
                  child: GridView.builder(
                    physics: ScrollPhysics(),
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
                                index: index);
                            selectedPriceNotifieru.resetSelectedPrice();
    
                            navigateToProductDetailsofLugs(context, index,
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
                               if (productData.ultype !=null)
                              Positioned(
                                top: 0,
                                left: 0,
                               
                                  // color: colorOne,
                                  child: Image.network(
                                    'https://deltabuckets.s3.ap-south-1.amazonaws.com/images/ul+list+logo+from+hex+site.png',
                                    // 'https://deltabuckets.s3.ap-south-1.amazonaws.com/Light+Brown+Taupe+Beige+Modern+Elegance+Recruitment+LinkedIn+Profile+Picture+(100+x+100+px)+(100+x+70+px).png',
                                    width: 100,
                                    height: 45,
                                    fit: BoxFit.fill,
                                  ),
                                
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
                  // width: double.infinity,
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
      }),
    );
  }
}

// import 'package:firebase_hex/main.dart';
// import 'package:firebase_hex/provider/data_provider.dart';
// import 'package:firebase_hex/provider/thumbnail.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../model.dart';
// import 'gridview.dart';

// class CrimpingToolPage extends StatefulWidget {
//   CrimpingToolPage({super.key});

//   @override
//   State<CrimpingToolPage> createState() => _CrimpingToolPageState();
// }

// class _CrimpingToolPageState extends State<CrimpingToolPage> {
//   int selectedImageIndex = -1; // Initialize with an invalid index

//   @override
//   Widget build(BuildContext context) {
//     final selectedThumbnailProvider =
//         Provider.of<SelectedThumbnailProvider>(context);

//     return Consumer(builder: (context, provider, child) {
//       return FutureBuilder<ProduceNewModal>(
//         future: context.read<DataProvider>().newcrimpingtool,
//         builder: (context, snapshot) {
//           // snapshot.data);
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             final products = snapshot.data!.data;
//             final nonNullProducts =
//                 products.where((product) => product != null).toList();

//             return Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width >= 600 ? 30 : 10,
//               ),
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: MediaQuery.of(context).size.width <= 700
//                       ? 2
//                       : MediaQuery.of(context).size.width <= 1200
//                           ? 3
//                           : 4,
//                 ),
//                 itemCount: snapshot.data!.data.length,
//                 itemBuilder: (context, index) {
//                   var productData = snapshot.data!.data[index];

//                   return GestureDetector(
//                     onTap: () {
//                       // Set the selected thumbnail for this product
//                       selectedThumbnailProvider.setSelectedThumbnail(
//                         productData.thumbnail ?? "",
//                       );

//                       navigateToProductDetailsOfCrimpinTools(context, index);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromARGB(255, 229, 229, 229)
//                                 .withOpacity(
//                                     0.5), // Set the shadow color here
//                             spreadRadius:
//                                 5, // Set the spread radius of the shadow
//                             blurRadius:
//                                 7, // Set the blur radius of the shadow
//                             offset: Offset(
//                                 0, 3), // Set the offset of the shadow
//                           ),
//                         ],
//                       ),
//                       padding: EdgeInsets.all(
//                         MediaQuery.of(context).size.width >= 700
//                             ? 15.0
//                             : 5.0,
//                       ),
//                       margin: EdgeInsets.all(
//                         MediaQuery.of(context).size.width >= 700
//                             ? 15.0
//                             : 5.0,
//                       ),
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.network(
//                                 productData.thumbnail ?? "",
//                                 // height: 150,
//                                 width:
//                                     MediaQuery.of(context).size.width / 5,
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height / 25,
//                               ),
//                               Text(
//                                 productData.productName ?? "",
//                                 style:
//                                     TextStyle(fontWeight: FontWeight.bold),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                           Positioned(
//                             top: 0,
//                             right: 0,
//                             child: Image.asset(
//                               'assets/image/images.png',
//                               width: 25,
//                               height: 25,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       );
//     });
//   }
// }
