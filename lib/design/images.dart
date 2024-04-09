
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageData {
  final int id;
  final String name;
  final String time;
  final String image;

  ImageData({required this.id, required this.name, required this.time, required this.image});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: int.parse(json['id']),
      name: json['name'],
      time: json['time'],
      image: json['image'],
    );
  }
}

class ImageListe extends StatefulWidget {
  @override
  _ImageListeState createState() => _ImageListeState();
}

class _ImageListeState extends State<ImageListe> {
  List<ImageData> _imageDataList = [];

  @override
  void initState() {
    super.initState();
    _loadImageData();
  }

  Future<void> _loadImageData() async {
    final response = await http.get(Uri.parse('http://192.168.239.126/flutter-login-signup/images.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        _imageDataList = jsonData.map((json) => ImageData.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste d\'images'),
      ),
      body: ListView.builder(
        itemCount: _imageDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                Image.memory(base64Decode(_imageDataList[index].image)),
                Text(_imageDataList[index].name),
                Text(_imageDataList[index].time),
              ],
            ),
          );
        },
      ),
    );
  }
}