import 'dart:async';
import 'dart:convert';
import 'package:appflutter/design/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  List<dynamic> data = [];

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
        Uri.parse('http://192.168.151.126/flutter-login-signup/fetch.php'));

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
    Timer.periodic(Duration(seconds: 5), (timer) {
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
      title: 'Notification App',
      home: SplashScreen(),
    );
  }

  void startSendingNotifications(
      String deviceToken, String title, String body) {
    Timer.periodic(Duration(seconds: 5), (timer) {
      sendNotificationToServer(deviceToken, title, body);
    });
  }

  Future<void> sendNotificationToServer(
      String deviceToken, String title, String body) async {
    var url = 'http://192.168.151.126/flutter-login-signup/refresh.php'; // Replace with the actual URL of your PHP script

    var response = await http.post(
      Uri.parse(url),
      body: {
        'token': deviceToken,
        'title': title,
        'body': body,
      },
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully.');

      // Display the notification on the device
     // showNotification(title, body);
    } else {
      print('Failed to send notification.');
    }
  }

 /* Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'Channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'notification_payload',
    );
  }*/
}