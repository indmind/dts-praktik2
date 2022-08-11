import 'package:flutter/material.dart';

import '../model/note.dart';
import '../service/note_service.dart';

class NotePage extends StatefulWidget {
  // if note is provided, this is an update operation
  final Note? note;

  const NotePage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NoteService _noteService = FileStorageNoteService();

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _controller = TextEditingController(text: widget.note!.content);
    } else {
      _controller = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.note != null
            ? const Text('Edit Catatan')
            : const Text('Tambah Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final content = _controller.text;
              if (widget.note != null) {
                await _noteService.updateNote(
                  Note(
                    date: widget.note!.date,
                    content: content,
                  ),
                );
              } else {
                await _noteService.createNote(
                  Note(
                    date: DateTime.now(),
                    content: content,
                  ),
                );
              }

              if (mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (DateTime now) {
                return '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}';
              }(DateTime.now()),
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              minLines: 10,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Catatan',
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
