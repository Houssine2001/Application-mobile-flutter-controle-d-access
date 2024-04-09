import 'package:appflutter/repository/user.repo.dart';
import 'package:appflutter/screens/widgets/houssine.list.dart';
import 'package:appflutter/screens/widgets/users.list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/user.model.dart';

class houssinepage extends StatefulWidget {
  const houssinepage({Key? key}) : super(key: key);

  @override
  State<houssinepage> createState() => _houssinepageState();
}

class _houssinepageState extends State<houssinepage> {
  @override
  Widget build(BuildContext context) {
    List<User> allusershoussine = [];

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('historique accées houssine').orderBy('name').snapshots(),
        builder: (context,snp){
          if(snp.hasError){
            return Center(child: Text('Error'),);
          }
          if(snp.hasData){
            allusershoussine = snp.data!.docs
                .map((doc) => User.fromJson(doc.data() as Map<String ,dynamic >)).toList();
            return listhoussine(usershoussine: allusershoussine);

          }else{
            return Center(child: CircularProgressIndicator());
          }

        },
      ),
    );
  }
}
