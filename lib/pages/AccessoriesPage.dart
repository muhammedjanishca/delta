import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../model.dart';
import '../provider/data_provider.dart';
import '../provider/thumbnail.dart';
import 'gridview.dart';


class AccessoriesPage extends StatefulWidget {
  AccessoriesPage({super.key});

  @override
  State<AccessoriesPage> createState() => _AccessoriesPageState();
}

class _AccessoriesPageState extends State<AccessoriesPage> {
     int selectedImageIndex = -1; // Initialize with an invalid index

  @override
  Widget build(BuildContext context) {
     final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);

    return Consumer(builder: (context, provider, child) {
      return FutureBuilder<ProduceNewModal>(
        future: context.read<DataProvider>().newaccessories,
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
              final products = snapshot.data!.data;
            final nonNullProducts = products.where((product) => product != null).toList();

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Set the number of columns in the grid
                ),
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  var productData = snapshot.data!.data[index];
            
                  return GestureDetector(
            onTap: () {
              // Set the selected thumbnail for this product
              selectedThumbnailProvider.setSelectedThumbnail(
                productData.thumbnail??"",
              );

               navigateToProductDetailsOfAccessories(context, index);
            },
                    child: Container(
                      
                      color:Colors.white,
                     
                      padding: EdgeInsets.all(8.0), // Add spacing on all sides
                      margin: EdgeInsets.all(8.0), // Add margin on all sides
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MouseRegion(
                             onEnter: (_) {
                                  // Handle mouse enter event, e.g., change image size or color
                                  setState(() {
                                    // Update the state to apply hover effect

                                    selectedImageIndex =
                                        index; // Set the selected image index
                                  });
                                },
                                onExit: (_) {
                                  // Handle mouse exit event, e.g., reset image size or color
                                  setState(() {
                                    // Update the state to remove hover effect
                                    selectedImageIndex =
                                        -1; // Reset the selected image index
                                  });
                                },
                            child: AnimatedContainer(     
                                                           duration: Duration(milliseconds: 200),
                                                            height: selectedImageIndex == index
                                      ? 180
                                      : 160, // Expand selected image
                                  width: selectedImageIndex == index
                                      ? MediaQuery.of(context).size.width / 4
                                      : MediaQuery.of(context).size.width / 5,

                          
                              child: Image.network(
                                productData.thumbnail??"",
                                height: 200, // Adjust the height as needed
                                width: 200, // Adjust the width as needed
                                // fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0), // Add spacing between image and text
                          Text(
                            productData.productName??"",style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      );
    });
  }
}