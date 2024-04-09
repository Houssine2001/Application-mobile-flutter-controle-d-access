import 'package:appflutter/design/LoginUtil.dart';
import 'package:appflutter/design/constant.dart';
import 'package:appflutter/design/homepage.dart';
import 'package:appflutter/design/login.dart';
import 'package:appflutter/design/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/controle.page.dart';

class registerutil extends StatefulWidget {
  const registerutil({Key? key}) : super(key: key);

  @override
  State<registerutil> createState() => _registerutilState();
}

class _registerutilState extends State<registerutil> {

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  bool passwordVisible = false;
  String errorMessage = '';



  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool isAlpha(String s) {
    if (s == null) {
      return false;
    }
    return s.contains(new RegExp(r'^[a-zA-Z]+$'));
  }



  Future<void> signup() async {

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
    if (userController.text.isEmpty) {
      setState(() {
        errorMessage = 'Username invalide';
      });
      return;
    }
    else if ( !isAlpha(userController.text)) {
      setState(() {
        errorMessage = 'Il faut un nom d\'utilisateur valide (lettres uniquement)';
      });
      return;
    }

    final url = Uri.parse('http://192.168.239.126/flutter-login-signup/registerutil.php');
    final response = await http.post(url, body: {
      'username': userController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });

    final responseData = json.decode(response.body);

    if (responseData['status'] == 'success') {
      // Afficher un message de réussite si l'inscription est réussie
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Succès'),
            content: Text('Votre inscription est réussie.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Loginutil(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      // Afficher un message d'erreur si l'inscription a échoué
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Votre inscription a échoué.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
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
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Center(
                        child: Image(
                          image: AssetImage("assets/images/logo1.png"),
                          width: 200,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Creér un compte Utilisateur',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(

                        keyboardType: TextInputType.text,
                        controller: userController,


                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Nom d\'utilisateur',
                          prefixIcon: Icon(Icons.person, color: Colors.indigo),
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
                          onPressed: signup,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            "S'inscrire",
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
                    "Vous avez un compte",
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
                      'Se connecter',
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

  customFormFeild({
    controller,
    labelText,
    keyboardType,
    textInputAction,
    obscureText,
  }) {
    return Material(
      elevation: 2,
      shadowColor: black,
      color: white,
      borderRadius: BorderRadius.circular(5.0),
      child: TextFormField(
        autofocus: false,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: black,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: black),
          contentPadding: const EdgeInsets.all(8),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
