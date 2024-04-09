import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class User {
  final String id;
  final String username;
  final String email;
  final String password;

  User({required this.id, required this.username, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }
}
class UpdateUserDialog extends StatefulWidget {
  final User user;
  UpdateUserDialog({required this.user});

  @override
  _UpdateUserDialogState createState() => _UpdateUserDialogState();
}

class _UpdateUserDialogState extends State<UpdateUserDialog> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Modifier l'utilisateur"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: "Nom d'utilisateur",
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "Mot de passe",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text("Annuler"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Enregistrer"),
          onPressed: () {
            // Code pour enregistrer les modifications et fermer la boîte de dialogue
          },
        ),
      ],
    );
  }
}
