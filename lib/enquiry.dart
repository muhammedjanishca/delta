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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

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

  final FocusNode _name = FocusNode();
  final FocusNode _email = FocusNode();
  final FocusNode _phone = FocusNode();
  final FocusNode _msg = FocusNode();
  final FocusNode _attach = FocusNode();
  final FocusNode _enter = FocusNode();

  // bool isLoading = false;
  html.File? pickedFile;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return AlertDialog(
        title: Center(
          child: Image.network(
            'https://deltabuckets.s3.ap-south-1.amazonaws.com/tdt+logos/TDT+-01.png',
            width: 170,
            height: 100,
            // fit: BoxFit.cover,
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
                    focusNode: _name,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_email);
                    },
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
                        hintText: "Company Name",hintStyle: GoogleFonts.poppins()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    focusNode: _email,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_phone);
                    },
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
                        hintText: "Email",hintStyle: GoogleFonts.poppins()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    focusNode: _phone,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_msg);
                    },
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
                        hintText: "Phone (Optional)",hintStyle: GoogleFonts.poppins()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    focusNode: _msg,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_attach);
                    },
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
                        hintText: "Message (Optional)",hintStyle: GoogleFonts.poppins()),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: InkWell(
                        focusNode: _attach,
                        onTap: () async {
                          if (kIsWeb) {
                            // Web platform
                            await pickFileWeb(callback: updateSelectedFileName);
                          } else {
                            // Other platforms
                            await pickFile(callback: updateSelectedFileName);
                            (value) {
                            };
                          }
                        },
                        child: Text(""),
                       
                      ),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width / 25,
                    // ),
                    if (selectedFileName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Chip(
                          label: Text(
                            selectedFileName!,
                            style: GoogleFonts.poppins(
                              color: Colors.black54,
                              // fontSize: 16,
                            ),
                          ),
                          backgroundColor:
                              Colors.white, // Customize the color as needed
                          onDeleted: () {
                            setState(() {
                              selectedFileName = null;
                              // Reset any other related data or UI elements
                            });
                          },
                          deleteIcon: Icon(Icons.close, color: Theme.of(context).dividerColor,),
                        ),
                      ),
                  ],
                ),
                
                
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (kIsWeb) {
                          // Web platform
                          await pickFileWeb(
                              callback: updateSelectedFileName);
                        } else {
                          // Other platforms
                          await pickFile(
                              callback: updateSelectedFileName);
                        }
                      },
                      child:  Row(
                        // crossAxisAlignment: CrossAxisAlignment.,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.attach_file,
                                // color: Colors.black26,
                                 color: Theme.of(context).dividerColor,
                               
                              ),
                               Gap(5),
                           Text(
                            "Attach Quotation",
                            style: GoogleFonts.poppins(
                              color: Colors.black54,
                             
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                            ],
                          ),
                          FloatingActionButton(
                        onPressed: () {
                          whatsapp.launchWhatsApp();
                        },
                        tooltip: 'Open WhatsApp',
                        child: FaIcon(FontAwesomeIcons.whatsapp),
                        backgroundColor: Color.fromARGB(255, 16, 229, 23)),
                         
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width / 25,
                    // ),
                    // if (selectedFileName != null)
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 8.0),
                    //     child: Chip(
                    //       label: Text(
                    //         selectedFileName!,
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //       backgroundColor:
                    //           Colors.white, // Customize the color as needed
                    //       onDeleted: () {
                    //         setState(() {
                    //           selectedFileName = null;
                    //           // Reset any other related data or UI elements
                    //         });
                    //       },
                    //       deleteIcon: Icon(Icons.close),
                    //     ),
                    //   ),

                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width / 5.5,
                    // ),
                    ElevatedButton(
                      focusNode: _enter,
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
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        minimumSize:
                            MaterialStateProperty.all(const Size(300, 50)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7.5,
                    ),
                    // TextButton(
                    //     onPressed: () async {
                    //       if (emailTextController.text.isEmpty ||
                    //           companyNameContoller.text.isEmpty) {
                    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //             content: Text(
                    //                 "Company Name and Email is Required ")));
                    //       } else {
                    //         value.changeIsLoading();
                    //         // await pickFileWeb(
                    //         //     callback: updateSelectedFileName);
                    //         // Make sure selectedFileName is updated before uploading
                    //         await uploadData();y
                    //         value.changeIsLoading();
                    //       }
                    //     },
                    //     child: value.isLoading
                    //         ? SizedBox(
                    //             width: 25,
                    //             height: 25,
                    //             child: CircularProgressIndicator(
                    //               color: Colors.black,
                    //               strokeWidth: 2,
                    //             ))
                    //         : Text(
                    //             "Submit",
                    //             style: GoogleFonts.inter(
                    //               color: Colors.black,
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //     style: ButtonStyle(
                    //       shape: MaterialStateProperty.all<
                    //               RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(18.0),
                    //               side: BorderSide(color: Colors.black))),
                    //       minimumSize: MaterialStateProperty.all<Size>(
                    //         Size(MediaQuery.of(context).size.width / 2.5,
                    //             MediaQuery.of(context).size.width / 8),
                    //       ),
                    //     )),

                    // FloatingActionButton(
                    //     onPressed: () {
                    //       whatsapp.launchWhatsApp();
                    //     },
                    //     tooltip: 'Open WhatsApp',
                    //     child: FaIcon(FontAwesomeIcons.whatsapp),
                    //     backgroundColor: Color.fromARGB(255, 16, 229, 23)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7.5,
                    ),
                    // ElevatedButton(
                    //     style: ButtonStyle(
                    //       backgroundColor: MaterialStateProperty.all<Color>(
                    //           Colors.green),
                    //       shape: MaterialStateProperty.all<
                    //               RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(18.0),
                    //               side: BorderSide(color: Colors.black))),
                    //       minimumSize: MaterialStateProperty.all<Size>(
                    //         Size(MediaQuery.of(context).size.width / 9,
                    //             MediaQuery.of(context).size.width / 8),
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //       whatsapp.launchWhatsApp();
                    //     },
                    //     child: Text(
                    //       'WhatsApp Us',
                    //       style: TextStyle(color: Colors.black),
                    //     ))
                  ],
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
      // print('File Bytes Length: ${fileBytes.length}');
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
      // print('File Bytes Length in API: ${fileBytes.length}');
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
        '$appBaseUrl/enquiry/sendmail',
        data: formData,
      );

      if (response.statusCode == 200) {
        // print('Upload successful');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Icon(
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
