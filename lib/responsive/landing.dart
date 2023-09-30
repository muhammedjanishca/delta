import 'package:flutter/material.dart';


class ResponsiveLandingPage extends StatelessWidget {
  final Widget mobileAppBar;
  final Widget desktopAppBar;

  const ResponsiveLandingPage(
      {required this.mobileAppBar, required this.desktopAppBar});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth < 800) {
        return mobileAppBar;
      } else {
        return desktopAppBar;
      }
    });
  }
}