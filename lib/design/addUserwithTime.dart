
import 'package:appflutter/design/constant.dart';
import 'package:appflutter/design/homepage.dart';
import 'package:appflutter/design/login.dart';
import 'package:appflutter/design/navBar.dart';
import 'package:appflutter/design/register.dart';
import 'package:appflutter/design/userTime.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../screens/controle.page.dart';

class addusertime extends StatefulWidget {
  const addusertime({Key? key}) : super(key: key);

  @override
  State<addusertime> createState() => _addusertimeState();
}

class _addusertimeState extends State<addusertime> {

  TextEditingController userController = TextEditingController();
  TextEditingController timeController = TextEditingController();


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

    if (timeController.text.isEmpty) {
      setState(() {
        errorMessage = 'Time invalide';
      });
      return;
    }

    else if (userController.text.isEmpty) {
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

    final url = Uri.parse('http://192.168.239.126/flutter-login-signup/time.php');
    final response = await http.post(url, body: {
      'name': userController.text,
      'time': timeController.text,
    });



    if (response.statusCode == 200) {
      print('Connexion réussie');

      setState(() {
        // Afficher un message de réussite si l'inscription est réussie
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Succès'),
              content: Text('Votre add est réussie.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Usertime(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      });
    }
    else {
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
    final responseData = json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Ajouter nouveau utilisateur'),
        backgroundColor: Colors.indigo,

      ),
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
                          image: AssetImage("assets/images/add.png"),
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
                          'Ajouter nouveau compte',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(

                        keyboardType: TextInputType.text,
                        controller: userController,


                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Username',
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
                        keyboardType: TextInputType.text,
                        controller: timeController,


                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Time',
                          prefixIcon: Icon(Icons.timelapse, color: Colors.indigo),
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
                      height: 20,
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
                            'Ajouter',
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
