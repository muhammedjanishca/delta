// TODO Implement this library.
// import 'package:flutter/material.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = '${(await getTemporaryDirectory()).path}/$fileName';
  final file = File(path);
  await file.writeAsBytes(bytes, flush: true);
  // Launch the file (you may need to use a package to handle this).
}

getTemporaryDirectory() {
}