import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/loginpage.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/provider/thumbnail.dart';
import 'package:firebase_hex/responsive/product_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../model.dart';
import '../../provider/Text_color.dart';
import '../../widgets/style.dart';
import 'nonpdf_product.dart';

class ProductDetailsOfTools extends StatelessWidget {
  ProductDetailsOfTools({super.key});

  final ValueNotifier<String> selectedPriceNotifier = ValueNotifier<String>('');

  String? textpass;

  bool check_pr_code = false;
  int cartCount = 0;

  String? thumbnail;

  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController =
        TextEditingController(text: '1'); // start with initial value as 1
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String selectedProductIndex =
        ModalRoute.of(context)!.settings.name as String;
    var setting_list = selectedProductIndex.split('/');
    String product_name = "";
    if (setting_list.length > 2) {
// product_name=(setting_list[2]+"/"+setting_list[3]).replaceAll('_', ' ');
      for (int i = 2; i < setting_list.length; i++) {
        product_name += setting_list[i].replaceAll('_', ' ');
        if (i < setting_list.length - 1) {
          product_name += "/";
        }
      }
    } else
      product_name = setting_list[2].replaceAll('_', " ");

    final selectedCodeProvider = Provider.of<SelectedCodeProvider>(context);
    var user = Provider.of<AuthenticationHelper>(context).user;
    final selectedPriceNotifieru =
        Provider.of<SelectedPriceNotifier>(context, listen: false);
    final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);
    return ResponsiveProductPage(
      //******************MOBILE VIEW****************************

      mobileProductPage: Scaffold(
        // backgroundColor: Colors.white,
        body: FutureBuilder(
          future: context.read<DataProvider>().fetchcrimpingtoolApiUrl(),
          builder: (context, snapshot) {
            snapshot.data!.data.length;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      lottieSuccess()); // You can replace this with a loading indicator or any other widget while waiting for data.
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String? description;
              List<CodesAndPrice>? price = [];
              List<String>? image = [];
              String? pdf;

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
                image = snapshot.data!
                    .data[selectedThumbnailProvider.selectedIndex!].images;
                pdf = snapshot
                    .data!.data[selectedThumbnailProvider.selectedIndex!].pdf;
              } else {
                snapshot.data!.data.firstWhere((element) {
                  if (element.productName == product_name) {
                    print("2121");
                    textpass = element.productName;
                    thumbnail = element.thumbnail;
                    description = element.description;
                    price?.addAll(element.codesAndPrice!.map((e) => e));
                    image?.addAll(element.images!.map((e) => e));
                    pdf = element.pdf;
                    return true;
                  } else {
                    return false;
                  }
                });
              }

              return pdf != null
                  ? DefaultTabController(
                      length: 2,
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.amber,
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
                                                3.3,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.9,
                                        child: selectedThumbnailProvider
                                                    .selectedThumbnail !=
                                                null
                                            ? Image.network(
                                                selectedThumbnailProvider
                                                    .selectedThumbnail!)
                                            : thumbnail != null
                                                ? Image.network(thumbnail!)
                                                : SizedBox(), // Empty SizedBox() as a placeholder if both thumbnail and selectedThumbnail are null
                                      ),
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                30,
                                      ),

                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                30,
                                      ),

                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15,
                                          ),
                                          Flexible(
                                            child: Container(
                                              // color: Colors.amber,

                                              child: const Text(
                                                'selected Product code&Price:  ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily: 'Roboto',
                                                  color: Color.fromARGB(
                                                      255, 143, 143, 143),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 130,
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.0),
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                            child:
                                                Consumer<SelectedPriceNotifier>(
                                                    builder: (context,
                                                        selectedPriceNotifieru,
                                                        _) {
                                              return Text(
                                                "${selectedPriceNotifieru.selectedPrice}",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              );
                                            }),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SingleChildScrollView(
                                                          child: Stack(
                                                        children: [
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                1,
                                                            color: Colors.white,
                                                            child: pdf != null
                                                                ? SfPdfViewer
                                                                    .network(
                                                                        pdf!)
                                                                : Nopdf(),
                                                          ),
                                                          Positioned(
                                                            top:
                                                                16, // Adjust the top position as needed
                                                            right:
                                                                16, // Adjust the left position as needed
                                                            child: IconButton(
                                                              icon: Icon(Icons
                                                                  .close), // You can use any icon you like
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                // Add your close button action here
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                                    });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit_document),
                                                  Text("size chart")
                                                ],
                                              )
                                              //  Text("size chart")
                                              ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                20,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                13,
                                          ),
                                          Form(
                                            key: _formKey,
                                            child: Container(
                                              width: 140,
                                              // height: 43,
                                              child: TextFormField(
                                                controller: quantityController,
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
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Wrap(
                                            spacing:
                                                8.0, // Adjust the spacing between buttons as needed
                                            runSpacing:
                                                8.0, // Adjust the spacing between rows as needed
                                            children: List<Widget>.generate(
                                                price.length, (index) {
                                              final codeAndPrice =
                                                  price![index];
                                              return InkWell(
                                                onTap: () {
                                                  selectedPriceNotifieru
                                                      .setSelectedPrice(
                                                    '${codeAndPrice.productCode}  :  ${codeAndPrice.price != null ? 'SAR  ${codeAndPrice.price}' : 'Product available based on Request'}',
                                                  );
                                                  selectedPriceNotifieru
                                                      .setProductCodeSelected(
                                                          true);
                                                },
                                                child: Form(
                                                  autovalidateMode:
                                                      AutovalidateMode.always,
                                                  child: Container(
                                                    width: 100,
                                                    padding: EdgeInsets.all(
                                                        8.0), // Adjust the padding as needed
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        color: codeAndPrice
                                                                    .price ==
                                                                null
                                                            ? Colors
                                                                .red // Set border color to red when selectedPrice is null
                                                            : codeAndPrice
                                                                        .productCode ==
                                                                    selectedCodeProvider
                                                                        .selectedProductCode
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
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "    DESCRIPTION :\n",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 13),
                                        child: Column(
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
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Nopdf(
                      typeOfProduct: 'crimping Tool',
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
                              if (selectedPriceNotifieru
                                  .isProductCodeSelected) {
                                final selectedPrice =
                                    selectedPriceNotifieru.selectedPrice;

                                // Check if selectedPrice is empty or null, and provide a default value if needed

                                final productCode =
                                    selectedPrice.split(': ')[0];
                                final price = double.tryParse(
                                        selectedPrice.split(': ')[1]) ??
                                    0;
                                final quantity =
                                    int.tryParse(quantityController.text) ?? 0;
                                final imageUrl = thumbnail;
                                final productName = textpass;
                                final cartProvider = Provider.of<CartProvider>(
                                    context,
                                    listen: false);
                                cartProvider.addToCart(
                                    productCode: productCode,
                                    price: price,
                                    quantity: quantity,
                                    imageUrl: imageUrl ?? '',
                                    productName: productName ?? '');

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Added to cart')));
                                selectedPriceNotifieru
                                    .setProductCodeSelected(false);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Select the product code'),
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Select the product code'),
                              ));
                              // Handle the case where the user is not signed in
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
                          backgroundColor: MaterialStateProperty.all(addtoCart),
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: TextButton(
                      onPressed: () {
                        user != null;
                        cartCount != 0
                            ? Navigator.pushNamed(context, '/cart')
                            : Navigator.pushNamed(context, '/cartempty');
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

//-----------desktop--------------------------------------------------------

      desktopProductPage: FutureBuilder(
        future: context.read<DataProvider>().fetchcrimpingtoolApiUrl(),
        builder: (context, snapshot) {
          snapshot.data!.data.length;
          // print("jhjhh");
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("hgfghfhfgu");
            return Center(
                child:
                    lottieSuccess()); // You can replace this with a loading indicator or any other widget while waiting for data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String? ultype;
            String? textpass;
            String? thumbnail;
            String? description;
            List<CodesAndPrice>? price = [];
            List<String>? image = [];
            String? pdf;

            if (selectedThumbnailProvider.selectedIndex != null) {
              ultype = snapshot.data!.data[selectedThumbnailProvider.selectedIndex!].ultype;
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
              snapshot.data!.data.firstWhere((element) {
                if (element.productName == product_name) {
                  print("2121");
                  textpass = element.productName;
                  thumbnail = element.thumbnail;
                  description = element.description;
                  price?.addAll(element.codesAndPrice!.map((e) => e));
                  image?.addAll(element.images!.map((e) => e));
                  pdf = element.pdf;
                  return true;
                } else {
                  return false;
                }
              });
            }

            return pdf != null
                ? DefaultTabController(
                    length: 2,
                    child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 1.3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
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
                                                children:
                                                    image!.map((imageUrl) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      // When an image is clicked, set it as the selected thumbnail.
                                                      // selectedKiduProvider
                                                      //     .setSelectedKidu(imageUrl ??
                                                      //         "data:image/jpeg;base64,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");
                                                      selectedThumbnailProvider
                                                          .setSelectedThumbnail(
                                                              imageUrl ??
                                                                  "data:image/jpeg;base64,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");
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
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
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            Stack(children: [
                                              Container(
                                                color: Colors.white,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.8,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: selectedThumbnailProvider
                                                            .selectedThumbnail !=
                                                        null
                                                    ? Image.network(
                                                        selectedThumbnailProvider
                                                            .selectedThumbnail!)
                                                    : thumbnail != null
                                                        ? Image.network(
                                                            thumbnail!)
                                                        : SizedBox(), // Empty SizedBox() as a placeholder if both thumbnail and selectedThumbnail are null
                                              ),
                                              if(ultype!=null)
                                              // if (selectedThumbnailProvider. != null)
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
                                            ]),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.amber,
                                  height:
                                      MediaQuery.of(context).size.height / 4,

                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (FirebaseAuth
                                                    .instance.currentUser !=
                                                null) {
                                              if (selectedPriceNotifieru
                                                  .isProductCodeSelected) {
                                                final selectedPrice =
                                                    selectedPriceNotifieru
                                                        .selectedPrice;
                                                final productCode =
                                                    selectedPrice
                                                        .split(': ')[0];
                                                final price = double.tryParse(
                                                        selectedPrice
                                                            .split(': ')[1]) ??
                                                    0;
                                                final quantity = int.tryParse(
                                                        quantityController
                                                            .text) ??
                                                    0;
                                                final imageUrl = thumbnail;
                                                final productName = textpass;
                                                final cartProvider =
                                                    Provider.of<CartProvider>(
                                                        context,
                                                        listen: false);
                                                cartProvider.addToCart(
                                                    productCode: productCode,
                                                    price: price,
                                                    quantity: quantity,
                                                    imageUrl: imageUrl ?? '',
                                                    productName:
                                                        productName ?? '');

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Added to cart')));
                                                selectedPriceNotifieru
                                                    .setProductCodeSelected(
                                                        false);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Select the product code'),
                                                ));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Select the product code'),
                                              ));
                                              // Handle the case where the user is not signed in
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return LoginPage(); // Your custom dialog widget
                                                },
                                              );
                                            }
                                          }
                                        },
                                        child: Text(
                                          'ADD TO CART',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  addtoCart),
                                          minimumSize:
                                              MaterialStateProperty.all(
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
                                              ? Navigator.pushNamed(
                                                  context, '/cart')
                                              : Navigator.pushNamed(
                                                  context, '/cartempty');
                                        },
                                        child: Text(
                                          'GO TO CART',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black
                                                  // Color.fromRGBO(249, 188, 6, 1),
                                                  ),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(180, 60)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(right: 35),
                                child: Column(
                                  children: [
                                    Container(
                                      // height: 1000,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Gap(30),
                                          Text(
                                            textpass ?? "",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 26),
                                          ),
                                          Gap(25),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      // color: Colors.amber,
                                                      child: Text(
                                                        'Selected Product Code & Price:  ',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xFF212121),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 130,
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 1.0),
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      ),
                                                      child: Consumer<
                                                              SelectedPriceNotifier>(
                                                          builder: (context,
                                                              selectedPriceNotifieru,
                                                              _) {
                                                        return Text(
                                                          "${selectedPriceNotifieru.selectedPrice}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        );
                                                      }),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Gap(95),
                                              TextButton(
                                                  onPressed: () => SideSheet.right(
                                                      body: Container(
                                                          height: 1500,
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              230, 233, 235),
                                                          child: pdf != null
                                                              ? SfPdfViewer
                                                                  .network(pdf!)
                                                              : Nopdf()),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      context: context),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.edit_document),
                                                      Text(
                                                        "Size Chart",
                                                        style: TextStyle(),
                                                      )
                                                    ],
                                                  )),
                                              Gap(20)
                                            ],
                                          ),
                                          Container(
                                            width:
                                                180, // Fixed width for the text field
                                            height: 40,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    Colors.grey, // Border color
                                                width: 1, // Border width
                                              ),
                                            ),
                                            child: FittedBox(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center, // Center row contents horizontally
                                                // crossAxisAlignment: CrossAxisAlignment., // Center row contents vertically
                                                children: <Widget>[
                                                  SizedBox(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        int currentQty =
                                                            int.tryParse(
                                                                    quantityController
                                                                        .text) ??
                                                                0;
                                                        if (currentQty > 0) {
                                                          quantityController
                                                                  .text =
                                                              (currentQty - 1)
                                                                  .toString();
                                                        }
                                                      },
                                                      icon: Icon(Icons.remove),
                                                    ),
                                                  ),
                                                  // Gap(5), // Provide some horizontal space between the button and the text field
                                                  Form(
                                                    key: _formKey,
                                                    child: SizedBox(
                                                      width:
                                                          60, // Fixed width for the text field
                                                      height: 40,
                                                      child: TextFormField(
                                                        textAlign: TextAlign
                                                            .center, // Center the text inside the text field
                                                        controller:
                                                            quantityController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                  vertical:
                                                                      8.0), // Center the placeholder vertically
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0), // Add rounded corners to the text field
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Gap(5),
                                                  SizedBox(
                                                      child: IconButton(
                                                    onPressed: () {
                                                      int currentQty = int.tryParse(
                                                              quantityController
                                                                  .text) ??
                                                          0;
                                                      quantityController.text =
                                                          (currentQty + 1)
                                                              .toString();
                                                    },
                                                    icon: Icon(Icons.add),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 30,
                                              ),
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
                                                      selectedPriceNotifieru
                                                          .setSelectedPrice(
                                                        '${codeAndPrice.productCode}  :  ${codeAndPrice.price != null ? 'SAR  ${codeAndPrice.price}' : 'Product available based on Request'}',
                                                      );
                                                      selectedPriceNotifieru
                                                          .setProductCodeSelected(
                                                              true);
                                                    },
                                                    child: Form(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .always,
                                                      child: Container(
                                                        width: 100,
                                                        padding: EdgeInsets.all(
                                                            8.0), // Adjust the padding as needed
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.all(
                                                            color: codeAndPrice
                                                                        .price ==
                                                                    null
                                                                ? Colors
                                                                    .black // Set border color to red when selectedPrice is null
                                                                : Colors
                                                                    .greenAccent
                                                                    .shade700,
                                                            // ? Colors
                                                            //     .blue // Set border color to blue for selected container
                                                            // : Colors
                                                            //     .black, // Set border color to black for non-selected containers
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
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
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
                                          Gap(30)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Nopdf(
                    typeOfProduct: 'crimping Tool',
                  );
          }
        },
      ),
    );
  }
}
