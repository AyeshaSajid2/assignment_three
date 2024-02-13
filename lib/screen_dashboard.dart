
// import 'package:assignment_three/signin_anonym.dart';
// import 'package:assignment_three/signin_email.dart';
import 'package:assignment_three/signin_google.dart';
import 'package:assignment_three/signin_phone_num.dart';
import 'package:assignment_three/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        title: "Assignment #2",
      ),
      body: Center(
            // color: Colors.cyan,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                const Text("Sign up",textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, // Example font size
                  fontWeight: FontWeight.bold, // Example bold weight
                  color: Colors.black,),),

                const SizedBox(height: 30,),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                    labelText: 'Enter Email',
                    prefixIcon: const Icon(Icons.email),
                    // iconColor: Colors.white,
                    filled: true,
                    focusColor: Colors.green,
                  ),
                ),
                const SizedBox(height: 25,),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Enter Password',
                    // icon: Icon(Icons.password),
                     prefixIcon: const Icon(Icons.password),
                    filled: true,
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 40,),
                TextButton.icon(onPressed: () async  {
                  FirebaseAuth.instance.signInAnonymously().then((value) => print("signinAnonymously ${value}"));
                },
                  icon: Icon(Icons.account_box_outlined,color: Colors.white,),
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  label: const Text("Signin Anonymously", style: TextStyle(color: Colors.white,)),
                ),

                const SizedBox(height: 30,),
                TextButton.icon(onPressed: () async {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value)
                    {
                      print("Signin anonynously 1 ${value.user.toString()}");
                      print("Signin anonyms 2 ${value.additionalUserInfo.toString()}");
                      print("Signin credential 3 ${value.credential.toString()}");
                    });
                },
                  icon: Icon(Icons.email,color: Colors.white,),
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  label: const Text("Signin with email", style: TextStyle(color: Colors.white, )),
                ),
                const SizedBox(height: 30,),
                TextButton.icon(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => const PhoneAuth()));
                },
                  icon: Icon(Icons.phone_callback, color: Colors.white,),
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  label: const Text("Phone Authentication", style: TextStyle(color: Colors.white, ) ),

                ),
                const SizedBox(height: 30,),
                TextButton.icon(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => const SigninGoogle()));
                },
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                  label: const Text("Signin with google",
                   style: TextStyle(color: Colors.white, fontSize: 15, fontStyle: FontStyle.normal),),
                  icon: Icon(Icons.g_mobiledata,color: Colors.white,),
                    
                ),
                const SizedBox(height: 20,),
                // const SizedBox(height: 25,),

              ],
            ),


      ),

    );
  }
}


