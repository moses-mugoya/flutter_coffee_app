import 'package:coffee_app/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffe;

  CoffeeTile({this.coffe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown[coffe.strength],
            radius: 25.0,
          ),
          title: Text(coffe.name),
          subtitle: Text('Takes ${coffe.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
