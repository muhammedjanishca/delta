import 'package:flutter/material.dart';

class ResAddressShow extends StatelessWidget {
  final Widget mobileaddressShow;
  final Widget deskAddressShow;

  const ResAddressShow(
      {required this.mobileaddressShow, required this.deskAddressShow});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth < 800) {
        return mobileaddressShow;
      } else {
        return deskAddressShow;
      }
    });
  }
}
