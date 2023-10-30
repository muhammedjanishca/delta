import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/customtextfield.dart';
import 'package:firebase_hex/responsive/bottomsheet.dart';
import 'package:firebase_hex/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../login_and_signing/authentication.dart';

class BottomSheet extends StatelessWidget {
  const BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBottomSheet(
        mobileBottomSheet: deskBottomSheett(),
        deskBottomSheet: mobiledeskBottomSheett());
  }
}

class deskBottomSheett extends StatelessWidget {
  const deskBottomSheett({super.key});

  // bool hover = true;
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthenticationHelper>(context).getCurrentUser();
    var user = Provider.of<AuthenticationHelper>(context).user;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final messageController = TextEditingController();
    final companyNameController = TextEditingController();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();
    // bool _validate = false;
    Future<void> sendEmail(String name, String email, String company,
        String phone, String message) async {
      final apiUrl = 'https://api.emailjs.com/api/v1.0/email/send';

      // Replace these values with your actual service, template, and user IDs
      final serviceId = 'service_54jno8o';
      final templateId = 'template_leg6o7l';
      final userId = 'pyy8mA7J7LWSzgAMF';

      final data = {
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'name': name,
          'email': email,
          'company': company,
          'phone': phone,
          'message': message,
        },
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        // Email sent successfully
        print(name);
        print(email);
        print(company);
        print(phone);
        print(message);
        print('Your mail is sent!');
      } else {
        print('Oops... ${response.body}');
      }
    }

    return Container(
      color: Colors.black,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Padding(
              padding: EdgeInsets.only(left: 70, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Abdullah Shaher Alsulami Est.",
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 251, 236, 221),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Row(
                    children: [
                      Text("DELTA",style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),),
             
                      Text(
                        "\nNATIONAL",
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 251, 236, 221),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'TRADING & CONTRACTING, ELECRICAL & MAECHANICAL SUPPLIES',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.7,
              // color:janishcolor,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Text(
                      'Write To Us',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Row(
                      children: [
                        CustTextField('Name', nameController, context, (value) {
                          if (value == null || value.isEmpty) {
                            return '*This field cannot be empty';
                          }
                          return null;
                        }),
                        // _TextField("C", name, context),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 35,
                        ),
                        CustTextField(
                            "Company Name", companyNameController, context,
                            (value) {
                          if (value == null || value.isEmpty) {
                            return '*This field cannot be empty';
                          }
                          return null;
                        }),
                        // _TextField("Company Name", companyName, context)
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Row(
                      children: [
                       CustTextField(
                    'Email',
                    emailController,
                    context,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      if (!isValidEmail(value)) {
                        return 'Please enter the valid email Id';
                      }
                      return null;
                    },
                  ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 35,
                        ),
                        CustTextField(
                    'Phone Number',
                    phoneNumberController,
                    context,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      if (!isValidPhoneNumber(value)) {
                        return 'Please enter the valid phone number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: messageController,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(color: Colors.white),
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintText: "Message",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .white, // Set border color to white
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*This field cannot be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // All text fields are valid, you can perform your action here
                                // sendEmail(
                                //     nameController.text,
                                //     emailController.text,
                                //     companyNameController.text,
                                //     phoneNumberController.text,
                                //     messageController.text);
                              }
                            },
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize:
                                  MaterialStateProperty.all(Size(150, 50)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

   bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }
}

//----------mobile------------------

class mobiledeskBottomSheett extends StatefulWidget {
  const mobiledeskBottomSheett({super.key});

  @override
  State<mobiledeskBottomSheett> createState() => _mobiledeskBottomSheettState();
}

class _mobiledeskBottomSheettState extends State<mobiledeskBottomSheett> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final messageController = TextEditingController();
    final companyNameController = TextEditingController();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 70, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Abdullah Shaher Alsulami Est.",
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 251, 236, 221),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Row(
                    children: [
                         Text("DELTA",style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),),
             
                      Text(
                        "\nNATIONAL",
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 251, 236, 221),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'TRADING & CONTRACTING, ELECRICAL & MAECHANICAL SUPPLIES\n\n\n\n',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  // Text(
                  //   'DELTA NATIONALS Baladiya St,\nAlanwar Center P.O.Box: 101447, jiddah 21311\nTel: 0126652671, jiddah -Soudi Arabia\nE-mail : sales@deltanationals.com',
                  //   style: TextStyle(fontSize: 15, color: Colors.white),
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 20,
                  // ),
                  // Text(
                  //   'Contact Us\n',
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20),
                  // ),
                  // user != null
                  //   ? TextButton(
                  //       onPressed: () {
                  //         showDialog(
                  //           context: context,
                  //           builder: (context) {
                  //             return AlertDialog(
                  //               title: Text("Are you sure to logout?"),
                  //               // content: Text("This is my message."),
                  //               actions: [
                  //                 TextButton(
                  //                     onPressed: () {
                  //                       Navigator.pop(context);
                  //                     },
                  //                     child: Text('Cancel')),
                  //                 TextButton(
                  //                     onPressed: () {
                  //                       FirebaseAuth.instance.signOut();
                  //                       // Navigator.pop(context);

                  //                       Navigator.pushNamed(context, '/');
                  //                     },
                  //                     child: Text('Yes'))
                  //               ],
                  //             );
                  //           },
                  //         );
                  //         // FirebaseAuth.instance.signOut();
                  //       },
                  //       child: Text(
                  //         'Logout',
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.white),
                  //       ))
                  //   : SizedBox(),
                ],
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
              // color: janishcolor,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Text(
                      'Write To Us',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: _width / 2.3,
                          child: CustTextField(
                            'Name',
                            nameController,
                            context,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return '*This field cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 35,
                        ),
                        SizedBox(
                            width: _width / 2.3,
                            child: CustTextField(
                              'Company Name',
                              companyNameController,
                              context,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return '*This field cannot be empty';
                                }
                                return null;
                              },
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: _width / 2.3,
                          child: CustTextField(
                            'Email',
                            emailController,
                            context,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return '*This field cannot be empty';
                              }
                                if (!isValidEmail(value)) {
                        return 'Please enter the valid email Id';
                      }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 35,
                        ),
                        SizedBox(
                          width: _width / 2.3,
                          child: CustTextField(
                            'Phone Number',
                            phoneNumberController,
                            context,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return '*This field cannot be empty';
                              }
                               if (!isValidPhoneNumber(value)) {
                        return 'Please enter the valid phone number';
                      }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: messageController,
                            keyboardType: TextInputType.multiline,
                         
                            style: TextStyle(color: Colors.white),
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintText: "Message",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .white, // Set border color to white
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2))),
                         validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 25,
                          ),
                          ElevatedButton(
                            onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // All text fields are valid, you can perform your action here
                          // sendEmail(
                          //     nameController.text,
                          //     emailController.text,
                          //     companyNameController.text,
                          //     phoneNumberController.text,
                          //     messageController.text);
                        }
                            },
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize:
                                  MaterialStateProperty.all(Size(150, 50)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
   bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }
}
