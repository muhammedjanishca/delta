import 'package:flutter/material.dart';


class ResponsiveSignUp extends StatelessWidget {
  final Widget mobileSignUp;
  final Widget desktopSignUp;

  const ResponsiveSignUp(
      {required this.mobileSignUp, required this.desktopSignUp});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth < 600) {
        return mobileSignUp;
      } else {
        return desktopSignUp;
      }
    });
  }
}