import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> sliderGlands = [
  'https://www.cubanolugs.com/image/1.jpg',
  // 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fknowhow.distrelec.com%2Frnd%2Fthe-ultimate-guide-to-cable-glands-installation-types-and-maintenance%2F&psig=AOvVaw13uhZYypELABSBvMnfth5-&ust=1700547650553000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPicw-X30YIDFQAAAAAdAAAAABAK'
  'https://etechcomponents.com/wp-content/uploads/2018/06/new-pic1.jpg',
  'https://www.metalcablegland.com/wp-content/uploads/2019/03/double-compression-cable-gland-parts.png',
  'https://etechcomponents.com/wp-content/uploads/2018/06/new-pic1.jpg',
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
            // SizedBox(
            // width: MediaQuery.of(context).size.width / 1.2,
            // Column(
            // children: [
            //   Text(
            //     sliderHeadings[index],
            //     style: GoogleFonts.inter(
            //         fontSize: 32, fontWeight: FontWeight.w700),
            //     textAlign: TextAlign.center,
            //   ),
            //   Text(sliderDescription[index],
            //       style: GoogleFonts.inter(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500,
            //           color: Colors.grey),
            //       textAlign: TextAlign.center),
            // ],
            // ),
            // )
          ],
        );
      },
      // DefaultTransform(),
      // BackgroundToForegroundTransform(),
      slideTransform: DefaultTransform(),
      slideIndicator: CircularSlideIndicator(
        indicatorRadius: 0,
        currentIndicatorColor: Colors.transparent,
        indicatorBackgroundColor: Colors.black12,
        padding: EdgeInsets.only(bottom: 32),
      ),
      itemCount: 3);
}
