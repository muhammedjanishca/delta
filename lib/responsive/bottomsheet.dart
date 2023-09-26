import 'package:flutter/material.dart';


class ResponsiveBottomSheet extends StatelessWidget {
  final Widget mobileBottomSheet;
  final Widget deskBottomSheet;

  const ResponsiveBottomSheet(
      {required this.mobileBottomSheet, required this.deskBottomSheet});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth < 600) {
        return mobileBottomSheet;
      } else {
        return deskBottomSheet;
      }
    });
  }
}