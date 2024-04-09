/*import 'package:appflutter/repository/user.repo.dart';
import 'package:appflutter/screens/controle.page.dart';
import 'package:appflutter/screens/widgets/unknown/unknown.dart';
import 'package:flutter/material.dart';

import '../../model/user.model.dart';
import '../infoHoussine.dart';
import 'baha/baha.dart';
import 'houssine.dart';

class ListUsers extends StatefulWidget {
  List<User> users;
  ListUsers({required this.users});


  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
    final allusers = widget.users;
    final _ctrupdatename = TextEditingController();
    final _ctrupdatetime = TextEditingController();
    return ListView.builder(
        itemCount: allusers.length,
        itemBuilder : (context,index){
          return Card(
            child: ListTile(
             /* leading:CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(allusers[index].name.substring(0,2).toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
              ),*/
              title: Text(allusers[index].name, style: TextStyle(fontSize: 16),),
              subtitle: Text(allusers[index].time, style: TextStyle(fontSize: 13),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: (){
                      showDialog(context: context,
                          builder: (context)=>AlertDialog(
                            title: Text('Update :${allusers[index].name}'),
                            content: SingleChildScrollView(
                              child: Container(
                                height: 250,
                                child: Column(
                                  children: [
                                    TextField(
                                      style: TextStyle(fontSize: 22, color: Colors.blue),
                                      decoration: InputDecoration(labelText: 'Name',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)))),
                                      controller: _ctrupdatename,


                                    ),
                                    SizedBox(height: 20,),
                                    TextField(
                                      style: TextStyle(fontSize: 22, color: Colors.blue),
                                      decoration: InputDecoration(labelText: 'Time',
                                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)))),
                                      controller: _ctrupdatetime,


                                    ),
                                    SizedBox(height: 20,),
                                    ElevatedButton(
                                        onPressed: (){
                                         final user = User(id: allusers[index].id,
                                             name : _ctrupdatename.text,
                                             time: _ctrupdatetime.text);
                                         updateUser(user);
                                        },
                                        child: Container(width: double.infinity, child: Text('Update'),))
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context , 'Annuler');
                              }, child: Text('Annuler'))
                            ],

                          )
                      );
                    },
                    child: Icon(Icons.edit  ,size: 28, color: Colors.lightGreen,),
                  ),
                  TextButton(
                    onPressed: (){
                      showDialog(context: context,
                          builder: (context)=>AlertDialog(
                            title: Text('Voulez-vous vraiment supprimer ${allusers[index].name}?'),
                            actions: [
                              ElevatedButton(
                                onPressed: (){
                                 deleteUser(allusers[index].id);
                                 Navigator.pop(context,'oui');
                                },
                                  child: Text('Oui'),
                              ),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context,'Annuler');
                                },
                                child: Text('Non'),
                              ),
                            ],

                          ));
                    },
                    child: Icon(Icons.delete  ,size: 28, color: Colors.pinkAccent,),
                  ),





                  TextButton(
                    onPressed: (){


                      if(allusers[index].name == "baha") {
                        showDialog(context: context,
                            builder: (context) =>
                                AlertDialog(

                                  title: Text(
                                      'Baha Eddine Dridi'),
                                  content: Text('Cin : 150 203 69 \nPoste : un employe dans lOACA depuis 12 ans\nNiveau: bac + 5\nDiplome : Systéme embarque et mobile \nTélephone : +216 : 58.705.882'),
                          /*        actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context ,  'Annuler');
                                      },
                                      child: Text('Annuler'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => PersonPage(imageUrl: 'assets/images/houssine.png', firstName: 'Houssine',
                                                lastName: 'Ben Arous', email: 'HoussineBenArous48@gmail.com',
                                                address: 'Tunis, SidiDaouad ,Rue okba Ibn Nafaa'
                                                , phoneNumber: '29.678.226', jobTitle: 'Directeur', diploma: 'Bac+5',
                                                careerDescription: 'Avec un diplôme de bac + 3 en systèmes embarqués et mobiles,'
                                                    ' une personne pourrait poursuivre une carrière passionnante dans industrie'
                                                    ' de la technologie. Ils pourraient travailler sur la conception,'
                                                    ' le développement et la maintenance de systèmes embarqués pour des appareils'
                                                    ' mobiles tels que des smartphones et des tablettes.',),
                                            ));
                                      },
                                      child: Text('Aller à Houssinapage'),
                                    ),
                                  ],*/
                                actions: [

                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Annuler');
                                      },
                                      child: Text('Bien lit'),
                                    ),


                                    ElevatedButton(
                                    onPressed: () {
                      //Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                      builder: (context) => PersonPage(imageUrl: 'assets/images/baha.png', firstName: 'Baha',
                        lastName: 'Eddine Dridi', email: 'DridiBaha818@gmail.com',
                        address: 'Tunis, SidiDaouad ,Rue 14 janvier'
                        , phoneNumber: '24.509.366', jobTitle: 'Fondateur', diplome: 'Bac+5',
                       ),
                      )
                      );
                      },
                                      child: Text('Détails'),
                                    ),
                                  ],

                                ));
                      }


                      else if(allusers[index].name == "houssine") {
                        showDialog(context: context,
                            builder: (context) =>
                                AlertDialog(

                                  title: Text(
                                      'Houssine Ben Arous'),
                                  content: Text('Cin : 150 204 78 \nPoste : un employe dans lOACA depuis 12 ans\nNiveau: bac + 5\nDiplome : Systéme embarque et mobile \nTélephone : +216 20.405.752' ),

                                  actions: [

                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Annuler');
                                      },
                                      child: Text('Bien lit'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        //Navigator.pop(context);
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => PersonPage(imageUrl: 'assets/images/houssine.png', firstName: 'Houssine',
                                                lastName: 'Ben Arous', email: 'HoussineBenArous48@gmail.com',
                                                address: 'Tunis, SidiDaouad ,Rue okba Ibn Nafaa'
                                                , phoneNumber: '29.678.226', jobTitle: 'Directeur', diplome: 'Bac+5',
                                                ),
                                            )
                                        );
                                      },
                                      child: Text('Détails'),
                                    ),



                                  ],

                                ));
                      }


                      else {
                        showDialog(context: context,
                            builder: (context) =>
                                AlertDialog(

                                  title: Text(
                                      'Unknown'),
                                  content: Text(' Aucune information sur cette personne ' ),

                                  actions: [

                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Annuler');
                                      },
                                      child: Text('Bien lit'),
                                    ),
                                  ],

                                ));
                      }
          } ,

                    child: Icon(Icons.info  ,size: 28, color: Colors.blueGrey,),
                  ),


                  TextButton(
                    onPressed: () {
                      if (allusers[index].name == "houssine") {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => houssinepage()));
                      }
                      else if (allusers[index].name == "baha") {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => bahapage()));
                      }
                      else if (allusers[index].name == "Unknown") {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => unknownpage()));


                      }
                      else {
                        showDialog(context: context,
                            builder: (context) =>
                                AlertDialog(

                                  title: Text(
                                      'Unknown'),
                                  content: Text('Aucun historique sur cette personne\nVeuillez réessayer plus tard' ),

                                  actions: [

                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Annuler');
                                      },
                                      child: Text('Bien lit'),
                                    ),
                                  ],

                                ));
                      }
                    },







                    child: Icon(Icons.history  ,size: 28, color: Colors.blueGrey,),
                  ),







                ],
              )
            ),

          );
        }
    );
  }
}*/
