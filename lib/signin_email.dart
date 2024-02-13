import 'package:assignment_three/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SigninEmail extends StatefulWidget {
  const SigninEmail({super.key});

  @override
  State<SigninEmail> createState() => _SigninEmailState();
}

class _SigninEmailState extends State<SigninEmail> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "Signin Email",

      ),
    );
  }
}
