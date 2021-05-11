import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilter;
  final Map<String, bool> filters;
  FilterScreen(this.saveFilter, this.filters);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  Widget _buildSwitchListTile(
      String title, String subtitle, bool currentvalue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentvalue,
        subtitle: Text(subtitle),
        onChanged: updateValue);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFree = widget.filters['gluten'];
    _vegetarian = widget.filters['vegetarian'];
    _vegan = widget.filters['vegan'];
    _lactoseFree = widget.filters['lactose'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Filters"),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.saveFilter(selectedFilters);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text("Adjust your meal selection",
                  style: Theme.of(context).textTheme.headline6),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                      "Gluten-Free",
                      "Only include gluten-free meals",
                      _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      "Lactose-Free",
                      "Only include lactose-free meals",
                      _lactoseFree, (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }),
                  _buildSwitchListTile("Vegetarian",
                      "Only include vegetarian meals", _vegetarian, (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      "Vegan", "Only include vegan meals", _vegan, (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }),
                ],
              ),
            )
          ],
        ));
  }
}
