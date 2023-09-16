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
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Image.network(
                    'https://thumbs.dreamstime.com/b/electrical-tools-components-website-banner-format-shot-assortment-electrical-contractors-tools-house-plans-85133897.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          4, // Set the number of columns in the grid
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
                          color: Colors.white,
                          padding:
                              EdgeInsets.all(8.0), // Add spacing on all sides
                          margin:
                              EdgeInsets.all(8.0), // Add margin on all sides
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                productData.thumbnail ?? "",
                                height: 200, // Adjust the height as needed
                                width: 200, // Adjust the width as needed
                                // fit: BoxFit.cover,
                              ),
                              SizedBox(
                                  height:
                                      8.0), // Add spacing between image and text
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
                    // Customize the properties of your Container as needed
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: _BlackContainer(context)),
              ],
            );
          }
        },
      );
    });
  }
}

Widget _BlackContainer(context) {
  TextEditingController textarea = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  return Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width / 6,
        color: Colors.black,
        child: Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
              Text(
                'Delta',
                style: GoogleFonts.pacifico(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 122, 102, 54),
                    fontSize: 35,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "About Us\n",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Contact Us\n",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Logout\n",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                  )),
                      ],
                      // ),
                    ),
            )),
      ),
      Container(
        width: MediaQuery.of(context).size.width / 4,
        color: Colors.black,
        child: Expanded(
          // flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address\n',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  'DELTA NATIONALS Baladiya St,\nAlanwar Center P.O.Box: 101447, jiddah 21311\nTel: 0126652671, jiddah -Soudi Arabia\nE-mail : sales@deltanationals.com',
                  style: TextStyle(fontSize: 15,color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                 Text(
                  'Contact Us\n',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text('+91 6238636935',style:TextStyle(color: Colors.white,fontSize: 15),)
              ],
            ),
          ),
        ),
      ),
      Expanded(
          flex: 3,
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Text(
                    'Write To Us',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Row(
                    children: [
                      _TextField("Name", name, context),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 35,
                      ),
                      _TextField("Company Name", companyName, context)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  Row(
                    
                    children: [
                      _TextField("Email", email, context),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 35,
                      ),
                      _TextField('Phone Number', phoneNumber, context)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: textarea,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: "Message",
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Colors.white, // Set border color to white
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                         ElevatedButton(
                        onPressed: () {
                         print(textarea.text);

                        },
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        ),
                      ),
                      
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
    ],
  );
}

Widget _TextField(String hintText, TextEditingController controller, context) {
  return Container(
    width: MediaQuery.of(context).size.width / 5,
    height: 40,
    child: TextFormField(
      controller: controller, // Pass the controller
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: hintText, // Pass the hint text
        hintStyle: TextStyle(
          color: Colors.white,fontSize: 15
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}
