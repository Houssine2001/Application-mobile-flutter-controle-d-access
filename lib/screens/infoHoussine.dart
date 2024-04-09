import 'package:appflutter/design/history.dart';
import 'package:appflutter/screens/controle.page.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class PersonPage extends StatelessWidget {
  final String imageUrl;
  final String Prenom;
  final String Nom;
  final String email;
  final String Adresse;
  final String Telephone;
  final String jobTitle;
  final String diplome;

  const PersonPage({
    Key? key,
    required this.imageUrl,
    required this.Prenom,
    required this.Nom,
    required this.email,
    required this.Adresse,
    required this.Telephone,
    required this.jobTitle,
    required this.diplome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        //backgroundColor: Colors.blueGrey[500],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Informations sur Houssine Ben Arous",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
        ),
        // title: Text('Forgot Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.pop(context);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => hist()));
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.indigo,

          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CircleAvatar(
                    radius: 74,
                    backgroundImage: AssetImage(imageUrl),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '$Prenom $Nom',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    jobTitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 21),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoItem('Email', email),
                        _buildInfoItem('Address', Adresse),
                        _buildInfoItem('Phone', Telephone),
                        _buildInfoItem('Diplome', diplome),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 21),

                    /*child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Career Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          careerDescription,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),*/
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
