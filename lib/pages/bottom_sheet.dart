
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BottomSheett extends StatelessWidget {
  const BottomSheett({super.key});

  @override
  Widget build(BuildContext context) {
  var user = FirebaseAuth.instance.currentUser;

  TextEditingController textarea = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

    return Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width / 6,
        color: Colors.black,
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
                               SizedBox(  height: MediaQuery.of(context).size.height / 30,),

              TextButton(
                  onPressed: () {},
                  child: Text(
                    "About Us\n",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Contact Us\n",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                  )),
              
                   user != null
                        ? TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            child: Text('Logout',
                             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),))
                        : SizedBox(),
                      ],
                      // ),
                    ),
            )),
      ),
      Container(
        width: MediaQuery.of(context).size.width / 4,
        color: Colors.black,
        child: Expanded(
          // flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 40),
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
                  style: TextStyle(fontSize: 15,color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                 Text(
                  'Contact Us\n',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text('+91 6238636935',style:TextStyle(color: Colors.white,fontSize: 15),)
              ],
            ),
          ),
        ),
      ),
      Expanded(
          flex: 3,
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
                                  color:
                                      Colors.white, // Set border color to white
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
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
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
  );
  }
}
