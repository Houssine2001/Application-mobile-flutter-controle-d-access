import 'dart:async';

import 'package:appflutter/design/constant.dart';
import 'package:appflutter/design/login.dart';
import 'package:appflutter/design/utilisateur.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => util(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 30),
            Image(
              image: AssetImage("assets/images/Welcome-rafiki.png"),
              width: 370,
            ),
          ],
        ),
      ),
    );

  }
}
