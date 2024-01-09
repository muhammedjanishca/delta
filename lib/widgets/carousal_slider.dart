import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> sliderGlands = [
 'assets/image/connectors 3 (1).jpg',
 'assets/image/glands 4.png',
 'assets/image/glands 2.png'
];
final List<String> sliderLugs = [
  'assets/image/lugs 1.jpg'
  'assets/image/lugs 3 (1).jpg'
  'assets/image/lugs 6 (1).jpg'
 ];
final List<String> sliderAccessories = [
 'assets/image/accessories 3.jpg',
 'assets/image/accessories 2.jpg',
 'assets/image/accessories 1.jpg' 
];
final List<String> sliderConnectors = [
  'assets/image/connectors 3 (1).jpg'
  'assets/image/connectors 2.jpg'
  'assets/image/Cable connectors.jpg'
 
];
final List<String> sliderTools = [
  'assets/image/crimping tools 3.jpg',
  'assets/image/crimping tools 4.jpg',
  'assets/image/crimping tools 2.jpg'
];





CarouselSlider custCarosal(BuildContext context, List<String> janish, index) {
  return CarouselSlider.builder(
      enableAutoSlider: true,
      unlimitedMode: true,
      slideBuilder: (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              width: double.infinity,
              child: Image.network(
                janish[index],
                fit: BoxFit.cover,

                // height: 500,
              ),
            ),
           
          ],
        );
      },
      
      slideTransform: DefaultTransform(),
      slideIndicator: CircularSlideIndicator(
        indicatorRadius: 0,
        currentIndicatorColor: Colors.transparent,
        indicatorBackgroundColor: Colors.black12,
        padding: EdgeInsets.only(bottom: 32),
      ),
      itemCount: 3);
}
