import 'package:appflutter/screens/login1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/screens/controle.page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: ElevatedButton(

        onPressed: (){
          FirebaseAuth.instance.signOut().then((value) {
            print("Signed Out");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          });
        },
        child: Text('Logout'),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          elevation: 5,
        ),
      ),
      ),

    );
  }
}
