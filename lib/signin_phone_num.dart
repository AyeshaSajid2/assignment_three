import 'package:assignment_three/otp_screen.dart';
import 'package:assignment_three/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Phone Authentication",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                // fillColor: Colors.black,
                hintText: "Enter Phone Number",
                suffixIcon:   const Icon(Icons.phone, color: Colors.purple,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(onPressed: () async {
            FirebaseAuth.instance.verifyPhoneNumber(verificationCompleted: (PhoneAuthCredential credential){

            },
              verificationFailed: (FirebaseAuthException ex){},
              codeSent: (String verificationId, int? resendToken){
                Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(verificationID: verificationId,)));
              },
              codeAutoRetrievalTimeout: (String verificationId){

              },
              phoneNumber: phoneController.text.toString(),
            );
          } ,
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
              child: const Text("Verify Phone Number",
          style: TextStyle(color: Colors.white, fontSize: 15, fontStyle: FontStyle.normal),
    ))
        ],
      ),
    );
  }
}
