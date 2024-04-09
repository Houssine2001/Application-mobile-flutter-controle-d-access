import 'package:flutter/material.dart';

import 'oupsBar.dart';

class UserHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navoups(),
      appBar: AppBar(
        title: Text('Histroy Access '),
        backgroundColor: Colors.indigo,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/oups.png",
            height: 250,
            width: 250,
          ),
          SizedBox(height: 20),
          Text(
            "Oups !! aucune historique sur ce utilisateur, réessayer plus tard",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
