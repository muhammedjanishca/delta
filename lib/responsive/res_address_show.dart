import 'package:flutter/material.dart';


class resAddressShow extends StatelessWidget {
  final Widget mobileaddressShow;
  final Widget deskAddressShow;

  const resAddressShow(
      {required this.mobileaddressShow, required this.deskAddressShow});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth < 600) {
        return mobileaddressShow;
      } else {
        return deskAddressShow;
      }
    });
  }
}