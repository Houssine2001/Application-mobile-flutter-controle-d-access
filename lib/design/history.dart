import 'package:appflutter/design/baha.dart';
import 'package:appflutter/design/houssine.dart';
import 'package:appflutter/design/navBar.dart';
import 'package:appflutter/design/navBarutil.dart';
import 'package:flutter/material.dart';

import '../screens/infoHoussine.dart';

class Bloc {
  final String imagePath;
  final String title;

  Bloc({required this.imagePath, required this.title});
}

class hist extends StatelessWidget {
  final List<Bloc> blocs = [    Bloc(      imagePath: 'assets/images/houssine.png', title: 'Houssine Ben Arous',    ),
    Bloc(      imagePath: 'assets/images/baha.png',      title: 'Baha Eddine Dridi',    ),
    Bloc(      imagePath: 'assets/images/inconnu.png',      title: 'Samir Mahmoud',    ),
    Bloc(      imagePath: 'assets/images/inconnu.png',      title: 'Mohammed Rekki',    ),
    Bloc(      imagePath: 'assets/images/inconnu.png',      title: 'Nabiha Chelly',    ),
    Bloc(      imagePath: 'assets/images/inconnu.png',      title: 'Anis Hadi',    ),  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Historique d\'accès'),
        backgroundColor: Colors.indigo,

      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: blocs.map((bloc) {
          return InkWell(
            onTap: () {
              if (bloc.title == 'Houssine Ben Arous') {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => houssinePage()),
                );
              } else if (bloc.title == 'Baha Eddine Dridi') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BahaPage()),
                );
              }
              else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Information'),
                      content: Text('Aucune information sur cette personne'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(bloc.imagePath),
                    height: 90.0,
                    width: 90.0,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    bloc.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      if (bloc.title == 'Houssine Ben Arous') {


                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PersonPage(imageUrl: 'assets/images/houssine.png', Prenom: 'Houssine', Nom: 'Ben Arous', email: 'Houssinebenarous48@gmail.com', Adresse: 'Marsa ,Sidi Daouad', Telephone: '+216 29.678.226', jobTitle: 'Étudiant', diplome: 'Licence Systéme embarque et mobile',)
                          ),
                        );
                      } else if (bloc.title == 'Baha Eddine Dridi') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PersonPage(imageUrl: 'assets/images/baha.png', Prenom: 'Baha', Nom: 'Eddine Dridi', email: 'BahaEddine441@gmail.com', Adresse: 'Marsa ,Sidi Daouad', Telephone: '+216 24.509.366', jobTitle: 'Étudiant', diplome: 'Licence Systéme embarque et mobile',)
                          ),
                        );
                      }

                      else if (bloc.title == 'Mohammed Rekki') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PersonPage(imageUrl: 'assets/images/inconnu.png', Prenom: 'Mohammed', Nom: 'Rekki', email: 'MohammedRekki@yahoo.com', Adresse: 'Manouba, Ouid Lil', Telephone: '+216 20.405.752', jobTitle: 'Employé', diplome: 'Licence en Informatique de gestion',)
                          ),
                        );
                      }

                      else if (bloc.title == 'Nabiha Chelly') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PersonPage(imageUrl: 'assets/images/inconnu.png', Prenom: 'Nabiha', Nom: 'Chelly', email: 'NabihaChelly@gmail.com', Adresse: 'Tunis ,Kram', Telephone: '+216 58.500.711', jobTitle: 'Employé', diplome: 'Licence en Marketing Digital',)
                          ),
                        );
                      }
                      else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Information'),
                              content: Text('Aucune information sur cette personne'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: Text("En savoir plus"),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


