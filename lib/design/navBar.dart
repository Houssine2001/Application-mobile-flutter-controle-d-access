import 'package:appflutter/design/UnknownUsers.dart';
import 'package:appflutter/design/adduser.dart';
import 'package:appflutter/design/aut.dart';
import 'package:appflutter/design/history.dart';
import 'package:appflutter/design/login.dart';
import 'package:appflutter/design/userTime.dart';
import 'package:appflutter/design/users.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('OACA'),
            accountEmail: Text('tableau de bord Admin'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white, // Ajouter un fond blanc

              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo1.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline,color: Colors.indigo,),
            title: Text('Utilisateurs autorisés'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Usertime()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add,color: Colors.indigo,),
            title: Text('Ajouter nouveau utilisateur'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => adduser()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person,color: Colors.indigo,),
            title: Text('Utilisateurs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserList()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.auto_mode ,color: Colors.indigo,),
            title: Text('Autorisation'),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => aut()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history ,color: Colors.indigo,),
            title: Text('Historique d\'accès'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => hist()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.device_unknown ,color: Colors.indigo,),
            title: Text('Historique d\'accès des inconnus'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PythonDataWidget()),
              );
            },
          ),

          Divider(),
          ListTile(
            title: Text('Déconnexion'),
            leading: Icon(Icons.exit_to_app,color: Colors.red,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}