import 'package:appflutter/design/constant.dart';
import 'package:appflutter/design/homepage.dart';
import 'package:appflutter/design/pageSedak.dart';
import 'package:appflutter/design/register.dart';
import 'package:appflutter/design/registerutil.dart';
import 'package:appflutter/design/userTime.dart';
import 'package:appflutter/design/userTimeutil.dart';
import 'package:appflutter/design/users.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../screens/controle.page.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/design/login.dart';

import 'oups.dart';



class Loginutil extends StatefulWidget {
  Loginutil({Key? key}) : super(key: key);

  @override
  _LoginutilState createState() => _LoginutilState();
}

class _LoginutilState extends State<Loginutil> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = '';
  bool passwordVisible = false;

  Future<void> signIn() async {
    if (emailController.text.isEmpty) {
      setState(() {
        errorMessage = 'Email invalide';
      });
      return;
    }
    if (!emailController.text.contains('@')) {
      setState(() {
        errorMessage = 'Ecris un type email';
      });
      return;
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Mot de passe invalid';
      });
      return;
    } else if (passwordController.text.length < 6) {
      setState(() {
        errorMessage = 'Il faut un mot de passe de plus de 6 caractères';
      });
      return;
    }

    final url = Uri.parse('http://192.168.239.126/flutter-login-signup/loginutil.php');
    final response = await http.post(url, body: {
      'email': emailController.text,
      'password': passwordController.text,
    });

    final responseData = json.decode(response.body);
    if (responseData['success']) {
      print('Connexion réussie');
      if (emailController.text == 'sedak@gmail.com') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SedakPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserHistoryPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Données incorrect , merci de verifier vos données')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Center(
                  child: Image(
                    image: AssetImage("assets/images/logo1.png"),
                    width: 200,
                  ),
                ),
              ),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Login Utilisateur',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 58),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email, color: Colors.indigo),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.indigo,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: passwordController,
                        obscureText: !passwordVisible,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          prefixIcon:
                          Icon(Icons.lock, color: Colors.indigo),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.indigo,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        height: 50.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ElevatedButton(
                          onPressed: signIn,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 58),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous n'avez pas de compte ? ",
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => registerutil(),
                        ),
                      );
                    },
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: blue,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Cliquez ici ",
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Compte Admin',
                      style: TextStyle(
                        color: blue,
                      ),
                    ),
                  ),
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }
}
