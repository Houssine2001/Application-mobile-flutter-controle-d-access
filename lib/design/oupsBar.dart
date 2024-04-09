import 'package:appflutter/design/LoginUtil.dart';
import 'package:appflutter/design/UnknownUsers.dart';
import 'package:appflutter/design/adduser.dart';
import 'package:appflutter/design/aut.dart';
import 'package:appflutter/design/hisUtil.dart';
import 'package:appflutter/design/history.dart';
import 'package:appflutter/design/login.dart';
import 'package:appflutter/design/pageSedak.dart';
import 'package:appflutter/design/userTime.dart';
import 'package:appflutter/design/userTimeutil.dart';
import 'package:appflutter/design/users.dart';
import 'package:flutter/material.dart';

import 'oups.dart';

class Navoups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('OACA'),
            accountEmail: Text('"tableau de bord Utilisateur'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white, // Ajouter un fond blanc

              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo1.png', // Remplacez le nom de l'image par le vôtre
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
            title: Text("Historique d\'utilisateur"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserHistoryPage()),
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
                MaterialPageRoute(builder: (context) => Loginutil()),
              );
            },
          ),
        ],
      ),
    );
  }
}