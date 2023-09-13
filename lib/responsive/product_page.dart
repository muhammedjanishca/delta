import 'package:flutter/material.dart';


class ResponsiveProductPage extends StatelessWidget {
  final Widget mobileProductPage;
  final Widget desktopProductPage;

  const ResponsiveProductPage(
      {required this.mobileProductPage, required this.desktopProductPage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth < 600) {
        return mobileProductPage;
      } else {
        return desktopProductPage;
      }
    });
  }
}