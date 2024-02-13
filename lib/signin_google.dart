// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class SigninGoogle extends StatelessWidget {
//   const SigninGoogle({Key? key}) : super(key: key);
//
//   googleLogin() async {
//     print("googleLogin method Called");
//     GoogleSignIn _googleSignIn = GoogleSignIn();
//     try {
//       var reslut = await _googleSignIn.signIn();
//       if (reslut == null) {
//         return;
//       }
//
//       final userData = await reslut.authentication;
//       final credential = GoogleAuthProvider.credential(
//           accessToken: userData.accessToken, idToken: userData.idToken);
//       var finalResult =
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       print("Result $reslut");
//       print(reslut.displayName);
//       print(reslut.email);
//       print(reslut.photoUrl);
//     } catch (error) {
//       print(error);
//     }
//   }
//
//   Future<void> logout() async {
//     await GoogleSignIn().disconnect();
//     FirebaseAuth.instance.signOut();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login Screen'),
//         actions: [
//           TextButton(
//             onPressed: logout,
//             child: const Text(
//               'LogOut',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Center(
//         child: ElevatedButton(
//             child: const Text('Google Login'), onPressed: googleLogin),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firestore
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninGoogle extends StatelessWidget {
  const SigninGoogle({Key? key}) : super(key: key);

  Future<void> googleLogin() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();

      // Get Google Sign-in account data
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return; // User canceled
      }

      // Get authentication credentials from the account
      final GoogleSignInAuthentication authentication =
      await account.authentication;

      // Create Firebase credential using accessToken and idToken
      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken, idToken: authentication.idToken);

      // Sign in with Firebase using the credential
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Handle successful sign-in
      print("Signed in successfully as ${userCredential.user!.email}");

      // Save user data to Firebase
      await saveUserDataToFirestore(userCredential.user!);
    } on FirebaseAuthException catch (error) {
      // Handle Firebase-specific errors
      print(error.message);
    } catch (error) {
      // Handle other errors
      print(error);
    }
  }

  Future<void> saveUserDataToFirestore(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(user.uid);
    await docUser.set({
      'uid': user.uid,
      'name': user.displayName,
      'email': user.email,
      'photoUrl': user.photoURL,
      // Add other fields as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Login Screen'),
        actions: [
          TextButton(
            onPressed: logout,
            child: const Text(
              'LogOut',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
            child: const Text('Google Login'), onPressed: googleLogin),
      ),
    );
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
}
