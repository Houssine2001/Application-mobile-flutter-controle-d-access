import 'package:appflutter/screens/allusers.page.dart';
import 'package:appflutter/screens/autoList.dart';
import 'package:appflutter/screens/home.dart';
import 'package:appflutter/user.add.dart';
import 'package:flutter/material.dart';
import 'autobloque.list.dart';

class ControlePage extends StatelessWidget {
  const ControlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Gestion des employes OACA'),

            bottom: TabBar(
              tabs: const [
                Tab(icon: Icon(Icons.edit_attributes, size:28,), text: 'Users',),
                Tab(icon: Icon(Icons.supervised_user_circle_sharp, size:28,), text: 'Add',),
                Tab(icon: Icon(Icons.airline_stops_sharp, size:28,), text: 'Autorisation',),
                Tab(icon: Icon(Icons.block, size:28,), text: 'Accees',),
                Tab(icon: Icon(Icons.outbond, size:28,), text: 'Sign Out',),


            ],),
          ),
          body: TabBarView(
            children: [

              AddUserPage(),
              auto(),
              FirestoreExample(),
              HomeScreen()
            ],
          ),

        ));
  }
}
