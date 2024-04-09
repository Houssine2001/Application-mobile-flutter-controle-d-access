import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreExample extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text('Firestore Example'),
      ),*/
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: StreamBuilder<DocumentSnapshot>(
              stream: firestore.collection('Autorisation de baha').doc('zAfTyL5Mq9DDGO6DCS1f').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Une erreur est survenue: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text('Aucune donnée trouvée pour ce document.');
                }

                final data = snapshot.data!;
                final name = data.get('name');

                return Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '$name',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],

                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),

          Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 2,
            height: 0,
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,

            child: StreamBuilder<DocumentSnapshot>(
              stream: firestore.collection('Autorisation de houssine').doc('S5IVRs31biDepAb4bdt').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Une erreur est survenue: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text('Aucune donnée trouvée pour ce document.');
                }

                final data = snapshot.data!;
                final name = data.get('name');

                return Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    ' $name',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            thickness: 2,
            height: 0,
          ),
        ],
      ),
    );
  }
}
