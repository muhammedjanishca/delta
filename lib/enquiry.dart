import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:file_selector/file_selector.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/widgets/whatsApp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

class EnquireBox extends StatefulWidget {
  const EnquireBox({super.key});

  @override
  State<EnquireBox> createState() => _EnquireBoxState();
}

class _EnquireBoxState extends State<EnquireBox> {
  CustomFAB whatsapp = CustomFAB();
  final dio = Dio();
  String? selectedFileName;

  void updateSelectedFileName(String? fileName) {
    setState(() {
      selectedFileName = fileName;
    });
  }

  // deskBottomSheett emailjs = deskBottomSheett();
  final emailTextController = TextEditingController();
  final phoneController = TextEditingController();
  final companyNameContoller = TextEditingController();
  final messageController = TextEditingController();
  // bool isLoading = false;
html.File? pickedFile;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return AlertDialog(
        title: Center(
          child: Image.asset(
            'assets/image/Yellow and Brown Modern Apparel Logo (9).png',
            width: 170,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        content: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 1.3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    controller: companyNameContoller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        hintText: "Company Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    controller: emailTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        hintText: "Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        hintText: "Phone (Optional)"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(color: Colors.black12)),
                        hintText: "Message (Optional)"),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 19.0),
                      child: InkWell(
                        onTap: () async {
                          if (kIsWeb) {
                            // Web platform
                            await pickFileWeb(callback: updateSelectedFileName);
                          } else {
                            // Other platforms
                            await pickFile(callback: updateSelectedFileName);
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_file,
                              color: Colors.black,
                              size: 24,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 60),
                            Text(
                              "Attach Quotation",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 25,
                    ),
                    if (selectedFileName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Chip(
                          label: Text(
                            selectedFileName!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor:
                              Colors.white, // Customize the color as needed
                          onDeleted: () {
                            setState(() {
                              selectedFileName=null;
                              // Reset any other related data or UI elements
                            });
                          },
                          deleteIcon: Icon(Icons.close),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 56,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5.5,
                        ),
                        TextButton(
                            onPressed: () async {
                              if (emailTextController.text.isEmpty ||
                                  companyNameContoller.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Company Name and Email is Required ")));
                              } else {
                                value.changeIsLoading();
                                // await pickFileWeb(
                                //     callback: updateSelectedFileName);
                                // Make sure selectedFileName is updated before uploading
                                await uploadData();
                                value.changeIsLoading();
                              }
                            },
                            child: value.isLoading
                                ? SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2,
                                    ))
                                : Text(
                                    "Submit",
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black))),
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(MediaQuery.of(context).size.width / 2.5,
                                    MediaQuery.of(context).size.width / 8),
                              ),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 17,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black))),
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(MediaQuery.of(context).size.width / 9,
                                    MediaQuery.of(context).size.width / 8),
                              ),
                            ),
                            onPressed: () {
                              whatsapp.launchWhatsApp();
                            },
                            child: Text(
                              'WhatsApp Us',
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> pickFile({required Function(String?) callback}) async {
    final typeGroup = XTypeGroup(
      label: 'quotations',
      extensions: ['pdf'],
    );

    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file != null) {
      setState(() {
        selectedFileName = file.name;
      });
      callback(file.name);
    }
  }

Future<List<int>> _readFileAsBytes(html.File file) async {
  final reader = html.FileReader();
  final completer = Completer<List<int>>();

  reader.onLoadEnd.listen((_) {
    // Extract base64 data from the data URL
    final dataUrl = reader.result as String;
    final base64Data = dataUrl.split(',').last;
    
    // Decode base64 to bytes
    final List<int> fileBytes = base64.decode(base64Data);

    completer.complete(fileBytes);
  });

  reader.onError.listen((dynamic error) {
    completer.completeError('Error reading file: $error');
  });

  reader.readAsDataUrl(file);
  await completer.future;

  return completer.future;
}


Future<void> pickFileWeb({required Function(String?) callback}) async {
  final html.FileUploadInputElement input = html.FileUploadInputElement()
    ..accept = 'application/pdf'; // Set the accept attribute for PDF files
  input.click();
  await input.onChange.first;
  pickedFile = input.files!.first; // Store the picked file
  final file = pickedFile;

  if (file != null) {
    setState(() {
      selectedFileName = file.name;
    });

    // Read file content as Uint8List
    final List<int> fileBytes = await _readFileAsBytes(file);
    print('File Bytes Length: ${fileBytes.length}');
    callback(file.name);
  }
}

  Future<void> uploadData() async {
    try {
      if (selectedFileName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please pick a file before uploading.")));
        print('Please pick a file before uploading.');
        return;
      }
      final html.File file = pickedFile!;

    // Read file content as Uint8List
    final List<int> fileBytes = await _readFileAsBytes(file);
    print('File Bytes Length in API: ${fileBytes.length}');
      FormData formData = FormData.fromMap({
        'email': emailTextController.text,
        'phone': phoneController.text,
        'name': companyNameContoller.text,
        'message': messageController.text,
        'attachment': MultipartFile.fromBytes(
          fileBytes,
          filename: selectedFileName!,
          contentType: MediaType('application', 'pdf'),
        ),
      });

      var response = await dio.post(
        'https://deltabackend.com/enquiry/sendmail',
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Upload successful');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 50.0,
              ),
              content: Text(
                  'Your enquiry has been recived\nYou will receive the reply within 48 hours.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Upload failed with status ${response.statusCode}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Icon(
                Icons.close_outlined,
                color: Colors.red,
                size: 50.0,
              ),
              content: Text(
                  'Your enquiry has not been received\nCheck you Network Connection'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error during upload: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Icon(
              Icons.close_outlined,
              color: Colors.red,
              size: 50.0,
            ),
            content: Text(
                'Unknown Error Occured\nKindly Check Your Network and other Connections'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}