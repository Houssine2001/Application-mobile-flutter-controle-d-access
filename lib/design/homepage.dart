import 'package:appflutter/design/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Image(
          image: AssetImage("assets/images/logo1.png"),
          width: 150,
        ),
        centerTitle: true,
        actions: [

        ],
      ),
    );
  }
}
