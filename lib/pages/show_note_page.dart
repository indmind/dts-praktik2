import 'package:flutter/material.dart';
import 'package:sandbox/model/note.dart';

import '../service/note_service.dart';
import 'note_page.dart';

class ShowNotePage extends StatefulWidget {
  final Note note;

  const ShowNotePage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<ShowNotePage> createState() => _ShowNotePageState();
}

class _ShowNotePageState extends State<ShowNotePage> {
  late Note _note = widget.note;
  final NoteService noteService = FileStorageNoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(note: _note),
                ),
              );

              _note = await noteService.getNote(_note.date);

              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async {
              await noteService.deleteNote(widget.note.date);

              if (mounted) Navigator.pop(context);
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
              _note.content,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Divider(height: 16),
            Text(
              'Dibuat pada ${_note.date.toIso8601String()}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
