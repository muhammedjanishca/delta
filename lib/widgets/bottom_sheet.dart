import 'dart:convert';
import 'package:firebase_hex/pages/another_pages/contact_us.dart';
import 'package:firebase_hex/responsive/bottomsheet.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../login_and_signing/authentication.dart';
import '../pages/another_pages/terms&conditions.dart';

class BottomSheet extends StatelessWidget {
  const BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBottomSheet(
        mobileBottomSheet: deskBottomSheett(),
        deskBottomSheet: mobiledeskBottomSheett());
  }
}

launchWhatsApp() async {
  final url = 'https://wa.me/+966555432866'; // Replace with your WhatsApp URL

  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
// linked in navigator

launchLinkedIn() async {
  final url =
      'https://www.linkedin.com/company/transdeltatrading'; // Replace with your WhatsApp URL

  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// faceBook  navigator
launchFaceBook() async {
  final url =
      'https://www.linkedin.com/company/transdeltatrading'; // Replace with your WhatsApp URL

  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// instagram  navigator
launchInstagram() async {
  final url =
      'https://www.linkedin.com/company/transdeltatrading'; // Replace with your WhatsApp URL

  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
 final FocusNode _name = FocusNode();
    final FocusNode _comName = FocusNode();
    final FocusNode _email = FocusNode();
    final FocusNode _msg = FocusNode();
    final FocusNode _phone = FocusNode();
    final FocusNode _enter = FocusNode();

    final messageController = TextEditingController();
    final companyNameController = TextEditingController();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();
class deskBottomSheett extends StatelessWidget {
  const deskBottomSheett({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthenticationHelper>(context).getCurrentUser();
    var user = Provider.of<AuthenticationHelper>(context).user;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
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
        // height: 500,
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Gap(10),
                        SizedBox(
                          // color: colorTwo,
                          height: 70,
                          width: 300,
                          child: Image.network(
                              'https://deltabuckets.s3.ap-south-1.amazonaws.com/tdt+logos/TDT+-04.png'),
                        ),
                        Gap(20),
                        FittedBox(
                          child: SizedBox(
                            child: Row(
                              children: [
                                Gap(15),
                                InkWell(
                                  onTap: launchWhatsApp,
                                  child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Image.network(
                                          'https://totalpng.com//public/uploads/preview/whatsapp-logo-transparent-background-free-download-11666005954eohih1qecz.png')),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      " (+966) 55 543 2866",
                                      style: GoogleFonts.hind(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                Gap(70)
                              ],
                            ),
                          ),
                        ),
                        Gap(30),
                        FittedBox(
                          child: SizedBox(
                            // color: colorTwo,
                            child: Row(
                              children: [
                                const Gap(20),
                                InkWell(
                                  onTap: launchFaceBook,
                                  child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Image.network(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOXBReqjlDclmsacRsAv17iUNNaedscnr3YQ&usqp=CAU')),
                                ),
                                const Gap(30),
                                InkWell(
                                  onTap: launchLinkedIn,
                                  child: Container(
                                      color: Colors.white,
                                      width: 30,
                                      height: 30,
                                      child: Image.network(
                                          'https://www.freepnglogos.com/uploads/linkedin-logo-black-png-image-21.png')),
                                ),
                                const Gap(30),
                                InkWell(
                                  onTap: launchWhatsApp,
                                  child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Image.network(
                                          'https://www.pagetraffic.com/blog/wp-content/uploads/2022/06/white-instagram-logo-png-transparent.png')),
                                ),
                                const Gap(130)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Gap(170),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUsPage()),
                              );
                            },
                            child: Text("Contact Us",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ))),
                        const Gap(20),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUsPage()),
                              );
                            },
                            child: Text("About Us",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ))),
                        Gap(20),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TermsAndConditionsPage()),
                              );
                            },
                            child: Text("Terms & Conditions",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ))),
                        Gap(20),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUsPage()),
                              );
                            },
                            child: Text("sales@transdeltatrading.com",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(25),
                      Text(
                        "Message us",
                        style: GoogleFonts.almarai(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: const Color.fromARGB(255, 233, 233, 233)),
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text('Name',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white)),
                              subtitle: TextFormField(
                                focusNode: _name,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_comName);
                                },
                                style: GoogleFonts.poppins(color: Colors.white),
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.2)),
                                  hintText: '  Name',
                                  hintStyle: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 227, 226, 226),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Company Name',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              subtitle: TextFormField(
                                focusNode: _comName,
                                style: GoogleFonts.poppins(color: Colors.white),
                                controller: companyNameController,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_email);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.yellow,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 0.2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 0.2)),
                                    hintText: '  Company Name',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 227, 226, 226),
                                    )),
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
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.white)),
                              subtitle: TextFormField(
                                focusNode: _email,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_phone);
                                },
                                style: GoogleFonts.poppins(color: Colors.white),
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
                                          color: Colors.white, width: 0.2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.2)),
                                  hintText: '  Email',
                                  hintStyle: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 227, 226, 226),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Phone Number',
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.white),
                              ),
                              subtitle: TextFormField(
                                focusNode: _phone,
                                style: GoogleFonts.poppins(color: Colors.white),
                                controller: phoneNumberController,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_msg);
                                },
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
                                            color: Colors.white, width: 0.2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 0.2)),
                                    hintText: '  Phone',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 227, 226, 226),
                                    )),
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
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.white),
                        ),
                        subtitle: TextFormField(
                          focusNode: _msg,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_enter);
                          },
                          controller: messageController,
                          keyboardType: TextInputType.multiline,
                          style: GoogleFonts.poppins(color: Colors.white),
                          maxLines: 5,
                          
                          decoration: InputDecoration(
                              hintText: "Message",
                              hintStyle: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 227, 226, 226),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.2))),
                          
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
                          focusNode: _enter,
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
                                              child: lottieSuccess()),
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
                            style: GoogleFonts.poppins(color: Colors.black),
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
      color: colorTwo,
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
                  SizedBox(
                    width: 180,
                    child: Image.network(
                        'https://deltabuckets.s3.ap-south-1.amazonaws.com/tdt+logos/TDT+-04.png'),
                  ),
                  Gap(10),
                  FittedBox(
                    child: SizedBox(
                      // color: colorTwo,
                      child: Row(
                        children: [
                          const Gap(10),
                          InkWell(
                            onTap: launchFaceBook,
                            child: SizedBox(
                                width: 25,
                                height: 25,
                                child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOXBReqjlDclmsacRsAv17iUNNaedscnr3YQ&usqp=CAU')),
                          ),
                          const Gap(30),
                          InkWell(
                            onTap: launchLinkedIn,
                            child: Container(
                                color: Colors.white,
                                width: 25,
                                height: 25,
                                child: Image.network(
                                    'https://www.freepnglogos.com/uploads/linkedin-logo-black-png-image-21.png')),
                          ),
                          const Gap(30),
                          InkWell(
                            onTap: launchWhatsApp,
                            child: SizedBox(
                                width: 25,
                                height: 25,
                                child: Image.network(
                                    'https://www.pagetraffic.com/blog/wp-content/uploads/2022/06/white-instagram-logo-png-transparent.png')),
                          ),
                          const Gap(130)
                        ],
                      ),
                    ),
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
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ))),
                  const Gap(10),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsPage()),
                        );
                      },
                      child: Text("About Us",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ))),
                  const Gap(10),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsAndConditionsPage()),
                        );
                      },
                      child: Text("Terms & Conditions",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ))),
                  const Gap(10),
                  // TextButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ContactUsPage()),
                  //       );
                  //     },
                  //     child: const Text("Tel +966 55 543 2866",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //         ))),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsPage()),
                        );
                      },
                      child: Text("sales@transdeltatrading.com",
                          style: GoogleFonts.poppins(
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
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                )),
                            subtitle: TextFormField(
                               focusNode:_name,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_comName);
                                },
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 13),
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
                                        color: Colors.white, width: 0.2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 0.2)),
                                hintText: '  Name',
                                hintStyle: GoogleFonts.poppins(
                                  color: Color.fromARGB(255, 227, 226, 226),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 2,
                        // ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Company Name',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.white),
                            ),
                            subtitle: TextFormField(
                              focusNode: _comName,
                              style: GoogleFonts.poppins(color: Colors.white),
                              controller: companyNameController,
                               onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_email);
                                },
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
                                        color: Colors.white, width: 0.2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 0.2)),
                                hintText: '  Company Name',
                                hintStyle: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 227, 226, 226),
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        )
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
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.white)),
                            subtitle: TextFormField(
                              focusNode: _email,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(_phone);
                              },
                              style: GoogleFonts.poppins(color: Colors.white),
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
                                          color: Colors.white, width: 0.2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.2)),
                                  hintText: '  Email',
                                  hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 227, 226, 226),
                                      fontSize: 12)),
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
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: Colors.white),
                            ),
                            subtitle: TextFormField(
                              focusNode: _phone,
                              style: GoogleFonts.poppins(color: Colors.white),
                              controller: phoneNumberController,
                               onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_msg);
                                },
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
                                          color: Colors.white, width: 0.2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.2)),
                                  hintText: '  +966 55 543 2866',
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 12)),
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
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.white),
                      ),
                      subtitle: TextFormField(
                        focusNode: _msg,
                        controller: messageController,
                         onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_enter);
                                },
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.poppins(color: Colors.white),
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintText: "Message",
                            hintStyle: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 13),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0.2))),
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
                        focusNode: _enter,
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
                                            child: lottieSuccess()),
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
