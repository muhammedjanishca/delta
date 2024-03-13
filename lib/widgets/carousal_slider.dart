import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

final List<String> sliderGlands = [
  'assets/image/connectors 3 (1).jpg',
  'assets/image/glands 4.png',
  'assets/image/glands 2.png',
];

final List<String> sliderLugs = [
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/canva+2+jansih.png',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/janish+canva+2.png',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/lugs+carousel+1.png',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing_page+images/lugs+1.jpg',
];

final List<String> sliderAccessories = [
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/janishone+canva.png',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/lugs+carousel.png',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/lugs+carousel+2.png',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/lugs+3+(1).jpg',
];

final List<String> sliderConnectors = [
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/crimping+tools+2.jpg',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/lugs.jpg',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/lugs1.jpg',
];

final List<String> sliderTools = [
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/connectors+2.jpg',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/connectors+3+(1).jpg',
  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/product+page+images/images/glands+1.png',
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
      slideTransform: const DefaultTransform(),
      slideIndicator: CircularSlideIndicator(
        indicatorRadius: 0,
        currentIndicatorColor: Colors.transparent,
        indicatorBackgroundColor: Colors.black12,
        padding: EdgeInsets.only(bottom: 32),
      ),
      itemCount: 3);
}
