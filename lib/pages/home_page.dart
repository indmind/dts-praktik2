import 'package:flutter/material.dart';

import 'menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _buttonColor = Colors.grey[400]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MenuPage(text: value)),
              );
            },
            itemBuilder: (BuildContext context) {
              return {'Menu 1', 'Menu 2', 'Menu 3'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _buttonColor = Colors.red;
              });
            },
            style: ElevatedButton.styleFrom(
              primary: _buttonColor,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
