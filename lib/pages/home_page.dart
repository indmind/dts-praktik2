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

  List<Map<String, dynamic>> _cities = [];

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
                labelText: 'Masukkan Kota',
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
                  title: Text(_cities[index][DbService.keyFirstname]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _dbService
                              .delete(_cities[index][DbService.keyId]);
                          await _updateStudents();
                        },
                      ),
                      // edit using dialog
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final String? name = await showDialog<String>(
                            context: context,
                            builder: (context) =>
                                EditCityDialog(city: _cities[index]),
                          );
                          if (name != null) {
                            await _dbService.update(
                              _cities[index][DbService.keyId],
                              name,
                            );
                            await _updateStudents();
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
              itemCount: _cities.length,
            )),
          ],
        ),
      ),
    );
  }

  Future<void> _updateStudents() async {
    final List<Map<String, dynamic>> students = await _dbService.getAll();
    setState(() {
      _cities = students;
    });
  }
}

class EditCityDialog extends StatefulWidget {
  const EditCityDialog({
    Key? key,
    required this.city,
  }) : super(key: key);

  final Map<String, dynamic> city;

  @override
  State<EditCityDialog> createState() => _EditCityDialogState();
}

class _EditCityDialogState extends State<EditCityDialog> {
  late final _nameController =
      TextEditingController(text: widget.city[DbService.keyFirstname]);

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Kota'),
      content: TextField(
        controller: _nameController,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_nameController.text);
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
