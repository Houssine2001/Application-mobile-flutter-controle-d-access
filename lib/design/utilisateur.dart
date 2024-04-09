import 'package:flutter/material.dart';
import 'package:appflutter/design/LoginUtil.dart';
import 'navBar.dart';
import 'package:appflutter/design/login.dart';

class util extends StatefulWidget {
  const util({Key? key}) : super(key: key);

  @override
  State<util> createState() => _utilState();
}

class _utilState extends State<util> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 320,
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                image: DecorationImage(
                  image: AssetImage('assets/images/logo1.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.8),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Bienvenue',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton(
                  text: 'Administrateur',
                  color: Colors.indigo,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Utilisateur',
                  color: Colors.indigo,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Loginutil()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // augmenter la taille des boutons
        primary: color,
        elevation: 5,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
