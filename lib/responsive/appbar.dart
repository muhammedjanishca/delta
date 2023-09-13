import 'package:flutter/material.dart';


class ResponsiveAppBar extends StatelessWidget {
  final Widget mobileAppBar;
  final Widget desktopAppBar;

  const ResponsiveAppBar(
      {required this.mobileAppBar, required this.desktopAppBar});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth < 600) {
        return mobileAppBar;
      } else {
        return desktopAppBar;
      }
    });
  }
}