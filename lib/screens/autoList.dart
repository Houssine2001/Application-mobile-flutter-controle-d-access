import 'package:appflutter/repository/user.repo.dart';
import 'package:appflutter/screens/autorisation.dart';
import 'package:appflutter/screens/widgets/houssine.list.dart';
import 'package:appflutter/screens/widgets/users.list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/user.model.dart';

class auto extends StatefulWidget {
  const auto({Key? key}) : super(key: key);

  @override
  State<auto> createState() => _autoState();
}

class _autoState extends State<auto> {
  @override
  Widget build(BuildContext context) {
    List<User> allusersauto = [];

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').orderBy('name').snapshots(),
        builder: (context,snp){
          if(snp.hasError){
            return Center(child: Text('Error'),);
          }
          if(snp.hasData){
            allusersauto = snp.data!.docs
                .map((doc) => User.fromJson(doc.data() as Map<String ,dynamic >)).toList();
            return listauto(usersauto: allusersauto);

          }else{
            return Center(child: CircularProgressIndicator());
          }

        },
      ),
    );
  }
}
