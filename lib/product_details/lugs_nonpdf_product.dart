
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/data_provider.dart';
import '../provider/thumbnail.dart';

import '../provider/user_input_provider.dart';
import '../responsive/product_page.dart';
import 'accessories_product.dart';

class Nopdf extends StatelessWidget {
  final ValueNotifier<String> selectedPriceNotifier = ValueNotifier<String>('');
  String? typeOfProduct;
Nopdf({this.typeOfProduct});
  // Nopdf({required this.productData, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    print("gfhjkl");
    print(typeOfProduct);
    final userInputProvider = Provider.of<UserInputProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
TextEditingController quantityController = TextEditingController();

    final int selectedProductIndex =
        ModalRoute.of(context)!.settings.arguments as int;

    final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);
    return ResponsiveProductPage(
      mobileProductPage: MobileProduct(),
      desktopProductPage: FutureBuilder(
        future: context.read<DataProvider>().setTypeOfProducts( typeOfProduct),
        builder: (context, snapshot) {
          snapshot.data!.data.length;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // You can replace this with a loading indicator or any other widget while waiting for data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {  
            var textpass =
                snapshot.data!.data[selectedProductIndex].productName;
            var thumbnail = snapshot.data!.data[selectedProductIndex].thumbnail;
            var description =
                snapshot.data!.data[selectedProductIndex].description;
            var price = snapshot.data!.data[selectedProductIndex].codesAndPrice!;
            var image = snapshot.data!.data[selectedProductIndex].images;
            var pdf = snapshot.data!.data[selectedProductIndex].pdf;

            //  String selectedPrice = '';

            return 
            // pdf!=null?
            DefaultTabController(
              length: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 1.3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1,
                        width: MediaQuery.of(context).size.width / 1,
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.network(selectedThumbnailProvider
                                        .selectedThumbnail ??
                                    ''),
                              ), // Display the selected thumbnail here                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: image!.map((imageUrl) {
                                    return GestureDetector(
                                      onTap: () {
                                        // When an image is clicked, set it as the selected thumbnail.
                                        selectedThumbnailProvider
                                            .setSelectedThumbnail(imageUrl??"data:image/jpeg;base64,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");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                              width: 1.0, // Border width
                                            ),
                                          ),
                                          child: Image.network(
                                            imageUrl??"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ8NDQ0NFREWFhURFRUYHSggGBstIBUVIjEhMTUtLi8wFyszOD8tNzQtOC0BCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIAKoBKAMBIgACEQEDEQH/xAAbAAEBAQEAAwEAAAAAAAAAAAAAAQQFAgMGB//EADEQAQACAQIEBAQGAQUAAAAAAAABAhEDIQQSQWEiMVGREzJxgQUGUqHR8BQjcpKx4f/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwD9U4jjeK59asU1aRSmpOhjQtqRrXi2pGJtFcRERWkx5Z5vOSv43xGIzwOtmZxERXU886WazM0xExGpff5Z+HOJ9O3v2N+wOXwHE8TrU5rVmlptq8sTS9IiscvLnnrFsbz0iWmOJ1MViaeKYrPlbeZxt5ee8z9vbXv2N+wMf+XfETyZnriLbft16fz564mczHLiI8rZjf7Lv2N+wKJv2N+wKJv2XfsAJv2N+wKJv2XfsAJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2N+wKJv2AUAAAAAAABUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUQAAAAAAAAAAAAAAAVAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABUAAAAAAAFQAAAAAAAABUAAVAVAAAAVAFQAFQAAAVAAAAAAAAAAAAAAAAAAAAAAAGfj+KjQ0ralukeGP1W6Q+Y4H8a1q60W1dS16WnF6z5RE9Yjph5/mTjviavwqz4NKZifSdTr7eXu8fxHg9GnCcNqUiYvqRXmnMzzZpmdvqD66JzGY3id4npI4v5Z47n050bT4tKPD30/8Azy9naAAAAAAAAAAAAAAABQQAAAAAAFBAAAAAAAAGH8Z434Gja0fPbw6f+6ev28258n+aNS88Ri2YpWkfD9Jz5z77fYHIbuM4iLcPwtImJmka3NGd48Xhz9mDMesNGtxVLaelpxp0pbTzzakfNqfUE4LibaOpTUr51neP1V6w+60dWt61vWc1tEWie0vz7MesPqfyre86N4tnkrf/AE5nv5xH96g7YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA9PGWtGnM1znNMzWM2inNHNMd8ZYtXi/h5+FNr18UxN86lZmIrmtbTOZ859evpOA6Y59OI4iZpXwR8TlnPw74pE11JmJ8W/wAtff6PVPG61qRMctLTibU5LTbSr4Z5pnO8Tv79pB1cQYhk1OI5NXUiZz/pac6dc45782pmI7/L+zNq/iGpWJxy3xSbRaunaK2tFczp4m2c+87+W0g6mIGHh9e99WImYx8PVzWK2jktF6xEWnrOM/8Afkz24u/w9Dlt4uTSnVti1uWefTieaI7Tb2ny3B1hzY43V3meWK5isW5LYtm145t7RERisf8AL6ZaXG601raaVjn5KVryXia6ltOts2zPy5m0T9AdIAAAAAAAAAAAAAAAAAAAAAAAAAGSnF3xE205iJiJicxtmOvbun+fERMzS3TrGcT1/vrHq2KDLrcZFJmJpecYnONun8wf5teXm5bec1iNszOM4aQGO/HRForyWzm2d42xE+/TH1WvG5rzcltpiLR6bT/H7w2IDNbjIjGa2xMZzG/WY29fX6PGnGxOfDMRFb2tOf0zHl6xvPs2JMZ2nePSQZZ46N/BfPSNszOcY+vX6LqcXi01ikzyzi2JjaIpzZ/eI92pAZI47f5LYxWYnMb5mYx/e/oW4mszpzyTa1vk2jwzOYzn089+7WAzU4zOZ5LYjl9ObMzMYx9o93rj8Q3xyW+WJ6ee+Yn08s/RtUHo0OIi8zGJiYx543z1h7gABQQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH//Z",
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
                                height: 50,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: new Container(
                                      padding: new EdgeInsets.only(right: 13.0),
                                      child: new Text(
                                        'selected Product code&Price:',
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Roboto',
                                          color: new Color(0xFF212121),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ValueListenableBuilder<String>(
                                    valueListenable: selectedPriceNotifier,
                                    builder: (context, selectedPrice, child) {
                                      return Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Text(selectedPrice),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
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
                                        textpass??"",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      SizedBox(height: 8.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            description!.toUpperCase().split('\n').map((line) {
                                          return Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size:
                                                    10, // Adjust the size as needed
                                                color: Color.fromARGB(
                                                    255,
                                                    220,
                                                    227,
                                                    26), // Adjust the color as needed
                                              ),
                                              SizedBox(
                                                  width:
                                                      8), // Add some space between the circle icon and text
                                              Text(
                                                line,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),

                                      // SizedBox(height: 8.0),
                                      SizedBox(height: 8.0),
                                      Container(
                                          height: 40, // Set the desired height
                                          width: 120,
                                          color: Colors
                                              .white, // Set the desired width
                                          child: TextFormField(
                                             controller: quantityController, // Link the controller to the TextFormField
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            // Align the text in the center
                                            decoration: InputDecoration(
                                              hintText: 'Enter quantity',
                                              // Add your desired text here
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 8.0,
                                              ), // Adjust the padding as needed
                                              isDense: true,
                                              // Reduces the height of the TextFormField
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                              // Removes the border
                                            ),
                                          )),
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
                                              final selectedPrice =
                                                  selectedPriceNotifier.value;
                                              final productCode =
                                                  selectedPrice.split(': ')[0];
                                              final price = double.parse(
                                                  selectedPrice.split(': ')[1]);

            final quantity = int.tryParse(quantityController.text) ?? 0;
                                              final imageUrl =
                                                  selectedThumbnailProvider
                                                          .selectedThumbnail ??
                                                      thumbnail;
                                              final productName = textpass;
                                              final cartProvider =
                                                  Provider.of<CartProvider>(
                                                      context,
                                                      listen: false);
                                              cartProvider.addToCart(
                                                  productCode,
                                                  price,
                                                  quantity,
                                                  imageUrl??"",
                                                  productName??"");
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
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size(150, 50)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     Text(
                                      //       'Codes and Prices:',
                                      //       style: TextStyle(
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 18,
                                      //       ),
                                      //     ),
                                         
                                      //     for (var codeAndPrice in price)
                                      //       ElevatedButton(
                                      //         onPressed: () {   
                                      //           // When a button is clicked, update the selectedPrice using ValueNotifier.
                                      //           selectedPriceNotifier.value =
                                      //               '${codeAndPrice.productCode}: ${codeAndPrice.price}';
                                      //         },
                                      //         child: Text(
                                      //           '${codeAndPrice.productCode}',
                                      //         ),
                                      //       ),
                                      //   ],
                                      // ),
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