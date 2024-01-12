import 'dart:convert';
import 'package:firebase_hex/pages/another_pages/contact_us.dart';
import 'package:firebase_hex/widgets/customtextfield.dart';
import 'package:firebase_hex/responsive/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
      } else {}
    }

    return FittedBox(
      child: Container(
        // width: double.infinity,
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Padding(
                padding: EdgeInsets.only(left: 70, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(35),
                    Text("Abdullah Shaher Alsulami Est.",
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 251, 236, 221),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                    FittedBox(
                      child: Container(
                        child: Text(
                          "Trans Delta Trading",
                          style: GoogleFonts.barlow(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'TRADING, CONTRACTING, ELECRICAL MATERIALS & MECHANICAL SUPPLIES',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                    Gap(25),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUsPage()),
                          );
                        },
                        child: Text("Contact Us",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ))),
                    Gap(10),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUsPage()),
                          );
                        },
                        child: Text("About Us",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ))),
                    Gap(10),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUsPage()),
                          );
                        },
                        child: Text("Tel # +91 483-3589627",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            )))
                  ],
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Padding(
                  padding: const EdgeInsets.only(right:40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(25),
                      Text(
                        "Message us",
                        style: GoogleFonts.almarai(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: const Color.fromARGB(255, 233, 233, 233)),
                      ),
                      Gap(15),
                      // Text(
                      //   "We'll get back to you within 24 hours",
                      // ),
                      // Gap(25),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text('Name',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              subtitle: TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null; // Return null if the input is valid
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  hintText: '  Name',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Company Name',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              subtitle: TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: companyNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null; // Return null if the input is valid
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.yellow,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2)),
                                    hintText: '  Company Name',
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text('Email',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              subtitle: TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  if (!isValidEmail(value)) {
                                    return 'Please enter the valid email Id';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  hintText: '  Email',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Phone Number',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              subtitle: TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: phoneNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  if (!isValidPhoneNumber(value)) {
                                    return 'Please enter the valid phone number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2)),
                                    hintText: '  +966501234567',
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        title: Text(
                          'Message',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        subtitle: TextFormField(
                          controller: messageController,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(color: Colors.white),
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: "Message",
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
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
                      ),
                      Gap(15),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height / 25,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              sendEmail(
                                  nameController.text,
                                  emailController.text,
                                  companyNameController.text,
                                  phoneNumberController.text,
                                  messageController.text);
                              
                              showDialog(
                                barrierColor: Colors.black.withOpacity(0.1),
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            color: Colors.transparent,
                                            height: 150,
                                            child: Lottie.asset(
                                                "assets/image/Animation - 1703239746007.json"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.of(context).pop();
                              });
                            }
                          },
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 189, 188, 188)),
                            minimumSize:
                                MaterialStateProperty.all(Size(150, 50)),
                          ),
                        ),
                      ),
                      Gap(25)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
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
        // print(name);
        // print(email);
        // print(company);
        // print(phone);
        // print(message);
        // print('Your mail is sent!');
      } else {
        print('Oops... ${response.body}');
      }
    }

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Abdullah Shaher Alsulami Est.",
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 251, 236, 221),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Text(
                    "Trans Delta Trading",
                    style: GoogleFonts.barlow(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    'TRADING, CONTRACTING, ELECRICAL MATERIALS & MECHANICAL SUPPLIES',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  Gap(25),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsPage()),
                        );
                      },
                      child: Text("Contact Us",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ))),
                  Gap(10),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsPage()),
                        );
                      },
                      child: Text("About Us",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ))),
                  Gap(10),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsPage()),
                        );
                      },
                      child: Text("Tel # +91 483-3589627",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )))
                ],
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
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
                      "Message us",
                      style: GoogleFonts.almarai(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: const Color.fromARGB(255, 233, 233, 233)),
                    ),
                    Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text('Name',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            subtitle: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                return null; // Return null if the input is valid
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                hintText: '  Name',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Company Name',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            subtitle: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: companyNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                return null; // Return null if the input is valid
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.yellow,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  hintText: '  Company Name',
                                  hintStyle: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text('Email',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            subtitle: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                if (!isValidEmail(value)) {
                                  return 'Please enter the valid email Id';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                hintText: '  Email',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Phone Number',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            subtitle: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: phoneNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                if (!isValidPhoneNumber(value)) {
                                  return 'Please enter the valid phone number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  hintText: '  +966501234567',
                                  hintStyle: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    ListTile(
                      title: Text(
                        'Message',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      subtitle: TextFormField(
                        controller: messageController,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(color: Colors.white),
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintText: "Message",
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*This field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            sendEmail(
                                nameController.text,
                                emailController.text,
                                companyNameController.text,
                                phoneNumberController.text,
                                messageController.text);
                            showDialog(
                              barrierColor: Colors.black.withOpacity(0.1),
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Colors.transparent,
                                          height: 150,
                                          child: Lottie.asset(
                                              "assets/image/Animation - 1703239746007.json"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                          }
                        },
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        ),
                      ),
                    ),
                    Gap(35)
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
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }
}
