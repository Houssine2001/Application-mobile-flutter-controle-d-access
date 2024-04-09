import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.model.dart';



class listauto extends StatefulWidget {
  late List<User> usersauto;

  listauto({required this.usersauto});

  @override
  State<listauto> createState() => _listautoState();
}

class _listautoState extends State<listauto> {
  bool _isChecked = false;
  List<bool> _isAuthorized = [];
  List<bool> _isBlocked = [];
  late FirebaseFirestore _firestore;
  late SharedPreferences _prefs;


 /* @override
  void initState() {
    super.initState();
   // _loadCheckBoxValues();

    _firestore = FirebaseFirestore.instance;
    _isAuthorized = List.filled(widget.usersauto.length, false);
    _isBlocked = List.filled(widget.usersauto.length, false);
    initSharedPreferences();
  }*/
  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _isAuthorized = List.filled(widget.usersauto.length, false);
    _isBlocked = List.filled(widget.usersauto.length, false);
    // Récupérer l'état actuel de chaque case à cocher depuis les préférences partagées
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      for (int i = 0; i < widget.usersauto.length; i++) {
        String key = widget.usersauto[i].name + '_checkbox';
        bool? value = prefs.getBool(key);
        if (value != null) {
          _isAuthorized[i] = value;
          _isBlocked[i] = !value;
        }
      }
      setState(() {});
    });
  }


  void initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }





  @override
  Widget build(BuildContext context) {
    final allusers = widget.usersauto;
    final _ctrupdatename = TextEditingController();
    final _ctrupdatetime = TextEditingController();
    return ListView.builder(
        itemCount: allusers.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    allusers[index].name.substring(0, 2).toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  allusers[index].name,
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Autoriser"),
                    SizedBox(
                      width: 1,
                    ),
                    Checkbox(
                      value: _isAuthorized[index],
                      onChanged: (value) {

                        setState(() {
                          if(allusers[index].name == "baha") {
                            _isAuthorized[index] = value!;
                            if (value) {
                              _isBlocked[index] = false;
                            }
                            _sendDataToFirebasebaha(_isAuthorized[index] ? "true" : "false");
                            String key = allusers[index].name + '_checkbox';
                            _prefs.setBool(key, _isAuthorized[index]);
                          }
                          else if(allusers[index].name == "houssine") {
                            _isAuthorized[index] = value!;
                            if (value) {
                              _isBlocked[index] = false;
                            }
                            _sendDataToFirebasehoussine(_isAuthorized[index] ? "true" : "false");
                            String key = allusers[index].name + '_checkbox';
                            _prefs.setBool(key, _isAuthorized[index]);
                          }
                          else if(allusers[index].name == "anas") {
                            _isAuthorized[index] = value!;
                            if (value) {
                              _isBlocked[index] = false;
                            }
                            _sendDataToFirebasemed(_isAuthorized[index] ? "true" : "false");
                            String key = allusers[index].name + '_checkbox';
                            _prefs.setBool(key, _isAuthorized[index]);

                          }
                        }
                        );
                      },
                    ),
                    SizedBox(width: 1,),
                    Text("Bloquer"),
                    SizedBox(width: 1,),
                    Checkbox(
                      value: _isBlocked[index],
                      onChanged: (value) {
                        setState(() {
          if(allusers[index].name == "baha") {
            _isBlocked[index] = value!;
            if (value) {
              _isAuthorized[index] = false;
            }
            _sendDataToFirebasebaha(_isBlocked[index] ? "false" : "true");
            String key = allusers[index].name + '_checkbox';
            _prefs.setBool(key, _isAuthorized[index]);
          }
          else if(allusers[index].name == "houssine") {
            _isBlocked[index] = value!;
            if (value) {
              _isAuthorized[index] = false;
            }
            _sendDataToFirebasehoussine(_isBlocked[index] ? "false" : "true");
            String key = allusers[index].name + '_checkbox';
            _prefs.setBool(key, _isAuthorized[index]);

          }
          else if(allusers[index].name == "anas") {
            _isBlocked[index] = value!;
            if (value) {
              _isAuthorized[index] = false;
            }
            _sendDataToFirebasemed(_isBlocked[index] ? "false" : "true");
            String key = allusers[index].name + '_checkbox';
            _prefs.setBool(key, _isAuthorized[index]);

          }

                        }
                        );
                      },
                    ),



                  ],
                )
            ),
          );
        });
  }
  void _sendDataToFirebasebaha(String value) async {
    await _firestore
        .collection("checkbox_values")
        .doc("baha")
        .set({"value": value});
  }
  void _sendDataToFirebasehoussine(String value) async {
    await _firestore
        .collection("checkbox_values")
        .doc("houssine")
        .set({"value": value});
  }
  void _sendDataToFirebasemed(String value) async {
    await _firestore
        .collection("checkbox_values")
        .doc("anas")
        .set({"value": value});
  }


}







