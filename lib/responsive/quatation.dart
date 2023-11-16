import 'package:flutter/material.dart';

class ResQuotation extends StatelessWidget {
  final Widget mobileQuatation;
  final Widget deskQuatation;

  const ResQuotation(
      {required this.mobileQuatation, required this.deskQuatation});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth < 600) {
        return mobileQuatation;
      } else {
        return deskQuatation;
      }
    });
  }
}