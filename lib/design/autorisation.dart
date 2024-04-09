import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appflutter/design/navBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'houssine.dart';
class User {
  final String id;
  final String name;
  final String time;

  User({
    required this.id,
    required this.name,
    required this.time,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      time: json['time'],
    );
  }
}


class autorisation extends StatefulWidget {
  /*late List<User> users;
  autorisation({required this.users});*/
  const autorisation({Key? key}) : super(key: key);


  @override
  State<autorisation> createState() => _autorisationState();
}
class _autorisationState extends State<autorisation> {
  List<User> _users = [];
  Map<String, bool> _checkboxStates = {};

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    final response = await http.get(Uri.parse('http://192.168.239.126/flutter-login-signup/usertime.php'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _users = data.map((json) => User.fromJson(json)).toList();
        _users.forEach((user) {
          _checkboxStates[user.id] = false; // initial state
        });
      });
      _loadCheckboxStates();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> _loadCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _users.forEach((user) {
        final key = user.id;
        if (prefs.containsKey(key)) {
          _checkboxStates[key] = prefs.getBool(key)!;
        }
      });
    });
  }

  Future<void> _saveCheckboxState(String id, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _checkboxStates[id] = value;
      prefs.setBool(id, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Users Access'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text(_users[index].name.substring(0, 2).toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text('ID: ${user.id}', style: TextStyle(fontSize: 17)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${user.name}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text('Autoriser'),
                      Checkbox(
                        value: _checkboxStates[user.id] == true,
                        onChanged: (bool? checked) {
                          if (checked != null) {
                            _saveCheckboxState(user.id, checked);
                          }
                        },
                      ),
                      Text('Bloquer'),
                      Checkbox(
                        value: _checkboxStates[user.id] == false,
                        onChanged: (bool? checked) {
                          if (checked != null) {
                            _saveCheckboxState(user.id, !checked);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
