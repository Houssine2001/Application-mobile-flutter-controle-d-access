import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_background/flutter_background.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Ajoutez une variable pour stocker les données récupérées du serveur
  List<dynamic> data = [];

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
        Uri.parse('http://192.168.68.106/flutter-login-signup/fetch.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Impossible de charger les données');
    }
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformDetails, payload: 'payload');
  }

  void checkData() {
    data.forEach((row) {
      if (row['auto_state'] == 'true' && row['name'] == 'unknown') {
        showNotification('Personne inconnue', ' souhaite entrer à ${row['time']}');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Appelez la fonction fetchData() périodiquement toutes les 30 secondes
    Timer.periodic(Duration(seconds: 30), (timer) {
      fetchData().then((newData) {
        if (newData != data) {
          data = newData;
          checkData();
        }
      }).catchError((error) {
        print(error);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MySQL Demo',

    );
  }
}