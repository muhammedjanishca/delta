import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/login_and_signing/loginpage.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:firebase_hex/model.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/provider/thumbnail.dart';
import 'package:firebase_hex/provider/user_input_provider.dart';
import 'package:firebase_hex/responsive/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'nonpdf_product.dart';

class ProductDetailsoflugs extends StatelessWidget {
  // ProductDetailsoflugs({selectedProductIndex)}
  //  final int selectedProductIndex ;
  final ValueNotifier<String> selectedPriceNotifier = ValueNotifier<String>('');

  ProductDetailsoflugs({super.key});
  // ProductDetails({required this.productData, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    // print("janishkuttan");
    // final userInputProvider = Provider.of<UserInputProvider>(context);
    // final cartProvider = Provider.of<CartProvider>(context, listen: false);
    TextEditingController quantityController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String selectedProductIndex =
        ModalRoute.of(context)!.settings.name as String;
    var setting_list = selectedProductIndex.split('/');
    String product_name = setting_list[2];
    print(product_name);
    print("hgfhf");

    final selectedCodeProvider = Provider.of<SelectedCodeProvider>(context);

    final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);
    return ResponsiveProductPage(
      //******************MOBILE VIEW****************************

      mobileProductPage: FutureBuilder(
        future: context.read<DataProvider>().newlugs,
        builder: (context, snapshot) {
          snapshot.data!.data.length;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // You can replace this with a loading indicator or any other widget while waiting for data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var textpass = snapshot.data!
                .data[selectedThumbnailProvider.selectedIndex!].productName;
            var thumbnail = snapshot
                .data!.data[selectedThumbnailProvider.selectedIndex!].thumbnail;
            var description = snapshot.data!
                .data[selectedThumbnailProvider.selectedIndex!].description;
            var price = snapshot.data!
                .data[selectedThumbnailProvider.selectedIndex!].codesAndPrice!;
            var image = snapshot
                .data!.data[selectedThumbnailProvider.selectedIndex!].images;
            var pdf = snapshot
                .data!.data[selectedThumbnailProvider.selectedIndex!].pdf;

            //  String selectedPrice = '';

            return pdf != null
                ? DefaultTabController(
                    length: 2,
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: SingleChildScrollView(
                                child: Container(
                                  // height: do
                                  // height: MediaQuery.of(context).size.height /0.1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, top: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Image.network(
                                              // thumbnail!,)
                                              selectedThumbnailProvider
                                                      .selectedThumbnail ??
                                                  ''),
                                        ), // Display the selected thumbnail here
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: image!.map((imageUrl) {
                                              return GestureDetector(
                                                onTap: () {
                                                  // When an image is clicked, set it as the selected thumbnail.
                                                  selectedThumbnailProvider
                                                      .setSelectedThumbnail(
                                                          imageUrl ??
                                                              "data:image/jpeg;base64,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");
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: imageUrl ==
                                                                selectedThumbnailProvider
                                                                    .selectedThumbnail
                                                            ? Colors
                                                                .blue // Highlight the selected image
                                                            : Colors
                                                                .black, // Border color for non-selected images
                                                        width:
                                                            1.0, // Border width
                                                      ),
                                                    ),
                                                    child: Image.network(
                                                      imageUrl ??
                                                          "data:image/jpeg;base64,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",
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width /
                                                          10, // Set the desired width for each image
                                                      height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height /
                                                          12, // Set the desired height for each image
                                                      fit: BoxFit
                                                          .cover, // You can adjust the fit as needed
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        //--------Product Price-----------

                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                            Flexible(
                                              child: Container(
                                                // color: Colors.amber,

                                                child: Text(
                                                  'selected Product code&Price:',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: 'Roboto',
                                                    color: Color(0xFF212121),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ValueListenableBuilder<String>(
                                              valueListenable:
                                                  selectedPriceNotifier,
                                              builder: (context, selectedPrice,
                                                  child) {
                                                return Container(
                                                  width: 110,
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: selectedPrice != null
                                                      ? Text(selectedPrice)
                                                      : Text('NO Price'),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                            ),

                                            // Text(
                                            //   'Codes and Prices:',
                                            //   style: TextStyle(
                                            //     fontWeight: FontWeight.bold,
                                            //     fontSize: 18,
                                            //   ),
                                            // ),
                                            Wrap(
                                              spacing:
                                                  8.0, // Adjust the spacing between buttons as needed
                                              runSpacing:
                                                  8.0, // Adjust the spacing between rows as needed
                                              children: List<Widget>.generate(
                                                  price.length, (index) {
                                                final codeAndPrice =
                                                    price[index];
                                                return InkWell(
                                                  onTap: () {
                                                    String noprice = '0';
                                                    codeAndPrice.price != null
                                                        ? codeAndPrice.price
                                                        : noprice;
                                                    // When a container is tapped, update the selectedPrice using ValueNotifier.
                                                    selectedPriceNotifier
                                                            .value =
                                                        '${codeAndPrice.productCode}: ${codeAndPrice.price}';
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    padding: EdgeInsets.all(
                                                        8.0), // Adjust the padding as needed
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: codeAndPrice
                                                                    .productCode ==
                                                                selectedCodeProvider
                                                                    .selectedProductCode
                                                            // codeAndPrice.productCode
                                                            ? Colors
                                                                .blue // Set border color to blue for selected container
                                                            : Colors
                                                                .black, // Set border color to black for non-selected containers
                                                        width:
                                                            1.0, // Set your desired border width
                                                      ),
                                                    ),
                                                    child: Text(
                                                      '${codeAndPrice.productCode}',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .black, // Set your desired text color
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  TabBar(
                                    unselectedLabelColor:
                                        Color.fromARGB(255, 5, 5, 5),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicator: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color.fromARGB(255, 0, 0, 0),
                                          Color.fromARGB(255, 0, 0, 0)
                                        ]),
                                        borderRadius: BorderRadius.circular(0),
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)),
                                    tabs: [
                                      Tab(
                                        text: 'Description',
                                      ),
                                      Tab(
                                        text: 'Technical Details',
                                      ),
                                    ],
                                    labelColor: Colors.white,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TabBarView(
                                      children: [
                                        // Tab 1 content goes here
                                        SingleChildScrollView(
                                          child: Container(
                                            // height: 1000,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 16.0),
                                                Text(
                                                  textpass ?? "",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                                SizedBox(height: 8.0),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: description!
                                                      .toUpperCase()
                                                      .split('\n')
                                                      .map((line) {
                                                    return Row(
                                                      children: [
                                                        Icon(Icons.star,
                                                            size:
                                                                10, // Adjust the size as needed
                                                            color: Colors
                                                                .black // Adjust the color as needed
                                                            ),
                                                        SizedBox(
                                                          width:
                                                              8, // Add some space between the circle icon and text
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            line,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                            overflow: TextOverflow
                                                                .visible, // Handle text overflow
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }).toList(),
                                                ),

                                                // SizedBox(height: 8.0),
                                                SizedBox(height: 20.0),
                                                Container(
                                                  height: 40,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors
                                                          .black, // Set the border color
                                                      width:
                                                          1.0, // Set the border width
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            4.0)), // Add border radius
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        quantityController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Enter quantity',
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 8.0,
                                                      ),
                                                      isDense: true,
                                                      border: InputBorder
                                                          .none, // Remove the default input border
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (FirebaseAuth
                                                                .instance
                                                                .currentUser !=
                                                            null) {
                                                          // signed in

                                                          final selectedPrice =
                                                              selectedPriceNotifier
                                                                          .value !=
                                                                      null
                                                                  ? selectedPriceNotifier
                                                                      .value
                                                                  : 'No Price';
                                                          final productCode =
                                                              selectedPrice
                                                                  .split(
                                                                      ': ')[0];
                                                          final price = double
                                                              .parse(selectedPrice
                                                                  .split(
                                                                      ': ')[1]);

                                                          final quantity =
                                                              int.tryParse(
                                                                      quantityController
                                                                          .text) ??
                                                                  0;
                                                          final imageUrl =
                                                              // selectedThumbnailProvider
                                                              //         .selectedThumbnail ??
                                                              thumbnail;
                                                          final productName =
                                                              textpass;
                                                          final cartProvider =
                                                              Provider.of<
                                                                      CartProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);

                                                          cartProvider
                                                              .addToCart(
                                                                  productCode,
                                                                  price,
                                                                  quantity,
                                                                  imageUrl ??
                                                                      "",
                                                                  productName ??
                                                                      "");

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Added to cart")));
                                                        } else {
                                                          // signed out
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return LoginPage(); // Your custom dialog widget
                                                            },
                                                          );
                                                        }
                                                      },
                                                      child: const Text(
                                                          'ADD TO CART'),
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .black),
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size(
                                                                    150, 50)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context, '/cart');
                                                      },
                                                      child: const Text(
                                                        'GO TO CART',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .white),
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size(
                                                                    150, 50)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Tab 2 content goes here
                                        SingleChildScrollView(
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1,
                                              color: const Color.fromARGB(
                                                  255, 230, 233, 235),
                                              child: pdf != null
                                                  ? SfPdfViewer.network(pdf)
                                                  : Nopdf()
                                              // PDFView(
                                              //   filePath:
                                              //       pdf, // Replace 'pdf' with the actual PDF file path or URL
                                              //   // height: 300,   // Set the desired height for the PDF viewer
                                              //   // width: 300,    // Set the desired width for the PDF viewer
                                              // ),

                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Nopdf(
                    typeOfProduct: 'lugs',
                  );
          }
        },
      ),

//-----------desktop--------------------------------------------------------

      desktopProductPage: FutureBuilder(
        future: context.read<DataProvider>().fetchLugsData(),
        builder: (context, snapshot) {
          snapshot.data!.data.length;
          print("jhjhh");
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("hgfghfhfgu");
            return const CircularProgressIndicator(); // You can replace this with a loading indicator or any other widget while waiting for data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String? textpass;
            String? thumbnail;
            String? description;
            List<CodesAndPrice>? price = [];
            List<String>? image = [];
            String? pdf;
            
            //  selectedThumbnailProvider.setSelectedThumbnail(snapshot.data!.data.map((e) {
            //       // print(e.productName);
            //       if (e.productName == product_name) {
            //         return e.thumbnail;
            //       }
            //     }).first!,
            //     index: snapshot.data!.data.indexWhere((element) => element.productName==product_name)
            //     );
            if (selectedThumbnailProvider.selectedIndex != null) {
              textpass = snapshot.data!
                  .data[selectedThumbnailProvider.selectedIndex!].productName;
              thumbnail = snapshot.data!
                  .data[selectedThumbnailProvider.selectedIndex!].thumbnail;
              description = snapshot.data!
                  .data[selectedThumbnailProvider.selectedIndex!].description;
              price = snapshot
                  .data!
                  .data[selectedThumbnailProvider.selectedIndex!]
                  .codesAndPrice!;
              image = snapshot
                  .data!.data[selectedThumbnailProvider.selectedIndex!].images;
              pdf = snapshot
                  .data!.data[selectedThumbnailProvider.selectedIndex!].pdf;
            } else {
              // print(snapshot.data!.data[0].description);
              // selectedThumbnailProvider.setSelectedThumbnail(snapshot.data!.data.map((e) {
              //     // print(e.productName);
              //     if (e.productName == product_name) {
              //       return e.thumbnail;
              //     }
              //   }).first!,
              //   index: snapshot.data!.data.indexWhere((element) => element.productName==product_name)
              //   );

              print(snapshot.data!.data.map((e) {
                // print(e.productName);
                if (e.productName == product_name) {
                  return e.productName;
                }
              }));
              try {
                // print(object)
                textpass = snapshot.data!.data.map((e) {
                  // print(e.productName);
                  if (e.productName == product_name) {
                    return e.productName;
                  }
                }).first;
                // print(textpass);
                thumbnail = snapshot.data!.data.map((e) {
                  // print(e.productName);
                  if (e.productName == product_name) {
                    return e.thumbnail;
                  }
                }).first;
                description = snapshot.data!.data.map((e) {
                  // print(e.productName);
                  if (e.productName == product_name) {
                    return e.description;
                  }
                }).first;
                price = snapshot.data!.data.map((e) {
                  // print(e.productName);
                  if (e.productName == product_name) {
                    e.codesAndPrice!.map((e) => e);
                  }
                }).first;
                image = snapshot.data!.data.map((e) {
                  // print(e.productName);
                  if (e.productName == product_name) {
                    e.images!.map((e) => e);
                  }
                }).first;
                pdf = snapshot.data!.data.map((e) {
                  // print(e.productName);
                  if (e.productName == product_name) {
                    return e.pdf;
                  }
                }).first;
              } catch (e) {
                // print(e);
                print("kjhjh");
              }
            }
            //  String selectedPrice = '';

            return pdf != null
                ? DefaultTabController(
                    length: 2,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 1.3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                // height: do
                                width: MediaQuery.of(context).size.width / 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, top: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        child: Image.network(
                                            //  thumbnail!,
                                            selectedThumbnailProvider
                                                    .selectedThumbnail ??
                                                ''),
                                      ), // Display the selected thumbnail here
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: image!.map((imageUrl) {
                                            return GestureDetector(
                                              onTap: () {
                                                // When an image is clicked, set it as the selected thumbnail.
                                                selectedThumbnailProvider
                                                    .setSelectedThumbnail(
                                                        imageUrl ??
                                                            "data:image/jpeg;base64,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");
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: imageUrl ==
                                                              selectedThumbnailProvider
                                                                  .selectedThumbnail
                                                          ? Colors
                                                              .blue // Highlight the selected image
                                                          : Colors
                                                              .black, // Border color for non-selected images
                                                      width:
                                                          1.0, // Border width
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    imageUrl ??
                                                        "data:image/jpeg;base64,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",
                                                    width:
                                                        100, // Set the desired width for each image
                                                    height:
                                                        100, // Set the desired height for each image
                                                    fit: BoxFit
                                                        .cover, // You can adjust the fit as needed
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //--------Product Price-----------

                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                          ),
                                          Flexible(
                                            child: Container(
                                              // color: Colors.amber,

                                              child: Text(
                                                'selected Product code&Price:',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF212121),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ValueListenableBuilder<String>(
                                            valueListenable:
                                                selectedPriceNotifier,
                                            builder: (context, selectedPrice,
                                                child) {
                                              return Container(
                                                width: 110,
                                                padding: EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                // child: selectedPrice != null
                                                //     ? Text(selectedPrice)
                                                //     : Text('NO Price'),
                                                child: Text(selectedPrice),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),

                                          // Text(
                                          //   'Codes and Prices:',
                                          //   style: TextStyle(
                                          //     fontWeight: FontWeight.bold,
                                          //     fontSize: 18,
                                          //   ),
                                          // ),
                                          Wrap(
                                            spacing:
                                                8.0, // Adjust the spacing between buttons as needed
                                            runSpacing:
                                                8.0, // Adjust the spacing between rows as needed
                                            children: List<Widget>.generate(
                                                price!.length, (index) {
                                              final codeAndPrice =
                                                  price![index];
                                              return InkWell(
                                                onTap: () {
                                                  // String noprice = '0';
                                                  // codeAndPrice.price != null
                                                  //     ? codeAndPrice.price
                                                  //     : noprice;
                                                  // When a container is tapped, update the selectedPrice using ValueNotifier.
                                                  selectedPriceNotifier.value =
                                                      '${codeAndPrice.productCode}: ${codeAndPrice.price}';
                                                },
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.all(
                                                      8.0), // Adjust the padding as needed
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: codeAndPrice
                                                                  .productCode ==
                                                              selectedCodeProvider
                                                                  .selectedProductCode
                                                          // codeAndPrice.productCode
                                                          ? Colors
                                                              .blue // Set border color to blue for selected container
                                                          : Colors
                                                              .black, // Set border color to black for non-selected containers
                                                      width:
                                                          1.0, // Set your desired border width
                                                    ),
                                                  ),
                                                  child: Text(
                                                    '${codeAndPrice.productCode}',
                                                    style: TextStyle(
                                                      color: Colors
                                                          .black, // Set your desired text color
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                TabBar(
                                  unselectedLabelColor:
                                      Color.fromARGB(255, 5, 5, 5),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color.fromARGB(255, 0, 0, 0),
                                        Color.fromARGB(255, 0, 0, 0)
                                      ]),
                                      borderRadius: BorderRadius.circular(0),
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
                                  tabs: [
                                    Tab(
                                      text: 'Description',
                                    ),
                                    Tab(
                                      text: 'Technical Details',
                                    ),
                                  ],
                                  labelColor: Colors.white,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TabBarView(
                                    children: [
                                      // Tab 1 content goes here
                                      Container(
                                        // height: 1000,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 16.0),
                                            Text(
                                              textpass ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30),
                                            ),
                                            SizedBox(height: 8.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: description!
                                                  .toUpperCase()
                                                  .split('\n')
                                                  .map((line) {
                                                return Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        size:
                                                            10, // Adjust the size as needed
                                                        color: Colors
                                                            .black // Adjust the color as needed
                                                        ),
                                                    SizedBox(
                                                      width:
                                                          8, // Add some space between the circle icon and text
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        line,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                        overflow: TextOverflow
                                                            .visible, // Handle text overflow
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            ),

                                            // SizedBox(height: 8.0),
                                            SizedBox(height: 20.0),
                                             Form(
                                                key: _formKey,
                                                child: Container(
                                                  // height:
                                                  // MediaQuery.of(context).size.height/18,
                                                  width:200,
                                                  //  MediaQuery.of(context).size.width/10,
                                                  child: TextFormField(
                                                    controller: quantityController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(),
                                                      hintText:
                                                          'Enter the quantity',
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please enter a quantity';
                                                      }
                                                      int? quantity =
                                                          int.tryParse(value);
                                                      if (quantity == null ||
                                                          quantity <= 0) {
                                                        return 'Quantity must be a positive number';
                                                      }
                                                      return null; // Return null if the input is valid
                                                    },
                                                  ),
                                                ),
                                              ),
                                      

                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                ElevatedButton(
                                                 onPressed: () {
                                                        if (_formKey.currentState!
                                                            .validate()) {
                                                          if (FirebaseAuth.instance
                                                                  .currentUser !=
                                                              null) {
                                                            // signed in
                                                            final selectedPrice =
                                                                selectedPriceNotifier
                                                                    .value;
                                                            final productCode =
                                                                selectedPrice
                                                                    .split(': ')[0];
                                                            final price = double
                                                                .parse(selectedPrice
                                                                    .split(
                                                                        ': ')[1]);
                                                                                        
                                                            final quantity =
                                                                int.tryParse(
                                                                        quantityController
                                                                            .text) ??
                                                                    0;
                                                            final imageUrl =
                                                                // selectedThumbnailProvider
                                                                //         .selectedThumbnail ??
                                                                thumbnail;
                                                            final productName =
                                                                textpass;
                                                            final cartProvider =
                                                                Provider.of<
                                                                        CartProvider>(
                                                                    context,
                                                                    listen: false);
                                                            cartProvider.addToCart(
                                                                productCode,
                                                                price,
                                                                quantity,
                                                                imageUrl ?? "",
                                                                productName ?? "");
                                                                                        
                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar(SnackBar(
                                                                    content: Text(
                                                                        "Added to cart")));
                                                          } else {
                                                            // signed out
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                  context) {
                                                                return LoginPage(); // Your custom dialog widget
                                                              },
                                                            );
                                                          }
                                                        }
                                                      },
                                                  child:
                                                      const Text('ADD TO CART'),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.black),
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size(150, 50)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/cart');
                                                  },
                                                  child: const Text(
                                                    'GO TO CART',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white),
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size(150, 50)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: ListView.builder(
                                            itemBuilder: (context, index) {
                                          return Container(
                                            child: pdf != null
                                                ? SfPdfViewer.network(pdf)
                                                : Nopdf(),
                                          );
                                        }),
                                      )
                                      // Tab 2 content goes here
                                      // SingleChildScrollView(
                                      //   child: Container(
                                      //       height: 1500,
                                      //       color: const Color.fromARGB(
                                      //           255, 230, 233, 235),
                                      //       child: pdf != null
                                      //           ? SfPdfViewer.network(pdf)
                                      //           : Nopdf()
                                      //       PDFView(
                                      //         filePath:
                                      //             pdf, // Replace 'pdf' with the actual PDF file path or URL
                                      //         // height: 300,   // Set the desired height for the PDF viewer
                                      //         // width: 300,    // Set the desired width for the PDF viewer
                                      //       ),

                                      //       ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Nopdf(
                    typeOfProduct: 'lugs',
                  );
          }
        },
      ),
    );
  }
}
