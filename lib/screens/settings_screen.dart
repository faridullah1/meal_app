import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = 'settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            SwitchListTile(
              title: const Text('Gluten-Free'),
              subtitle: const Text('Only include Gluten-free meals.'),
              value: _glutenFree,
              onChanged: (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Vegetarian'),
              subtitle: const Text('Only include vegetarian meals.'),
              value: _vegetarian,
              onChanged: (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Lactose-Free'),
              subtitle: const Text('Only include lactose-free meals.'),
              value: _lactoseFree,
              onChanged: (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Vegan'),
              subtitle: const Text('Only include vegan meals.'),
              value: _vegan,
              onChanged: (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              },
            )
          ],
        ))
      ]),
      drawer: const MainDrawer(),
    );
  }
}
