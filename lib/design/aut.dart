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
  final bool etat;

  User({
    required this.id,
    required this.name,
    required this.time,
    required this.etat,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      time: json['time'],
      etat: json['etat'] == 'true',
    );
  }
}

class aut extends StatefulWidget {
  /*late List<User> users;
  autorisation({required this.users});*/
  const aut({Key? key}) : super(key: key);

  @override
  State<aut> createState() => _autState();
}

class _autState extends State<aut> {
  List<User> _users = [];
  Map<String, bool> _checkboxStates = {};

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    final response = await http
        .get(Uri.parse('http://192.168.239.126/flutter-login-signup/usertime.php'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _users = data.map((json) => User.fromJson(json)).toList();
        _users.forEach((user) {
          _checkboxStates[user.id] = user.etat; // initial state
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
    final String stateAutoStr = value ? "true" : "false";
    await http.post(
      Uri.parse('http://192.168.239.126/flutter-login-signup/update_user_state.php'),
      body: {
        'id': id,
        'etat': stateAutoStr,
      },
    );
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
        title: Text('Autorisation'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          bool isUnknownUser = user.name == "unknown"; // Ajout de la condition
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text(
                  _users[index].name.substring(0, 2).toUpperCase(),
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
                        onChanged: isUnknownUser ? null : (bool? checked) { // Ajout de la condition
                          if (checked != null) {
                            _saveCheckboxState(user.id, checked);
                            if (checked == true) {
                              _updateUserStateAuto(user, "true");
                            } else {
                              _updateUserStateAuto(user, "false");
                            }
                          }
                        },
                      ),
                      Text('Bloquer'),
                      Checkbox(
                        value: _checkboxStates[user.id] == false,
                        onChanged: isUnknownUser ? null : (bool? checked) { // Ajout de la condition
                          if (checked != null) {
                            _saveCheckboxState(user.id, !checked);
                            if (checked == false) {
                              _updateUserStateAuto(user, "true");
                            } else {
                              _updateUserStateAuto(user, "false");
                            }
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


  Future<void> _updateUserStateAuto(User user, String state) async {
    final response = await http.post(
      Uri.parse('http://192.168.239.126/flutter-login-signup/update_user_state.php'),
      body: {
        'id': user.id,
        'etat': state,
      },
    );
    if (response.statusCode == 200) {
      print('User state updated successfully');
    } else {
      throw Exception('Failed to update user state');
    }
  }
}
