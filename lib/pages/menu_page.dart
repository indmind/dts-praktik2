import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final String text;

  const MenuPage({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProjectMenu'),
      ),
      body: Text(
        text,
        style: const TextStyle(fontSize: 32),
      ),
    );
  }
}
