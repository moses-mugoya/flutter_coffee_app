import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/screens/home/brew_list.dart';
import 'package:coffee_app/screens/home/settings_form.dart';
import 'package:coffee_app/services/auth_service.dart';
import 'package:coffee_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void displayBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffee,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await AuthService().signOut();
              },
              icon: Icon(Icons.person),
              label: Text(
                'Logout',
              ),
              textColor: Colors.white,
            ),
            FlatButton.icon(
              onPressed: () {
                displayBottomSheet();
              },
              icon: Icon(Icons.settings),
              label: Text(
                'Settings',
              ),
              textColor: Colors.white,
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
