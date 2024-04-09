import 'package:appflutter/repository/user.repo.dart';
import 'package:appflutter/screens/autorisation.dart';
import 'package:appflutter/screens/controle.page.dart';
import 'package:appflutter/screens/widgets/unknown/unknown.dart';
import 'package:appflutter/screens/widgets/users.list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.model.dart';

class autobloque extends StatefulWidget {
  late List<User> usersautobloque;
  autobloque({required this.usersautobloque});
  //listauto({required this.usersauto});
  @override
  State<autobloque> createState() => _autobloqueState();
}

class _autobloqueState extends State<autobloque> {

  @override
  Widget build(BuildContext context) {
    final allusers = widget.usersautobloque;
    final _ctrupdatename = TextEditingController();
    final _ctrupdatetime = TextEditingController();
    return ListView.builder(
        itemCount: allusers.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    allusers[index].name.substring(0, 2).toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  allusers[index].name,
                  style: TextStyle(fontSize: 18),
                ),
                ),
          );
        });
  }


}







