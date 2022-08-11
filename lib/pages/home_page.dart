import 'package:flutter/material.dart';

import '../model/user.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text('Selamat datang ${user.username}!'),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text('Keluar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
