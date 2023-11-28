import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../model.dart';
import '../../provider/cart_provider.dart';
import '../../provider/data_provider.dart';
import '../../provider/thumbnail.dart';
import '../../responsive/product_page.dart';

class Nopdf extends StatelessWidget {
  final ValueNotifier<String> selectedPriceNotifier = ValueNotifier<String>('');
  String? typeOfProduct;
  Nopdf({this.typeOfProduct});

  String? textpass;
  String? thumbnail;
  String? description;
  String? priceofproduct = "";
  // List<String>? image = [];
  
  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController = TextEditingController();
    var user = Provider.of<AuthenticationHelper>(context).user;

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String selectedProductIndex =
        ModalRoute.of(context)!.settings.name as String;
    var setting_list = selectedProductIndex.split('/');
    typeOfProduct = setting_list[1].substring(14).toString();
    String product_name = setting_list[2].replaceAll('_', " ");
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
                  child:
                      const CircularProgressIndicator()); // You can replace this with a loading indicator or any other widget while waiting for data.
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String? description = "";
                List<String>? image = [];


              if (selectedThumbnailProvider.selectedIndex != null) {
                print("kjh");
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
                priceofproduct = snapshot
                    .data!
                    .data[selectedThumbnailProvider.selectedIndex!]
                    .priceofproduct;
                image = snapshot.data!
                    .data[selectedThumbnailProvider.selectedIndex!].images;
                // pdf = snapshot
                //     .data!.data[selectedThumbnailProvider.selectedIndex!].pdf;
              } else {
                // print(product_name);
                // print("khgg");

                snapshot.data!.data.firstWhere((element) {
                  if (element.productName == product_name) {
                    print("2121");
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
                  height: MediaQuery.of(context).size.height * 1.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, top: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Image.network(
                                      thumbnail!,
                                      // selectedThumbnailProvider
                                      //       .selectedThumbnail ??
                                      //   ''
                                    ),
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: imageUrl ==
                                                                    // imageUrl
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
                                                              "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ8NDQ0NFREWFhURFRUYHSggGBstIBUVIjEhMTUtLi8wFyszOD8tNzQtOC0BCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIAKoBKAMBIgACEQEDEQH/xAAbAAEBAQEAAwEAAAAAAAAAAAAAAQQFAgMGB//EADEQAQACAQIEBAQGAQUAAAAAAAABAhEDIQQSQWEiMVGREzJxgQUGUqHR8BQjcpKx4f/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwD9U4jjeK59asU1aRSmpOhjQtqRrXi2pGJtFcRERWkx5Z5vOSv43xGIzwOtmZxERXU886WazM0xExGpff5Z+HOJ9O3v2N+wOXwHE8TrU5rVmlptq8sTS9IiscvLnnrFsbz0iWmOJ1MViaeKYrPlbeZxt5ee8z9vbXv2N+wMf+XfETyZnriLbft16fz564mczHLiI8rZjf7Lv2N+wKJv2N+wKJv2XfsAJv2N+wKJv2XfsAJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2AUAAAAAAABUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUQAAAAAAAAAAAAAAAVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABUAAAAAAAFQAAAAAAAABUAAVAVAAAAVAFQAFQAAAVAAAAAAAAAAAAAAAAAAAAAAAGfj+KjQ0ralukeGP1W6Q+Y4H8a1q60W1dS16WnF6z5RE9Yjph5/mTjviavwqz4NKZifSdTr7eXu8fxHg9GnCcNqUiYvqRXmnMzzZpmdvqD66JzGY3id4npI4v5Z47n050bT4tKPD30/8Azy9naAAAAAAAAAAAAAAABQQAAAAAAFBAAAAAAAAGH8Z434Gja0fPbw6f+6ev28258n+aNS88Ri2YpWkfD9Jz5z77fYHIbuM4iLcPwtImJmka3NGd48Xhz9mDMesNGtxVLaelpxp0pbTzzakfNqfUE4LibaOpTUr51neP1V6w+60dWt61vWc1tEWie0vz7MesPqfyre86N4tnkrf/AE5nv5xH96g7YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA9PGWtGnM1znNMzWM2inNHNMd8ZYtXi/h5+FNr18UxN86lZmIrmtbTOZ859evpOA6Y59OI4iZpXwR8TlnPw74pE11JmJ8W/wAtff6PVPG61qRMctLTibU5LTbSr4Z5pnO8Tv79pB1cQYhk1OI5NXUiZz/pac6dc45782pmI7/L+zNq/iGpWJxy3xSbRaunaK2tFczp4m2c+87+W0g6mIGHh9e99WImYx8PVzWK2jktF6xEWnrOM/8Afkz24u/w9Dlt4uTSnVti1uWefTieaI7Tb2ny3B1hzY43V3meWK5isW5LYtm145t7RERisf8AL6ZaXG601raaVjn5KVryXia6ltOts2zPy5m0T9AdIAAAAAAAAAAAAAAAAAAAAAAAAAGSnF3xE205iJiJicxtmOvbun+fERMzS3TrGcT1/vrHq2KDLrcZFJmJpecYnONun8wf5teXm5bec1iNszOM4aQGO/HRForyWzm2d42xE+/TH1WvG5rzcltpiLR6bT/H7w2IDNbjIjGa2xMZzG/WY29fX6PGnGxOfDMRFb2tOf0zHl6xvPs2JMZ2nePSQZZ46N/BfPSNszOcY+vX6LqcXi01ikzyzi2JjaIpzZ/eI92pAZI47f5LYxWYnMb5mYx/e/oW4mszpzyTa1vk2jwzOYzn089+7WAzU4zOZ5LYjl9ObMzMYx9o93rj8Q3xyW+WJ6ee+Yn08s/RtUHo0OIi8zGJiYx543z1h7gABQQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH//Z",
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15, left: 15),
                                              child: Text(
                                                textpass ?? "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              ),
                                            ),
      
                                            Divider(),
                                             SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  20,
                                            ),
                                            Row(
                                              children: [
                                                Gap(25),
                                                Form(
                                                  key: _formKey,
                                                  child: Container(
                                                    width: 140,
                                                    // height: 43,
                                                    child: TextFormField(
                                                      controller:
                                                          quantityController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText:
                                                              'Enter the quantity',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14)),
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
                                              
                                            Flexible(
                                        child: Container(

                                            child: priceofproduct == null
                                                ? Text(
                                                    'Product Price : 0.00',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontFamily: 'Roboto',
                                                      color: Color(0xFF212121),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : Text(priceofproduct!)),
                                      ),
                                              ],
                                            ),
                                             SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  20,
                                            ),
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
                                          ],
                              ),
                            ),
                          ),
                        ),
                      ),
                     
                    ],
                  ),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (FirebaseAuth.instance.currentUser != null) {
                            final price = double.parse(priceofproduct!);

                            final quantity =
                                int.tryParse(quantityController.text) ?? 0;

                            final imageUrl =
                                // selectedThumbnailProvider
                                //         .selectedThumbnail ??
                                thumbnail;
                            final productName = textpass;

                            final cartProvider = Provider.of<CartProvider>(
                                context,
                                listen: false);
                            cartProvider.addToCart(
                                // productCode:productCode,
                                price: price,
                                quantity: quantity,
                                imageUrl: imageUrl ?? '',
                                productName: productName ?? '');

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Added to cart")));
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
                      child: const Text('ADD TO CART'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 54, 98, 98)),
                        minimumSize: MaterialStateProperty.all(Size(150, 50)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      child: Text(
                        'GO TO CART',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      desktopProductPage: FutureBuilder(
        future: context.read<DataProvider>().setTypeOfProducts(typeOfProduct),
        builder: (context, snapshot) {
          snapshot.data!.data.length;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    const CircularProgressIndicator()); // You can replace this with a loading indicator or any other widget while waiting for data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String? textpass = "";
            String? thumbnail = "";
            String? description = "";
            // List<CodesAndPrice>? price = [];
            String? priceofproduct = "";
            List<String>? image = [];
            // String? pdf = "";

            if (selectedThumbnailProvider.selectedIndex != null) {
              print("kjh");
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
              priceofproduct = snapshot
                  .data!
                  .data[selectedThumbnailProvider.selectedIndex!]
                  .priceofproduct;
              image = snapshot
                  .data!.data[selectedThumbnailProvider.selectedIndex!].images;
              // pdf = snapshot
              //     .data!.data[selectedThumbnailProvider.selectedIndex!].pdf;
            } else {
              print(product_name);
              print("khgg");

              snapshot.data!.data.firstWhere((element) {
                if (element.productName == product_name) {
                  print("2121");
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Image.network(thumbnail!
                                      // selectedThumbnailProvider
                                      //       .selectedThumbnail ??
                                      // ''
                                      ),
                                ), // Display the selected thumbnail here
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: image!.map((imageUrl) {
                                      return GestureDetector(
                                        onTap: () {
                                          // When an image is clicked, set it as the selected thumbnail.
                                          selectedThumbnailProvider
                                              .setSelectedThumbnail(imageUrl ??
                                                  "data:image/jpeg;base64,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");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: imageUrl == imageUrl
                                                    // selectedThumbnailProvider
                                                    //     .selectedThumbnail
                                                    ? Colors
                                                        .blue // Highlight the selected image
                                                    : Colors
                                                        .black, // Border color for non-selected images
                                                width: 1.0, // Border width
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
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                    Flexible(
                                      child: Container(
                                          // color: Colors.amber,

                                          child: priceofproduct == '0'
                                              ? Text(
                                                  'Product Price: \$ 0.00',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: 'Roboto',
                                                    color: Color(0xFF212121),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Text(
                                                  'Product Price: \$ ' +
                                                      priceofproduct!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: 'Roboto',
                                                    color: Color(0xFF212121),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                    ),
                                    // ValueListenableBuilder<String>(
                                    //   valueListenable: selectedPriceNotifier,
                                    //   builder: (context, selectedPrice, child) {
                                    //     return Container(
                                    //       padding: EdgeInsets.all(8.0),
                                    //       decoration: BoxDecoration(
                                    //         border: Border.all(
                                    //           color: Colors.black,
                                    //           width: 1.0,
                                    //         ),
                                    //       ),
                                    //       child: Text(selectedPrice),
                                    //     );
                                    //   },
                                    // ),
                                  ],
                                ),
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
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Form(
                                            key: _formKey,
                                            child: Container(
                                              width: 200,
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
                                        ],
                                      ),

                                      SizedBox(
                                        height: 30,
                                      ),

                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (FirebaseAuth.instance
                                                          .currentUser !=
                                                      null) {
                                                    // signed in
                                                    // final selectedPrice =
                                                    //     selectedPriceNotifier
                                                    //         .value;

                                                    final price = double.parse(
                                                        priceofproduct!);

                                                    final quantity = int.tryParse(
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

                                                    // print(
                                                    //     'ooooooooooooooooooooo   $textpass');
                                                    print(price);
                                                    print(productName);
                                                    cartProvider.addToCart(
                                                        // productCode:'null',
                                                        // productCode: '',
                                                        price: price,
                                                        quantity: quantity,
                                                        imageUrl:
                                                            imageUrl ?? '',
                                                        productName:
                                                            productName ?? '');

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              "Added to cart")),
                                                    );
                                                    print(priceofproduct);
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
                                              child: const Text('ADD TO CART'),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        Size(150, 50)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                user != null
                                                    ? Navigator.pushNamed(
                                                        context, '/cart')
                                                    : showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return LoginPage(); // Your custom dialog widget
                                                        },
                                                      );
                                              },
                                              child: const Text(
                                                'GO TO CART',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        Size(150, 50)),
                                              ),
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