import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/screens/home/coffee_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final coffee = Provider.of<List<Coffee>>(context) ?? [];
    return ListView.builder(
      itemCount: coffee.length,
      itemBuilder: (context, index) {
        return CoffeeTile(coffe: coffee[index]);
      },
    );
  }
}
