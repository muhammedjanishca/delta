import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerificationState with ChangeNotifier {
  int remainingTime = 120;
  bool verificationSuccess = false;

  void startTimer() {
    final Timer timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        timer.cancel();
        if (!verificationSuccess) {
          // Add navigation logic here
        }
      }
      notifyListeners();
    });
  }

  void setVerificationSuccess(bool success) {
    verificationSuccess = success;
    notifyListeners();
  }
}
