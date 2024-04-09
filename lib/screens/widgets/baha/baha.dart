import 'package:appflutter/model/user.model.dart';
import 'package:appflutter/repository/user.repo.dart';
import 'package:appflutter/screens/widgets/houssine.list.dart';
import 'package:appflutter/screens/widgets/users.list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'baha.list.dart';

//import '../../model/user.model.dart';

class bahapage extends StatefulWidget {
  const bahapage({Key? key}) : super(key: key);

  @override
  State<bahapage> createState() => _bahapageState();
}

class _bahapageState extends State<bahapage> {
  @override
  Widget build(BuildContext context) {
    //List<User> allusersbaha = [];
List<User> allusersbaha = [];
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('historique accées baha').orderBy('name').snapshots(),
        builder: (context,snp){
          if(snp.hasError){
            return Center(child: Text('Error'),);
          }
          if(snp.hasData){
            allusersbaha = snp.data!.docs
                .map((doc) => User.fromJson(doc.data() as Map<String ,dynamic >)).toList();
            return listbaha(usersbaha: allusersbaha);

          }else{
            return Center(child: CircularProgressIndicator());
          }

        },
      ),
    );
  }
}

