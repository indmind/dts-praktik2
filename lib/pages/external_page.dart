import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ExternalPage extends StatefulWidget {
  const ExternalPage({Key? key}) : super(key: key);

  @override
  State<ExternalPage> createState() => _ExternalPageState();
}

class _ExternalPageState extends State<ExternalPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Eksternal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: create, child: const Text('Buat File')),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: update, child: const Text('Edit File')),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: read, child: const Text('Baca File')),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: delete, child: const Text('Hapus File')),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              minLines: 5,
              maxLines: 10,
              readOnly: true,
              decoration: const InputDecoration.collapsed(
                hintText: '',
                filled: true,
                fillColor: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> get _localPath async {
    final directory = await getExternalStorageDirectory();

    if (directory == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat mengakses penyimpanan eksternal'),
        ),
      );
    }

    return directory?.path;
  }

  Future<void> create() async {
    final path = await _localPath;

    if (path == null) return;

    final file = File('$path/coba.txt');
    try {
      await file.writeAsString("Coba isi data file text");
    } on FileSystemException catch (e) {
      _controller.text = 'Error: ${e.osError?.message}';
    }
  }

  Future<void> update() async {
    final path = await _localPath;

    if (path == null) return;

    final file = File('$path/coba.txt');
    try {
      await file.writeAsString("Coba isi data file text baru");
    } on FileSystemException catch (e) {
      _controller.text = 'Error: ${e.osError?.message}';
    }
  }

  Future<void> read() async {
    final path = await _localPath;

    if (path == null) return;

    final file = File('$path/coba.txt');
    try {
      final contents = await file.readAsString();
      _controller.text = contents;
    } on FileSystemException catch (e) {
      _controller.text = 'Error: ${e.osError?.message}';
    }
  }

  Future<void> delete() async {
    final path = await _localPath;

    if (path == null) return;

    final file = File('$path/coba.txt');
    try {
      await file.delete();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('File berhasil dihapus'),
      ));
    } on FileSystemException catch (e) {
      _controller.text = 'Error: ${e.osError?.message}';
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('File gagal dihapus'),
      ));
    }
  }
}
