import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> countries = [
    'Indonesia',
    'Malaysia',
    'Singapore',
    'Italia',
    'Inggris',
    'Belanda',
    'Argentina',
    'Chile',
    'Mesir',
    'Uganda',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView sederhana'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: 0),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(countries[index]),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Memilih ${countries[index]}'),
                ),
              );
            },
          );
        },
        itemCount: countries.length,
      ),
    );
  }
}
