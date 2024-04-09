import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckBoxesScreen extends StatefulWidget {
  @override
  _CheckBoxesScreenState createState() => _CheckBoxesScreenState();
}

class _CheckBoxesScreenState extends State<CheckBoxesScreen> {
  late bool _isAuthorized1;
  late bool _isAuthorized2;
  late bool _isAuthorized3;
  late bool _isBlocked1;
  late bool _isBlocked2;
  late bool _isBlocked3;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadCheckBoxValues();
  }

  void _loadCheckBoxValues() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAuthorized1 = _prefs.getBool('isAuthorized1') ?? false;
      _isAuthorized2 = _prefs.getBool('isAuthorized2') ?? false;
      _isAuthorized3 = _prefs.getBool('isAuthorized3') ?? false;
      _isBlocked1 = _prefs.getBool('isBlocked1') ?? false;
      _isBlocked2 = _prefs.getBool('isBlocked2') ?? false;
      _isBlocked3 = _prefs.getBool('isBlocked3') ?? false;
    });
  }

  void _onAuthorized1Changed(bool? value) {
    setState(() {
      _isAuthorized1 = value ?? false;
      if (_isAuthorized1) {
        _isBlocked1 = false;
      }
      _prefs.setBool('isAuthorized1', _isAuthorized1);
      _prefs.setBool('isBlocked1', _isBlocked1);
    });
  }

  void _onAuthorized2Changed(bool? value) {
    setState(() {
      _isAuthorized2 = value ?? false;
      if (_isAuthorized2) {
        _isBlocked2 = false;
      }
      _prefs.setBool('isAuthorized2', _isAuthorized2);
      _prefs.setBool('isBlocked2', _isBlocked2);
    });
  }

  void _onAuthorized3Changed(bool? value) {
    setState(() {
      _isAuthorized3 = value ?? false;
      if (_isAuthorized3) {
        _isBlocked3 = false;
      }
      _prefs.setBool('isAuthorized3', _isAuthorized3);
      _prefs.setBool('isBlocked3', _isBlocked3);
    });
  }

  void _onBlocked1Changed(bool? value) {
    setState(() {
      _isBlocked1 = value ?? false;
      if (_isBlocked1) {
        _isAuthorized1 = false;
      }
      _prefs.setBool('isAuthorized1', _isAuthorized1);
      _prefs.setBool('isBlocked1', _isBlocked1);
    });
  }

  void _onBlocked2Changed(bool? value) {
    setState(() {
      _isBlocked2 = value ?? false;
      if (_isBlocked2) {
        _isAuthorized2 = false;
      }
      _prefs.setBool('isAuthorized2', _isAuthorized2);
      _prefs.setBool('isBlocked2', _isBlocked2);
    });
  }

  void _onBlocked3Changed(bool? value) {
    setState(() {
      _isBlocked3 = value ?? false;
      if (_isBlocked3) {
        _isAuthorized3 = false;
      }
      _prefs.setBool('isAuthorized3', _isAuthorized3);
      _prefs.setBool('isBlocked3', _isBlocked3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckBoxes Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text('Permission 1'),
              subtitle: Text('Authorized'),
              value: _isAuthorized1,
              onChanged: _onAuthorized1Changed,
              secondary: Checkbox(
                value: _isBlocked1,
                onChanged: _onBlocked1Changed,
              ),
            ),
            CheckboxListTile(
              title: Text('Permission 2'),
              subtitle: Text('Authorized'),
              value: _isAuthorized2,
              onChanged: _onAuthorized2Changed,
              secondary: Checkbox(
                value: _isBlocked2,
                onChanged: _onBlocked2Changed,
              ),
            ),
            CheckboxListTile(
              title: Text('Permission 3'),
              subtitle: Text('Authorized'),
              value: _isAuthorized3,
              onChanged: _onAuthorized3Changed,
              secondary: Checkbox(
                value: _isBlocked3,
                onChanged: _onBlocked3Changed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
