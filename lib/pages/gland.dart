import 'package:firebase_hex/provider/data_provider.dart';
import 'package:flutter/material.dart';
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

               navigateToProductDetailsOfGlands(context, index);
            },
                    child: Container(
                      
                      color:Colors.white,
                     
                      padding: EdgeInsets.all(8.0), // Add spacing on all sides
                      margin: EdgeInsets.all(8.0), // Add margin on all sides
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            productData.thumbnail??"",
                            height: 200, // Adjust the height as needed
                            width: 200, // Adjust the width as needed
                            // fit: BoxFit.cover,
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