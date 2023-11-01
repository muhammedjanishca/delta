import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> sliderGlands = [
  'https://images.ctfassets.net/uwf0n1j71a7j/5LwYMgxLPveA0Q2l4RADnb/9e87fcfb4974fe0ecbfdf99a520948f3/personal-belonging-electronic-equipment-bike-insurance-add-on.webp',
  'https://media.baumpub.com/files/slides/locale_image/full/0225/56065_en_59ed0_58276_bobcat-e10e-electric-excavator1.jpg',
  'https://www.hitachi.com/rev/archive/2020/r2020_02/02a06/image/fig_01.jpg',
];
final List<String> sliderlugs = [
  'https://images.ctfassets.net/uwf0n1j71a7j/5LwYMgxLPveA0Q2l4RADnb/9e87fcfb4974fe0ecbfdf99a520948f3/personal-belonging-electronic-equipment-bike-insurance-add-on.webp',
  'https://media.baumpub.com/files/slides/locale_image/full/0225/56065_en_59ed0_58276_bobcat-e10e-electric-excavator1.jpg',
  'https://www.hitachi.com/rev/archive/2020/r2020_02/02a06/image/fig_01.jpg',
];
final List<String> slideraccessories = [
  'https://images.ctfassets.net/uwf0n1j71a7j/5LwYMgxLPveA0Q2l4RADnb/9e87fcfb4974fe0ecbfdf99a520948f3/personal-belonging-electronic-equipment-bike-insurance-add-on.webp',
  'https://media.baumpub.com/files/slides/locale_image/full/0225/56065_en_59ed0_58276_bobcat-e10e-electric-excavator1.jpg',
  'https://www.hitachi.com/rev/archive/2020/r2020_02/02a06/image/fig_01.jpg',
];
final List<String> slidercrimping = [
  'https://images.ctfassets.net/uwf0n1j71a7j/5LwYMgxLPveA0Q2l4RADnb/9e87fcfb4974fe0ecbfdf99a520948f3/personal-belonging-electronic-equipment-bike-insurance-add-on.webp',
  'https://media.baumpub.com/files/slides/locale_image/full/0225/56065_en_59ed0_58276_bobcat-e10e-electric-excavator1.jpg',
  'https://www.hitachi.com/rev/archive/2020/r2020_02/02a06/image/fig_01.jpg',
];
final List<String> sliderconnecters = [
  'https://images.ctfassets.net/uwf0n1j71a7j/5LwYMgxLPveA0Q2l4RADnb/9e87fcfb4974fe0ecbfdf99a520948f3/personal-belonging-electronic-equipment-bike-insurance-add-on.webp',
  'https://media.baumpub.com/files/slides/locale_image/full/0225/56065_en_59ed0_58276_bobcat-e10e-electric-excavator1.jpg',
  'https://www.hitachi.com/rev/archive/2020/r2020_02/02a06/image/fig_01.jpg',
];
// final List<String> sliderHeadings = [
//   'Gain total control \nof your money',
//   'Know where your \nmoney goes',
//   'Planning ahead'
// ];
// final List<String> sliderDescription = [
//   'Become your own money manager \nand make every cent count',
//   'Track your transaction easily,\nwith categories and financial report',
//   'Setup your budget for each category \nso you in control'
// ];

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
