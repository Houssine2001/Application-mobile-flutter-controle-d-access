import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appflutter/design/navBar.dart';
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


class BahaPage extends StatefulWidget {
  const BahaPage({Key? key}) : super(key: key);

  @override
  State<BahaPage> createState() => _BahaPageState();
}

class _BahaPageState extends State<BahaPage> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    final response = await http.get(Uri.parse('http://192.168.239.126/flutter-login-signup/baha.php'));
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
      Uri.parse('http://192.168.239.126/flutter-login-signup/deletebaha.php'),
      body: {'id': user.id},
    );
    if (response.statusCode == 200) {
      setState(() {
        _users.remove(user);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('L\'utilisateur ${user.name} a été supprimé.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible de supprimer l\'utilisateur ${user.name}.')),
      );
    }
  }

  void _confirmUserDeletion(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Êtes-vous sûr de vouloir supprimer ${user.name} ?"),
          actions: <Widget>[
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Supprimer"),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteUser(user);
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
        title: Text('Historique d\'accès Baha'),
        backgroundColor: Colors.indigo,

      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text(_users[index].name.substring(0, 2).toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text('Username: ${_users[index].name}',style: TextStyle(fontSize: 17,color: Colors.indigo,),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time Access : ${_users[index].time}',style: TextStyle(fontSize: 16,color :Colors.grey[800],fontWeight: FontWeight.bold,),),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete ,size: 30, color: Colors.red,),
                    onPressed: () {
                      _confirmUserDeletion(_users[index]);

                    },
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
