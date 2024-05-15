import 'package:firebase_hex/provider/Text_color.dart';
import 'package:firebase_hex/widgets/bottom_sheet.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/provider/hover_image_provider.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                              //ul listed product
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
