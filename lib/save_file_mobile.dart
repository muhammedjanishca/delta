// import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/widgets/fetch_invoice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  Services services = await fetchServices();
  // Save the PDF file to a temporary file
  final path = '${(await getTemporaryDirectory()).path}/$fileName';
  final file = File(path);
  await file.writeAsBytes(bytes, flush: true);
  // Launch the file (you may need to use a package to handle this).
}

getTemporaryDirectory() {}
