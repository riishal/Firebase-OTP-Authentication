// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_authentication/view/home_screen.dart';
import 'package:flutter/material.dart';

class OTPscreen extends StatefulWidget {
  final String varificationId;
  OTPscreen({
    Key? key,
    required this.varificationId,
  }) : super(key: key);

  @override
  State<OTPscreen> createState() => _OTPscreenState();
}

class _OTPscreenState extends State<OTPscreen> {
  final TextEditingController oTPcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("OTP Screen")),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(color: Colors.white),
        height: double.infinity,
        width: double.infinity,
        child: Center(
            child: SingleChildScrollView(
          child: Column(children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Firebase Phone Authentication",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                )),
            SizedBox(
              height: 90,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter Your OTP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 13,
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.grey,
                )
              ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
              height: size.height * 0.074,
              width: size.width * 0.89,
              child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: oTPcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height * 0.074,
              width: size.width * 0.89,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          await PhoneAuthProvider.credential(
                              verificationId: widget.varificationId,
                              smsCode: oTPcontroller.text.toString());
                      FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homepage(),
                            ));
                      });
                    } catch (ex) {
                      log(ex.toString() as num);
                    }
                  },
                  child: Text(
                    "Verify",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
          ]),
        )),
      )),
    );
  }
}
