import 'package:assignment_three/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SigninAnonym extends StatefulWidget {
  const SigninAnonym({super.key});

  @override
  State<SigninAnonym> createState() => _SigninAnonymState();
}

class _SigninAnonymState extends State<SigninAnonym> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Signin Anonymously",
      ),
    );
  }
}
