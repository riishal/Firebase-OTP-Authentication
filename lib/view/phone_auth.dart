import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_authentication/view/otp_screen.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatelessWidget {
  PhoneAuth({super.key});
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                  "Please Enter +91\nAfter Enter Your Phone Number",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.blue),
                )),
            SizedBox(
              height: 15,
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
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Phone Number",
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
                    await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: phoneController.text.toString(),
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException ex) {},
                        codeSent: (String verificationid, int? resendtoken) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OTPscreen(varificationId: verificationid),
                              ));
                        },
                        codeAutoRetrievalTimeout: (String verficationId) {});
                  },
                  child: Text(
                    "Send OTP",
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
