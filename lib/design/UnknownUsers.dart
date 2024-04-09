import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'navBar.dart';
import 'package:url_launcher/url_launcher.dart';

class Python {
  String id;
  String name;
  String time;

  Python({required this.id, required this.name, required this.time});
}

class PythonDataWidget extends StatefulWidget {
  @override
  _PythonDataWidgetState createState() => _PythonDataWidgetState();
}

class _PythonDataWidgetState extends State<PythonDataWidget> {
  List<Python> pythonList = [];

  Future<List<Python>> getPythonData() async {
    final response = await http.get(Uri.parse('http://192.168.239.126/flutter-login-signup/get_images.php'));
    if (response.statusCode == 200) {
      final List<dynamic> parsedJson = json.decode(response.body);
      List<Python> pythonList = [];
      for (Map<String, dynamic> map in parsedJson) {
        pythonList.add(Python(
          id: map['id'],
          name: map['name'],
          time: map['time'],
        ));
      }
      return pythonList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    getPythonData().then((value) {
      setState(() {
        pythonList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Historique d\'accès des inconnues'),
        backgroundColor: Colors.indigo,

      ),
      body: ListView.builder(
        itemCount: (pythonList.length / 2).ceil(),
        itemBuilder: (BuildContext context, int index) {
          int leftIndex = index * 2;
          int rightIndex = leftIndex + 1;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Information'),
                            content: InkWell(
                              child: Text('L\'image de l\'inconnu est disponible sur l\'application web'),
                              onTap: () {
                                launch('http://192.168.239.126/appwebphp/imgg.php');
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );

                        },
                      );
                    },

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.asset(
                            'assets/images/person.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pythonList[leftIndex].name,
                                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 6.0),
                              Text(
                                pythonList[leftIndex].time,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: rightIndex < pythonList.length ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Information'),
                            content: InkWell(
                              child: Text('L\'image de l\'inconnu est disponible sur l\'application web'),
                              onTap: () {
                                launch('http://192.168.239.126/appwebphp/imgg.php');
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.asset(
                            'assets/images/person.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pythonList[rightIndex].name,
                                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 6.0),
                              Text(
                                pythonList[rightIndex].time,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ) : Container(),
              ),
            ],
          );
        },
      ),
    );


  }
}
