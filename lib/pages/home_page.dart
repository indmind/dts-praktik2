import 'package:flutter/material.dart';
import 'package:sandbox/services/db_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DbService _dbService = DbService();

  final TextEditingController _nameController = TextEditingController();

  List<Map<String, dynamic>> _students = [];

  @override
  void initState() {
    super.initState();
    _updateStudents();
  }

  @override
  void dispose() {
    _dbService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nama',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _dbService.insert(_nameController.text);
                await _updateStudents();

                _nameController.clear();
              },
              child: const Text('Simpan'),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_students[index][DbService.keyFirstname]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await _dbService
                          .delete(_students[index][DbService.keyId]);
                      await _updateStudents();
                    },
                  ),
                );
              },
              itemCount: _students.length,
            )),
          ],
        ),
      ),
    );
  }

  Future<void> _updateStudents() async {
    final List<Map<String, dynamic>> students = await _dbService.getAll();
    setState(() {
      _students = students;
    });
  }
}
