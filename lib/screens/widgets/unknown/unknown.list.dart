import 'package:appflutter/screens/controle.page.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/repository/user.repo.dart';
import 'package:flutter/material.dart';

import '../../../model/user.model.dart';
import '../../allusers.page.dart';


class listinknown extends StatefulWidget {
  late List<User> usersunknown ;
  listinknown({required this.usersunknown});
  //listunknown({required this.usersunknown});
  @override
  State<listinknown> createState() => _listinknownState();
}

class _listinknownState extends State<listinknown> {
  @override
  Widget build(BuildContext context) {
    final allusers = widget.usersunknown;
    final _ctrupdatename = TextEditingController();
    final _ctrupdatetime = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique accées Unknown person'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.pop(context);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>  ControlePage()));
          },
        ),
      ),
      body: ListView.builder(

          itemCount: allusers.length,
          itemBuilder : (context,index){
            return Card(
              child: ListTile(
                leading:CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(allusers[index].name.substring(0,2).toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                title: Text(allusers[index].name, style: TextStyle(fontSize: 19),),
                subtitle: Text(allusers[index].time, style: TextStyle(fontSize: 15),),

              ),

            );
          }

      ),
    );
  }
}

