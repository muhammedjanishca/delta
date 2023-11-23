// import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/widgets/fetch_invoice.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  Services services = await fetchServices();
  // Save the PDF file to a temporary file
  final path = '${(await getTemporaryDirectory()).path}/$fileName';
  final file = File(path);
  await file.writeAsBytes(bytes, flush: true);

  // Upload the PDF file to Firebase Storage

  final uint8List = Uint8List.fromList(bytes);
  final storageRef = FirebaseStorage.instance.ref().child('invoices/$fileName');
  await storageRef.putData(uint8List);

  // Get the download URL for the uploaded PDF file
  final downloadUrl = await storageRef.getDownloadURL();

  // Store the download URL in Firestore using the invoice ID as the document name
  final docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('store_invoice')
      .doc('${services.invoiceNumber}');
  await docRef.set({
    'downloadURL': downloadUrl,
  });

  // Launch the file (you may need to use a package to handle this).
}

getTemporaryDirectory() {}
