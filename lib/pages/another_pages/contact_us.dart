import 'dart:convert';
import 'dart:js';
import 'package:firebase_hex/main.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_hex/pages/another_pages/IRSH.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';

import '../../widgets/style.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({Key? key});

  void showAlert(context) {
    QuickAlert.show(
        context: context,
        title: 'Message',
        text: "Your message has been sent successfully.",
        confirmBtnColor: Colors.black,
        type: QuickAlertType.success);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final firstname = TextEditingController();
    final companyname = TextEditingController();
    final email = TextEditingController();
    final phone = TextEditingController();
    final message = TextEditingController();
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
        // print('Oops... ${response.body}');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MediaQuery.of(context).size.width < 650
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            )
          : custSmallAppBar(context, Colors.white),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Get in touch",
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                    fontSize: 40, fontWeight: FontWeight.w900),
              ),
              Text(
                "We are here to help!", style: GoogleFonts.poppins(
                    ),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.9,
                  width: double.infinity,
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Gap(10),
                          FittedBox(
                            child: ContactContaineru(
                              title: 'Chat to sales',
                              icon: Icons.chat_bubble_rounded,
                              content: 'Speak to our friendly team.',
                              onPressed: () {
                                // navigateToProductDetailsofLugs(context, selectedProductIndex);
                              },
                              buttonText: 'Chat to sales',
                            ),
                          ),
                          Gap(10),
                          FittedBox(
                            child: ContactContaineru(
                              title: 'Chat to support',
                              icon: Icons.support_agent_outlined,
                              content: "We're here to help.",
                              buttonText: 'Chat to support',
                              onPressed: () {
                                
                              },
                            ),
                          ),
                          Gap(10),
                          FittedBox(
                            child: ContactContaineru(
                              title: 'Visit us',
                              icon: Icons.location_on_outlined,
                              content: 'Visit our office HQ.',
                               buttonText: 'Get direction',
                              onPressed: () {

                              },
                              // containerHeight: 80.0,
                              // containerWidth: 80.0,
                            ),
                          ),
                          Gap(10),
                          FittedBox(
                            child: ContactContaineru(
                              title: 'Call us',
                              icon: Icons.phone,
                              content: 'Mon-fri from 9:30am to 8:00pm,',
                              onPressed: () {},
                              buttonText: 'Call out team',
                            ),
                          ),
                          Gap(10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              LayoutBuilder(builder: (context, Constraints) {
                if (Constraints.maxWidth > 850) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Gap(25),
                          Text(
                            "Message us",
                            style: GoogleFonts.poppins(
                                fontSize: 25, fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "We'll get back to you within 24 hours", style: GoogleFonts.poppins(
     ),
                          ),
                          Gap(25),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text('Name',
                                      style: TextStyle(fontSize: 15)),
                                  subtitle: TextFormField(
                                    controller: firstname,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field cannot be empty';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      hintText: '  Name',
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
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  subtitle: TextFormField(
                                    controller: companyname,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field cannot be empty';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      hintText: '  Company Name',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListTile(
                            title: Text(
                              'Email',
                              style: TextStyle(fontSize: 15),
                            ),
                            subtitle: TextFormField(
                              controller: email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                if (!isValidEmail(value)) {
                                  return 'Please enter the valid email Id';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                hintText: '  Email',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListTile(
                            title: Text(
                              'Phone Number',
                              style: TextStyle(fontSize: 15),
                            ),
                            subtitle: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                if (!isValidPhoneNumber(value)) {
                                  return 'Please enter the valid phone number';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                hintText: '  +966501234567',
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListTile(
                            title: Text(
                              'Message',
                              style: TextStyle(fontSize: 15),
                            ),
                            subtitle: TextFormField(
                              controller: message,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 80, 80, 80)),
                              maxLines: 5,
                              decoration: InputDecoration(
                                  hintText: "Message",
                                  hintStyle: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 151, 151, 151)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color.fromARGB(255, 178, 178,
                                          178), // Set border color to white
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 172, 172, 172),
                                          width: 2))),
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
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // All text fields are valid, you can perform your action here
                                sendEmail(firstname.text, email.text,
                                    companyname.text, phone.text, message.text);

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
                                              child: lottieSuccess()
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
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              minimumSize:
                                  MaterialStateProperty.all(Size(300, 50)),
                            ),
                          ),
                          Gap(25)
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Gap(25),
                            Text(
                              "Message us",
                              style: GoogleFonts.almarai(
                                  fontSize: 25, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "We'll get back to you within 24 hours",
                            ),
                            Gap(25),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text('Name',
                                        style: TextStyle(fontSize: 15)),
                                    subtitle: TextFormField(
                                      controller: firstname,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        hintText: '  Name',
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
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    subtitle: TextFormField(
                                      controller: companyname,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        hintText: '  Company Name',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ListTile(
                              title: Text(
                                'Email',
                                style: TextStyle(fontSize: 15),
                              ),
                              subtitle: TextFormField(
                                controller: email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  if (!isValidEmail(value)) {
                                    return 'Please enter the valid email Id';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  hintText: '  Email',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ListTile(
                              title: Text(
                                'Phone Number',
                                style: TextStyle(fontSize: 15),
                              ),
                              subtitle: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  if (!isValidPhoneNumber(value)) {
                                    return 'Please enter the valid phone number';
                                  }
                                  return null;
                                },
                                // inputFormatters: [
                                // FilteringTextInputFormatter.allow(RegExp(r'^\+?966|05[0-9]?$')),

                                // ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  hintText: '  +966501234567',
                                  prefixIcon: Icon(Icons.phone),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ListTile(
                              title: Text(
                                'Message',
                                style: TextStyle(fontSize: 15),
                              ),
                              subtitle: TextFormField(
                                controller: message,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 80, 80, 80)),
                                maxLines: 5,
                                decoration: InputDecoration(
                                    hintText: "Message",
                                    hintStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 151, 151, 151)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255,
                                            178,
                                            178,
                                            178), // Set border color to white
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 172, 172, 172),
                                            width: 2))),
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
                            ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // All text fields are valid, you can perform your action here
                                sendEmail(firstname.text, email.text,
                                    companyname.text, phone.text, message.text);

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
                                              child:lottieSuccess()
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
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              minimumSize:
                                  MaterialStateProperty.all(Size(300, 50)),
                            ),
                          ),
                            Gap(25)
                          ],
                        ),
                      ),
                    ),
                  );
                }
              })
            ],
          ),
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

class ContactContaineru extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  final String buttonText; // Add this line
  final VoidCallback? onPressed;

  const ContactContaineru({
    required this.title,
    required this.icon,
    required this.content,
    required this.buttonText, // Add this line
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 222,
      width: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: const Color.fromARGB(255, 208, 208, 208)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30),
          Gap(50),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Gap(10),
          Text(content),
          Gap(20),
          TextButton(
            child: Text(
              buttonText.toUpperCase(), // Use the provided buttonText
              style: TextStyle(fontSize: 10),
            ),
            style: ButtonStyle(
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                      color: const Color.fromARGB(255, 208, 208, 208)),
                ),
              ),
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
