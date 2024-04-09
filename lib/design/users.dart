import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appflutter/design/navBar.dart';


class User {
  final String id;
  late final String username;
  late final String email;
  late final String password;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    final response = await http.get(Uri.parse('http://192.168.239.126/flutter-login-signup/users.php'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _users = data.map((json) => User.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> _deleteUser(User user) async {
    final response = await http.post(
      Uri.parse('http://192.168.239.126/flutter-login-signup/delete.php'),
      body: {'id': user.id},
    );
    if (response.statusCode == 200) {
      setState(() {
        _users.remove(user);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('L\'utilisateur ${user.username} a été supprimé.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible de supprimer l\'utilisateur ${user.username}.')),
      );
    }
  }

  Future<void> _updateUser(User user, String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.239.126/flutter-login-signup/updateuser.php'),
      body: {'id': user.id, 'username': username, 'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      setState(() {
        user.username = username;
        user.email = email;
        user.password = password;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('L\'utilisateur ${user.username} a été mis à jour.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible de mettre à jour l\'utilisateur ${user.username}.')),
      );
    }
  }

  void _confirmUserDeletion(User user) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
          title: Text("Confirmation"),
    content: Text("Êtes-vous sûr de vouloir supprimer l'utilisateur ${user.username} ?"),
        actions: <Widget>[
          TextButton(
            child: Text("Annuler"),
            onPressed: () {
              Navigator.of(context).pop();
              },            ),
          TextButton(
            child: Text("Supprimer"),
            onPressed: () {
              _deleteUser(user);
              Navigator.of(context).pop();
              },
          ),
        ],
      );

        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Utilisateurs'),
        backgroundColor: Colors.indigo,

      ),
      body: _users.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.grey[700],
          height: 1,
        ),
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = _users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo,
              child: Text(
                _users[index].username.substring(0, 2).toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text('ID: ${_users[index].id}',style: TextStyle(fontSize: 17),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${_users[index].username}',style: TextStyle(fontSize: 16,color: Colors.indigo,fontWeight: FontWeight.bold,),),
                Text('Email: ${_users[index].email}',style: TextStyle(fontSize: 15),),
                Text('Password: ${_users[index].password}',style: TextStyle(fontSize: 15),),
              ],
            ),


          /*  onTap: () {

            },*/

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete ,size: 30, color: Colors.red,),
                  onPressed: () {
                    _confirmUserDeletion(user);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.update ,size: 30,color: Colors.green,),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String username = user.username;
                        String email = user.email;
                        String password = user.password;
                        return AlertDialog(
                          title: Text("Mettre à jour l'utilisateur"),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Nom d\'utilisateur',
                                    hintText: 'Entrez un nouveau nom d\'utilisateur',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    username = value;
                                  },
                                  controller: TextEditingController(text: username),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Adresse e-mail',
                                    hintText: 'Entrez une nouvelle adresse e-mail',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  controller: TextEditingController(text: email),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Mot de passe',
                                    hintText: 'Entrez un nouveau mot de passe',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  controller: TextEditingController(text: password),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text("Annuler"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Mettre à jour"),
                              onPressed: () {
                                _updateUser(user, username, email, password);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),



















          );
        },
      ),
    );
  }
}

