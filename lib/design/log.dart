import 'package:appflutter/design/constant.dart';
import 'package:appflutter/design/homepage.dart';
import 'package:appflutter/design/register.dart';
import 'package:appflutter/design/userTime.dart';
import 'package:appflutter/design/users.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../screens/controle.page.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {






  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

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
        errorMessage = 'Mot de passe invalide';
      });
      return;
    } else if (passwordController.text.length < 6) {
      setState(() {
        errorMessage = 'Il faut un mot de passe de plus de 6 caractères';
      });
      return;
    }

    final url = Uri.parse('http://192.168.239.126/flutter-login-signup/login.php');
    final response = await http.post(url, body: {
      'email': emailController.text,
      'password': passwordController.text,
    });

    final responseData = json.decode(response.body);
    if (responseData['success']) {
      print('Connexion réussie');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Usertime()),
      );
    } else {
      print('Connexion échouée');
    }

    // handle response data
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
                          'Login to your Account',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.key,color: Colors.indigo),
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
                    if (errorMessage.isNotEmpty)
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
                    SizedBox(
                      height: 40,
                    ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => registerpag(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
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
