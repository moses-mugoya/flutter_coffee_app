import 'package:coffee_app/services/database.dart';
import 'package:coffee_app/shared/constants.dart';
import 'package:coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/models/user.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugarContent = ['0', '1', '2', '3', '4'];

  String _currentSugar;
  String _currentName;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update Your Coffee Settings',
                      style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (value) {
                      return value.isEmpty ? 'Name cannot be empty' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        return _currentName = val.trim();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: _currentSugar ?? userData.sugars,
                    decoration: textInputDecoration,
                    items: sugarContent.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar Sugar(s)'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugar = val),
                  ),
                  SizedBox(height: 20.0),
                  Slider(
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    max: 900.0,
                    min: 100.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  SizedBox(height: 20.0),
                  FlatButton(
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserRecords(
                            _currentSugar ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.pink,
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
