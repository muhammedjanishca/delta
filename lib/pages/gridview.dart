// import 'package:flutter/material.dart';
// class GridViewItem extends StatelessWidget {
//   final String thumbnailUrl;
//   final String productName;

//   GridViewItem({required this.thumbnailUrl, required this.productName});

//   @override
//   Widget build(BuildContext context) {
//     // Check the screen width to determine the number of columns.
//     double screenWidth = MediaQuery.of(context).size.width;
//     int crossAxisCount = (screenWidth > 700) ? 3 : 2; // Adjust the breakpoint as needed.

//     return Column(
//       children: [
//         Image.network(
//           thumbnailUrl,
//           width: 270, // Set the desired width for the image
//           height: 270, // Set the desired height for the image
//           fit: BoxFit.cover, // You can adjust the fit as needed
//         ),
//         SizedBox(height: 10), // Add spacing between the image and text
//         Text(
//           productName,
//           style: TextStyle(
//             fontSize: 15, // Adjust the font size of the product name
//           ),
//         ),
//       ],
//     );
//   }
// }