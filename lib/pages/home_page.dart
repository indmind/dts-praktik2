import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _angka1 = TextEditingController();
  final TextEditingController _angka2 = TextEditingController();

  double _result = 0;

  @override
  void dispose() {
    _angka1.dispose();
    _angka2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masukkan 2 Angka'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              "Masukkan Dua Angka".toUpperCase(),
              style: Theme.of(context).textTheme.headline5,
            ),
            TextField(
              controller: _angka1,
              decoration: const InputDecoration(
                labelText: 'Masukkan Angka Pertama',
              ),
            ),
            TextField(
              controller: _angka2,
              decoration: const InputDecoration(
                labelText: 'Masukkan Angka Kedua',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _result = double.parse(_angka1.text) +
                          double.parse(_angka2.text);
                    });
                  },
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _result = double.parse(_angka1.text) -
                          double.parse(_angka2.text);
                    });
                  },
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _result = double.parse(_angka1.text) *
                          double.parse(_angka2.text);
                    });
                  },
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _result = double.parse(_angka1.text) /
                          double.parse(_angka2.text);
                    });
                  },
                  child: const Text('/'),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result = 0;
                    _angka1.clear();
                    _angka2.clear();
                  });
                },
                child: const Text("Bersihkan"),
              ),
            ),
            Text(
              'Hasilnya adalah $_result',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
