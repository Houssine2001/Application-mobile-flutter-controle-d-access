import 'package:appflutter/model/user.model.dart';
import 'package:appflutter/repository/user.repo.dart';
import 'package:appflutter/screens/widgets/houssine.list.dart';
import 'package:appflutter/screens/widgets/unknown/unknown.list.dart';
import 'package:appflutter/screens/widgets/users.list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


//import '../../model/user.model.dart';

class unknownpage extends StatefulWidget {
  const unknownpage({Key? key}) : super(key: key);

  @override
  State<unknownpage> createState() => _unknownpageState();
}

class _unknownpageState extends State<unknownpage> {
  @override
  Widget build(BuildContext context) {
    List<User> allusersunknown = [];
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('historique accées unknown person').orderBy('name').snapshots(),
        builder: (context,snp){
          if(snp.hasError){
            return Center(child: Text('Error'),);
          }
          if(snp.hasData){
            allusersunknown = snp.data!.docs
                .map((doc) => User.fromJson(doc.data() as Map<String ,dynamic >)).toList();
            return listinknown(usersunknown: allusersunknown);

          }else{
            return Center(child: CircularProgressIndicator());
          }

        },
      ),
    );
  }
}
