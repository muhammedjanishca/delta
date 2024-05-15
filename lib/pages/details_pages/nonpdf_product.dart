import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/loginpage.dart';
import 'package:firebase_hex/provider/Refresh.dart';
import 'package:firebase_hex/provider/Text_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../model.dart';
import '../../provider/cart_provider.dart';
import '../../provider/data_provider.dart';
import '../../provider/thumbnail.dart';
import '../../responsive/product_page.dart';
import '../../widgets/style.dart';

class Nopdf extends StatelessWidget {
  final ValueNotifier<String> selectedPriceNotifier = ValueNotifier<String>('');
  String? typeOfProduct;
  Nopdf({this.typeOfProduct});

  String? textpass;
  String? thumbnail;
  String? description;
  String? priceofproduct = "";
  // List<String>? image = [];
 int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController = TextEditingController(text: '1'); // start with initial value as 1
    var user = Provider.of<AuthenticationHelper>(context).user;

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String selectedProductIndex =
        ModalRoute.of(context)!.settings.name as String;
    var setting_list = selectedProductIndex.split('/');
    typeOfProduct = setting_list[1].substring(14).toString();
    String product_name = setting_list[2].replaceAll('_', " ");
    final selectedPriceNotifieru =
        Provider.of<SelectedPriceNotifier>(context, listen: false);
    final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);
    return ResponsiveProductPage(
      mobileProductPage: Scaffold(
        body: FutureBuilder(
          future: context.read<DataProvider>().setTypeOfProducts(typeOfProduct),
          builder: (context, snapshot) {
            snapshot.data!.data.length;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: lottieSuccess()); // You can replace this with a loading indicator or any other widget while waiting for data.
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String? description = "";
              String? Ultype;
              List<String>? image = [];

              if (selectedThumbnailProvider.selectedIndex != null) {
                textpass = snapshot.data!
                    .data[selectedThumbnailProvider.selectedIndex!].productName;
                thumbnail = snapshot.data!
                    .data[selectedThumbnailProvider.selectedIndex!].thumbnail;
                description = snapshot.data!
                    .data[selectedThumbnailProvider.selectedIndex!].description;
                // price = snapshot
                //     .data!
                //     .data[selectedThumbnailProvider.selectedIndex!]
                //     .codesAndPrice!;
                 Ultype = snapshot
                      .data!
                      .data[selectedThumbnailProvider.selectedIndex!]
                      .ultype;
                priceofproduct = snapshot
                    .data!
                    .data[selectedThumbnailProvider.selectedIndex!]
                    .priceofproduct;
                image = snapshot.data!
                    .data[selectedThumbnailProvider.selectedIndex!].images;
                // pdf = snapshot
                //     .data!.data[selectedThumbnailProvider.selectedIndex!].pdf;
              } else {
                snapshot.data!.data.firstWhere((element) {
                  if (element.productName == product_name) {
                    Ultype  = element.ultype;
                    textpass = element.productName;
                    thumbnail = element.thumbnail;
                    description = element.description;
                    priceofproduct = element.priceofproduct;
                    // priceo?.addAll(element.codesAndPrice!.map((e) => e));
                    image?.addAll(element.images!.map((e) => e));
                    // pdf = element.pdf ?? "";
                    return true;
                  } else {
                    return false;
                  }
                });
              }

              return DefaultTabController(
                length: 2,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children:[ SizedBox(
                          child: Image.network(thumbnail!),
                        ),
                        if (Ultype!=null)
                              Positioned(
                                top: 0,
                                left: 0,
                                  child: Image.network(
                                    'https://deltabuckets.s3.ap-south-1.amazonaws.com/images/ul+list+logo+from+hex+site.png',
                                    // 'https://deltabuckets.s3.ap-south-1.amazonaws.com/Light+Brown+Taupe+Beige+Modern+Elegance+Recruitment+LinkedIn+Profile+Picture+(100+x+100+px)+(100+x+70+px).png',
                                    width: 100,
                                    height: 45,
                                    fit: BoxFit.fill,
                                  ),
                              ),
                        ]
                      ),
                      Stack(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              // height: double.infinity,
                              height: MediaQuery.of(context).size.height,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 245, 229, 166),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.0),
                                  topLeft: Radius.circular(30.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(20),
                                    Text(
                                      textpass ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Gap(15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: description!
                                          .toUpperCase()
                                          .split('\n')
                                          .map((line) {
                                        return Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 10,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                              child: Text(
                                                line,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(249, 156, 6,
                                      1.0), // Adjust the color as needed
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                  ),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (FirebaseAuth.instance.currentUser !=
                                            null) {
                                          final price =
                                              double.parse(priceofproduct!);

                                          final quantity = int.tryParse(
                                                  quantityController.text) ??
                                              0;

                                          final imageUrl =
                                              // selectedThumbnailProvider
                                              //         .selectedThumbnail ??
                                              thumbnail;
                                          final productName = textpass;

                                          final cartProvider =
                                              Provider.of<CartProvider>(context,
                                                  listen: false);
                                          cartProvider.addToCart(
                                              // productCode:productCode,
                                              price: price,
                                              quantity: quantity,
                                              imageUrl: imageUrl ?? '',
                                              productName: productName ?? '');

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Added to cart")));
                                        } else {
                                          // signed out
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return LoginPage(); // Your custom dialog widget
                                            },
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      "ADD TO CART",
                                      style: TextStyle(color: Colors.white),
                                    ))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // child: SingleChildScrollView(
                //   child: Container(
                //     // height: MediaQuery.of(context).size.height * 1.3,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           child: Padding(
                //             padding: const EdgeInsets.only(
                //                 left: 0, right: 0, top: 25),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 Container(
                //                   color: Colors.white,
                //                   height:
                //                       MediaQuery.of(context).size.height / 5,
                //                   width:
                //                       MediaQuery.of(context).size.width / 2,
                //                   child: Image.network(
                //                     thumbnail!,
                //                     // selectedThumbnailProvider
                //                     //       .selectedThumbnail ??
                //                     //   ''
                //                   ),
                //                 ), // Display the selected thumbnail here
                //                 SingleChildScrollView(
                //                             scrollDirection: Axis.horizontal,
                //                             child: Row(
                //                               children: image!.map((imageUrl) {
                //                                 return GestureDetector(
                //                                   onTap: () {
                //                                     // When an image is clicked, set it as the selected thumbnail.
                //                                     selectedThumbnailProvider
                //                                         .setSelectedThumbnail(
                //                                             imageUrl ??
                //                                                 "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ8NDQ0NFREWFhURFRUYHSggGBstIBUVIjEhMTUtLi8wFyszOD8tNzQtOC0BCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIAKoBKAMBIgACEQEDEQH/xAAbAAEBAQEAAwEAAAAAAAAAAAAAAQQFAgMGB//EADEQAQACAQIEBAQGAQUAAAAAAAABAhEDIQQSQWEiMVGREzJxgQUGUqHR8BQjcpKx4f/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwD9U4jjeK59asU1aRSmpOhjQtqRrXi2pGJtFcRERWkx5Z5vOSv43xGIzwOtmZxERXU886WazM0xExGpff5Z+HOJ9O3v2N+wOXwHE8TrU5rVmlptq8sTS9IiscvLnnrFsbz0iWmOJ1MViaeKYrPlbeZxt5ee8z9vbXv2N+wMf+XfETyZnriLbft16fz564mczHLiI8rZjf7Lv2N+wKJv2N+wKJv2XfsAJv2N+wKJv2XfsAJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2AUAAAAAAABUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUQAAAAAAAAAAAAAAAVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABUAAAAAAAFQAAAAAAAABUAAVAVAAAAVAFQAFQAAAVAAAAAAAAAAAAAAAAAAAAAAAGfj+KjQ0ralukeGP1W6Q+Y4H8a1q60W1dS16WnF6z5RE9Yjph5/mTjviavwqz4NKZifSdTr7eXu8fxHg9GnCcNqUiYvqRXmnMzzZpmdvqD66JzGY3id4npI4v5Z47n050bT4tKPD30/8Azy9naAAAAAAAAAAAAAAABQQAAAAAAFBAAAAAAAAGH8Z434Gja0fPbw6f+6ev28258n+aNS88Ri2YpWkfD9Jz5z77fYHIbuM4iLcPwtImJmka3NGd48Xhz9mDMesNGtxVLaelpxp0pbTzzakfNqfUE4LibaOpTUr51neP1V6w+60dWt61vWc1tEWie0vz7MesPqfyre86N4tnkrf/AE5nv5xH96g7YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA9PGWtGnM1znNMzWM2inNHNMd8ZYtXi/h5+FNr18UxN86lZmIrmtbTOZ859evpOA6Y59OI4iZpXwR8TlnPw74pE11JmJ8W/wAtff6PVPG61qRMctLTibU5LTbSr4Z5pnO8Tv79pB1cQYhk1OI5NXUiZz/pac6dc45782pmI7/L+zNq/iGpWJxy3xSbRaunaK2tFczp4m2c+87+W0g6mIGHh9e99WImYx8PVzWK2jktF6xEWnrOM/8Afkz24u/w9Dlt4uTSnVti1uWefTieaI7Tb2ny3B1hzY43V3meWK5isW5LYtm145t7RERisf8AL6ZaXG601raaVjn5KVryXia6ltOts2zPy5m0T9AdIAAAAAAAAAAAAAAAAAAAAAAAAAGSnF3xE205iJiJicxtmOvbun+fERMzS3TrGcT1/vrHq2KDLrcZFJmJpecYnONun8wf5teXm5bec1iNszOM4aQGO/HRForyWzm2d42xE+/TH1WvG5rzcltpiLR6bT/H7w2IDNbjIjGa2xMZzG/WY29fX6PGnGxOfDMRFb2tOf0zHl6xvPs2JMZ2nePSQZZ46N/BfPSNszOcY+vX6LqcXi01ikzyzi2JjaIpzZ/eI92pAZI47f5LYxWYnMb5mYx/e/oW4mszpzyTa1vk2jwzOYzn089+7WAzU4zOZ5LYjl9ObMzMYx9o93rj8Q3xyW+WJ6ee+Yn08s/RtUHo0OIi8zGJiYx543z1h7gABQQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH//Z");
                //                                   },
                //                                   child: Padding(
                //                                     padding:
                //                                         const EdgeInsets.all(
                //                                             8.0),
                //                                     child: Container(
                //                                       decoration: BoxDecoration(
                //                                         border: Border.all(
                //                                           color: imageUrl ==
                //                                                   // imageUrl
                //                                                   selectedThumbnailProvider
                //                                                       .selectedThumbnail
                //                                               ? Colors
                //                                                   .blue // Highlight the selected image
                //                                               : Colors
                //                                                   .black, // Border color for non-selected images
                //                                           width:
                //                                               1.0, // Border width
                //                                         ),
                //                                       ),
                //                                       child: Image.network(
                //                                         imageUrl ??
                //                                             "data:image/jpeg;base64,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",
                //                                         width: MediaQuery.of(
                //                                                     context)
                //                                                 .size
                //                                                 .width /
                //                                             10, // Set the desired width for each image
                //                                         height: MediaQuery.of(
                //                                                     context)
                //                                                 .size
                //                                                 .height /
                //                                             12, // Set the desired height for each image
                //                                         fit: BoxFit
                //                                             .cover, // You can adjust the fit as needed
                //                                       ),
                //                                     ),
                //                                   ),
                //                                 );
                //                               }).toList(),
                //                             ),
                //                           ),
                //                 //--------Product Price-----------
                //                   SizedBox(
                //                             height: 30,
                //                           ),
                //                           Padding(
                //                             padding: const EdgeInsets.only(
                //                                 bottom: 15, left: 15),
                //   child: Text(
                //     textpass ?? "",
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 22),
                //   ),
                // ),
                //                           Divider(),
                //                            SizedBox(
                //                             height: MediaQuery.of(context)
                //                                     .size
                //                                     .height /
                //                                 20,
                //                           ),
                //                           Row(
                //                             children: [
                //                               Gap(25),
                //                               Form(
                //                                 key: _formKey,
                //                                 child: Container(
                //                                   width: 140,
                //                                   // height: 43,
                //                                   child: TextFormField(
                //                                     controller:
                //                                         quantityController,
                //                                     keyboardType:
                //                                         TextInputType.number,
                //                                     decoration: InputDecoration(
                //                                         border:
                //                                             OutlineInputBorder(),
                //                                         hintText:
                //                                             'Enter the quantity',
                //                                         hintStyle: TextStyle(
                //                                             fontSize: 14)),
                //                                     validator: (value) {
                //                                       if (value!.isEmpty) {
                //                                         return 'Please enter a quantity';
                //                                       }
                //                                       int? quantity =
                //                                           int.tryParse(value);
                //                                       if (quantity == null ||
                //                                           quantity <= 0) {
                //                                         return 'Quantity must be a positive number';
                //                                       }
                //                                       return null; // Return null if the input is valid
                //                                     },
                //                                   ),
                //                                 ),
                //                               ),
                //                           Flexible(
                //                       child: Container(
                //                           child: priceofproduct == null
                //                               ? Text(
                //                                   'Product Price : 0.00',
                //                                   overflow:
                //                                       TextOverflow.ellipsis,
                //                                   style: TextStyle(
                //                                     fontSize: 16.0,
                //                                     fontFamily: 'Roboto',
                //                                     color: Color(0xFF212121),
                //                                     fontWeight:
                //                                         FontWeight.bold,
                //                                   ),
                //                                 )
                //                               : Text(priceofproduct!)),
                //                     ),
                //                             ],
                //                           ),
                //                            SizedBox(
                //                             height: MediaQuery.of(context)
                //                                     .size
                //                                     .height /
                //                                 20,
                //                           ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: description!.toUpperCase().split('\n').map((line) {
                //     return Row(
                //       children: [
                //         Icon(Icons.star,
                //             size: 10, // Adjust the size as needed
                //             color: Colors.black // Adjust the color as needed
                //             ),
                //         SizedBox(
                //           width:
                //               8, // Add some space between the circle icon and text
                //         ),
                //         Flexible(
                //           child: Text(
                //             line,
                //             style: TextStyle(
                //               fontSize: 16,
                //             ),
                //             overflow:
                //                 TextOverflow.visible, // Handle text overflow
                //           ),
                //         ),
                //       ],
                //     );
                //   }).toList(),
                // ),
                //             ],
                // ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              );
            }
          },
        ),
        // bottomNavigationBar: BottomAppBar(
        //   child: Container(
        //     color: Colors.black,
        //     child: Row(
        //       children: [
        //         Expanded(
        //           child: Container(
        //             height: 50,
        //             decoration: BoxDecoration(
        //               color: Colors.amber,
        //             ),
        //             child: ElevatedButton(
        //               onPressed: () {
        //                 if (_formKey.currentState!.validate()) {
        //                   if (FirebaseAuth.instance.currentUser != null) {
        //                     final price = double.parse(priceofproduct!);
        //                     final quantity =
        //                         int.tryParse(quantityController.text) ?? 0;
        //                     final imageUrl =
        //                         // selectedThumbnailProvider
        //                         //         .selectedThumbnail ??
        //                         thumbnail;
        //                     final productName = textpass;
        //                     final cartProvider = Provider.of<CartProvider>(
        //                         context,
        //                         listen: false);
        //                     cartProvider.addToCart(
        //                         // productCode:productCode,
        //                         price: price,
        //                         quantity: quantity,
        //                         imageUrl: imageUrl ?? '',
        //                         productName: productName ?? '');
        //                     ScaffoldMessenger.of(context).showSnackBar(
        //                         SnackBar(content: Text("Added to cart")));
        //                   } else {
        //                     // signed out
        //                     showDialog(
        //                       context: context,
        //                       builder: (BuildContext context) {
        //                         return LoginPage(); // Your custom dialog widget
        //                       },
        //                     );
        //                   }
        //                 }
        //               },
        //               child: const Text('ADD TO CART'),
        //               style: ButtonStyle(
        //                 backgroundColor: MaterialStateProperty.all(
        //                     Color.fromRGBO(249, 156, 6, 1.0)),
        //                 minimumSize: MaterialStateProperty.all(Size(150, 50)),
        //               ),
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: Container(
        //             height: 50,
        //             decoration: BoxDecoration(
        //               color: Colors.black,
        //             ),
        //             child: TextButton(
        //               onPressed: () {
        //                 Navigator.pushNamed(context, '/cart');
        //               },
        //               child: Text(
        //                 'GO TO CART',
        //                 style: TextStyle(color: Colors.white),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      desktopProductPage: FutureBuilder(
        future: context.read<DataProvider>().setTypeOfProducts(typeOfProduct),
        builder: (context, snapshot) {
          snapshot.data!.data.length;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: lottieSuccess()); // You can replace this with a loading indicator or any other widget while waiting for data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String? textpass = "";
            String? thumbnail = "";
            String? description = "";
            String? Ultype;
            String? priceofproduct = "";
            List<String>? image = [];
            // String? pdf = "";

            if (selectedThumbnailProvider.selectedIndex != null) {
              // print("kjh");
              textpass = snapshot.data!
                  .data[selectedThumbnailProvider.selectedIndex!].productName;
              thumbnail = snapshot.data!
                  .data[selectedThumbnailProvider.selectedIndex!].thumbnail;
              description = snapshot.data!
                  .data[selectedThumbnailProvider.selectedIndex!].description;
              // price = snapshot
              //     .data!
              //     .data[selectedThumbnailProvider.selectedIndex!]
              //     .codesAndPrice!;
               Ultype = snapshot
                      .data!
                      .data[selectedThumbnailProvider.selectedIndex!]
                      .ultype;
              priceofproduct = snapshot
                  .data!
                  .data[selectedThumbnailProvider.selectedIndex!]
                  .priceofproduct;
              image = snapshot
                  .data!.data[selectedThumbnailProvider.selectedIndex!].images;
              // pdf = snapshot
              //     .data!.data[selectedThumbnailProvider.selectedIndex!].pdf;
            } else {
              // print(product_name);
              // print("khgg");

              snapshot.data!.data.firstWhere((element) {
                if (element.productName == product_name) {
                  Ultype  = element.ultype;
                  textpass = element.productName;
                  thumbnail = element.thumbnail;
                  description = element.description;
                  priceofproduct = element.priceofproduct;
                  // price?.addAll(element.codesAndPrice!.map((e) => e));
                  image?.addAll(element.images!.map((e) => e));
                  // pdf = element.pdf ?? "";
                  return true;
                } else {
                  return false;
                }
              });
            }

            return DefaultTabController(
              length: 2,
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 1.3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        // height: MediaQuery.of(context).size.height/1,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              // height: do
                              // color: const Color.fromARGB(255, 138, 129, 101),
                              width: MediaQuery.of(context).size.width / 1,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: image!.map((imageUrl) {
                                              return GestureDetector(
                                                onTap: () {
                                                  // When an image is clicked, set it as the selected thumbnail.
                                                  // selectedKiduProvider
                                                  //     .setSelectedKidu(imageUrl ??
                                                  //         "data:image/jpeg;base64,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");
                                                  selectedThumbnailProvider
                                                      .setSelectedThumbnail(
                                                          imageUrl ??
                                                              "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ8NDQ0NFREWFhURFRUYHSggGBstIBUVIjEhMTUtLi8wFyszOD8tNzQtOC0BCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIAKoBKAMBIgACEQEDEQH/xAAbAAEBAQEAAwEAAAAAAAAAAAAAAQQFAgMGB//EADEQAQACAQIEBAQGAQUAAAAAAAABAhEDIQQSQWEiMVGREzJxgQUGUqHR8BQjcpKx4f/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwD9U4jjeK59asU1aRSmpOhjQtqRrXi2pGJtFcRERWkx5Z5vOSv43xGIzwOtmZxERXU886WazM0xExGpff5Z+HOJ9O3v2N+wOXwHE8TrU5rVmlptq8sTS9IiscvLnnrFsbz0iWmOJ1MViaeKYrPlbeZxt5ee8z9vbXv2N+wMf+XfETyZnriLbft16fz564mczHLiI8rZjf7Lv2N+wKJv2N+wKJv2XfsAJv2N+wKJv2XfsAJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2AUAAAAAAABUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUQAAAAAAAAAAAAAAAVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABUAAAAAAAFQAAAAAAAABUAAVAVAAAAVAFQAFQAAAVAAAAAAAAAAAAAAAAAAAAAAAGfj+KjQ0ralukeGP1W6Q+Y4H8a1q60W1dS16WnF6z5RE9Yjph5/mTjviavwqz4NKZifSdTr7eXu8fxHg9GnCcNqUiYvqRXmnMzzZpmdvqD66JzGY3id4npI4v5Z47n050bT4tKPD30/8Azy9naAAAAAAAAAAAAAAABQQAAAAAAFBAAAAAAAAGH8Z434Gja0fPbw6f+6ev28258n+aNS88Ri2YpWkfD9Jz5z77fYHIbuM4iLcPwtImJmka3NGd48Xhz9mDMesNGtxVLaelpxp0pbTzzakfNqfUE4LibaOpTUr51neP1V6w+60dWt61vWc1tEWie0vz7MesPqfyre86N4tnkrf/AE5nv5xH96g7YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA9PGWtGnM1znNMzWM2inNHNMd8ZYtXi/h5+FNr18UxN86lZmIrmtbTOZ859evpOA6Y59OI4iZpXwR8TlnPw74pE11JmJ8W/wAtff6PVPG61qRMctLTibU5LTbSr4Z5pnO8Tv79pB1cQYhk1OI5NXUiZz/pac6dc45782pmI7/L+zNq/iGpWJxy3xSbRaunaK2tFczp4m2c+87+W0g6mIGHh9e99WImYx8PVzWK2jktF6xEWnrOM/8Afkz24u/w9Dlt4uTSnVti1uWefTieaI7Tb2ny3B1hzY43V3meWK5isW5LYtm145t7RERisf8AL6ZaXG601raaVjn5KVryXia6ltOts2zPy5m0T9AdIAAAAAAAAAAAAAAAAAAAAAAAAAGSnF3xE205iJiJicxtmOvbun+fERMzS3TrGcT1/vrHq2KDLrcZFJmJpecYnONun8wf5teXm5bec1iNszOM4aQGO/HRForyWzm2d42xE+/TH1WvG5rzcltpiLR6bT/H7w2IDNbjIjGa2xMZzG/WY29fX6PGnGxOfDMRFb2tOf0zHl6xvPs2JMZ2nePSQZZ46N/BfPSNszOcY+vX6LqcXi01ikzyzi2JjaIpzZ/eI92pAZI47f5LYxWYnMb5mYx/e/oW4mszpzyTa1vk2jwzOYzn089+7WAzU4zOZ5LYjl9ObMzMYx9o93rj8Q3xyW+WJ6ee+Yn08s/RtUHo0OIi8zGJiYx543z1h7gABQQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH//Z");
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: FittedBox(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: imageUrl ==
                                                                  // imageUrl
                                                                  // selectedKiduProvider
                                                                  //     .selectedKidu
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
                                                            70, // Set the desired width for each image
                                                        height:
                                                            70, // Set the desired height for each image
                                                        fit: BoxFit
                                                            .cover, // You can adjust the fit as needed
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        FittedBox(
                                          child: Stack(
                                            children:[ Container(
                                            color: Colors.white,
                                            height: MediaQuery.of(context).size.height / 1.8,
                                            width: MediaQuery.of(context).size.width / 4,
                                            child: selectedThumbnailProvider.selectedThumbnail != null
                                                ? Image.network(selectedThumbnailProvider.selectedThumbnail!)
                                                : thumbnail != null
                                                    ? Image.network(thumbnail!)
                                                    : SizedBox(), // Empty SizedBox() as a placeholder if both thumbnail and selectedThumbnail are null
                                          ),
                                          if (Ultype!=null)
                              Positioned(
                                top: 20,
                                left: 0,
                                  child: Image.network(
                                    'https://deltabuckets.s3.ap-south-1.amazonaws.com/images/ul+list+logo+from+hex+site.png',
                                    // 'https://deltabuckets.s3.ap-south-1.amazonaws.com/Light+Brown+Taupe+Beige+Modern+Elegance+Recruitment+LinkedIn+Profile+Picture+(100+x+100+px)+(100+x+70+px).png',
                                    width: 100,
                                    height: 45,
                                    fit: BoxFit.fill,
                                  ),
                              ),
                                            ]
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FittedBox(
                              child: SizedBox(
                                // color: Colors.amber,
                                height: MediaQuery.of(context).size.height / 4,

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (FirebaseAuth
                                                  .instance.currentUser !=
                                              null) {
                                            // signed in
                                            // final selectedPrice =
                                            //     selectedPriceNotifier
                                            //         .value;
                                            final price =
                                                double.parse(priceofproduct!);

                                            final quantity = int.tryParse(
                                                    quantityController.text) ??
                                                0;

                                            final imageUrl =
                                                // selectedThumbnailProvider
                                                //         .selectedThumbnail ??
                                                thumbnail;
                                            final productName = textpass;

                                            final cartProvider =
                                                Provider.of<CartProvider>(
                                                    context,
                                                    listen: false);

                                            // print(
                                            //     'ooooooooooooooooooooo   $textpass');
                                            // print(price);
                                            // print(productName);
                                            cartProvider.addToCart(
                                                // productCode:'null',
                                                // productCode: '',
                                                price: price,
                                                quantity: quantity,
                                                imageUrl: imageUrl ?? '',
                                                productName: productName ?? '');

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Added to cart")),
                                            );
                                          } else {
                                            // signed out
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return LoginPage(); // Your custom dialog widget
                                              },
                                            );
                                          }
                                        }
                                      },
                                      child: Text('ADD TO CART', style: GoogleFonts.poppins(color: Colors.white),),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(addtoCart),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(180, 60)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        user != null;
                                            cartCount != 0
                                                ? Navigator.pushNamed( context, '/cart')
                                                : Navigator.pushNamed(
                                                    context, '/cartempty');
                                      },
                                      child:  Text(
                                        'GO TO CART',
 style: GoogleFonts.poppins(color: Colors.white),                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black
                                                // Color.fromRGBO(249, 188, 6, 1),
                                                ),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(180, 60)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TabBarView(
                              children: [
                                // Tab 1 content goes here
                                SizedBox(
                                  // height: 1000,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 16.0),
                                      Text(
                                        textpass ?? "",
                                       style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 26),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                      width:180, // Fixed width for the text field
                                       height: 40,
                                      decoration: BoxDecoration(
                                             border: Border.all(
                                             color: Colors.grey, // Border color
                                        width: 1, // Border width
                                      ),
                                        ),
                                        child: FittedBox(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center, // Center row contents horizontally
                                        // crossAxisAlignment: CrossAxisAlignment., // Center row contents vertically
                                        children: <Widget>[
                                         SizedBox(
                                      
                                       
                                      child: IconButton(
                                        onPressed: () {
                                          int currentQty = int.tryParse(quantityController.text) ?? 0;
                                          if (currentQty > 0) {
                                            quantityController.text = (currentQty - 1).toString();
                                          }
                                        },
                                        icon: Icon(Icons.remove),
                                      ),
                                      ),
                                          // Gap(5), // Provide some horizontal space between the button and the text field
                                          Form(
                                            key: _formKey,
                                            child: SizedBox(
                                              width: 60, // Fixed width for the text field
                                              height: 40,
                                              child: TextFormField(
                                                textAlign: TextAlign.center, // Center the text inside the text field
                                                controller: quantityController,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(vertical: 8.0), // Center the placeholder vertically
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(0), // Add rounded corners to the text field
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Gap(5),
                                          SizedBox(
                                       child: IconButton(
                                              onPressed: (){
                                                  int currentQty = int.tryParse(quantityController.text) ?? 0;
                                              quantityController.text = (currentQty + 1).toString();
                                              }, 
                                              icon:Icon(Icons.add),
                                          )),
                                        ],
                                      ),
                                        ),
                                        ),
                                      Gap(40),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: description!
                                            .split('\n')
                                            .map((line) {
                                          // Capitalize only the first letter of each word
                                          String capitalizedLine =
                                              line.split(' ').map((word) {
                                            if (word.isNotEmpty) {
                                              return word[0].toUpperCase() +
                                                  word
                                                      .substring(1)
                                                      .toLowerCase();
                                            } else {
                                              return '';
                                            }
                                          }).join(' ');

                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start, // Align items at the start of each row
                                            children: [
                                              Icon(Icons.star,
                                                  size: 25,
                                                  color: Colors.black),
                                              SizedBox(
                                                  width:
                                                      10), // Add space between icon and text
                                              Flexible(
                                                child: Text(
                                                  capitalizedLine
                                                      .trim(), // Trim any leading/trailing whitespace
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),

                                      // SizedBox(height: 8.0),
                                      SizedBox(height: 20.0),
                                      //
                                    ],
                                  ),
                                ),
                                // Tab 2 content goes here
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
