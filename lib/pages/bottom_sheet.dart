import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/customtextfield.dart';
import 'package:firebase_hex/responsive/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheet extends StatelessWidget {
  const BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBottomSheet(
        mobileBottomSheet: deskBottomSheett(),
        deskBottomSheet: mobiledeskBottomSheett());
  }
}

class deskBottomSheett extends StatefulWidget {
  const deskBottomSheett({super.key});

  @override
  State<deskBottomSheett> createState() => _deskBottomSheettState();
}

class _deskBottomSheettState extends State<deskBottomSheett> {
    bool  hover=true; 

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    TextEditingController textarea = TextEditingController();
    TextEditingController companyName = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();

    return Container(
      color: Colors.black,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 6,
            color: Colors.transparent,
            child: Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Delta',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 122, 102, 54),
                        fontSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "About Us\n",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Contact Us\n",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  user != null
                      ? TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Are you sure to logout?"),
                                  // content: Text("This is my message."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Yes'))
                                  ],
                                );
                              },
                            );
                            // FirebaseAuth.instance.signOut();
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))
                      : SizedBox(),
                ],
                // ),
              ),
            )),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 4,
            color: Colors.transparent,
            child: Expanded(
              // flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address\n',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      'DELTA NATIONALS Baladiya St,\nAlanwar Center P.O.Box: 101447, jiddah 21311\nTel: 0126652671, jiddah -Soudi Arabia\nE-mail : sales@deltanationals.com',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Text(
                      'Contact Us\n',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      '+91 6238636935',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
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
                          CustTextField('name', name, context),
                          // _TextField("C", name, context),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 35,
                          ),
                          CustTextField("Company Name", companyName, context)
                          // _TextField("Company Name", companyName, context)
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Row(
                        children: [
                          CustTextField("Email", email, context),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 35,
                          ),
                          CustTextField('Phone Number', phoneNumber, context)
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: textarea,
                              keyboardType: TextInputType.multiline,
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
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
                            ),
                            MouseRegion(
                              onEnter:(h){
                                setState((){
                                  hover=false;
                                });
                              } ,
                              onExit: (h){
                                 setState((){
                                  hover=true;
                                });
                              },
                              child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                   hover==true?Colors.white :Color.fromARGB(255, 76, 138, 131),
                                  // minimumSize:
                                  //     MaterialStateProperty.all(Size(150, 50)),
                                ),
                                onPressed: () {
                                  print(textarea.text);
                                },
                                child:hover==true?   Text(
                                  'SUBMIT',
                                  style: TextStyle(color: Colors.black),
                                ):Text( 'SUBMIT',
                                  style: TextStyle(color: Colors.black),)
                               
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

//----------mobile------------------

class mobiledeskBottomSheett extends StatelessWidget {
  const mobiledeskBottomSheett({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    TextEditingController textarea = TextEditingController();
    TextEditingController companyName = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.transparent,
                  child: Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Delta',
                          style: GoogleFonts.pacifico(
                            textStyle: TextStyle(
                              color: Color.fromARGB(255, 122, 102, 54),
                              fontSize: 35,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "About Us\n",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Contact Us\n",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        user != null
                            ? TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                },
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ))
                            : SizedBox(),
                      ],
                      // ),
                    ),
                  )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                  color: Colors.transparent,
                  child: Expanded(
                    // flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address\n',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            'DELTA NATIONALS Baladiya St,\nAlanwar Center P.O.Box: 101447, jiddah 21311\nTel: 0126652671, jiddah -Soudi Arabia\nE-mail : sales@deltanationals.com',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          Text(
                            'Contact Us\n',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            '+91 6238636935',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Expanded(
            //     flex: 3,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
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
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CustTextField('name', name, context)),
                          // _TextField("C", name, context),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 35,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: CustTextField(
                                  "Company Name", companyName, context))
                          // _TextField("Company Name", companyName, context)
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CustTextField("Email", email, context)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 35,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: CustTextField(
                                  'Phone Number', phoneNumber, context))
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: textarea,
                              keyboardType: TextInputType.multiline,
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
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print(textarea.text);
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
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
      ),
    );
  }
}
