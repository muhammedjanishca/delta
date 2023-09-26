import 'package:flutter/material.dart';


class ResponsiveCart extends StatelessWidget {
  final Widget mobileCart;
  final Widget desktopCart;

  const ResponsiveCart(
      {required this.mobileCart, required this.desktopCart});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth < 600) {
        return mobileCart;
      } else {
        return desktopCart;
      }
    });
  }
}