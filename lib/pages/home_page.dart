import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sandbox/model/note.dart';
import 'package:sandbox/pages/show_note_page.dart';
import 'package:sandbox/service/note_service.dart';

import 'note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteService noteService = FileStorageNoteService();

  List<Note> _notes = [];

  Future<void> loadNotes() async {
    final notes = await noteService.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  @override
  void initState() {
    super.initState();

    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DTSProject File'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotePage(),
                ),
              );

              loadNotes();
            },
          ),
        ],
      ),
      body: _notes.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                final note = _notes[index];
                final content = note.content.trim();
                return ListTile(
                  title: Text(note.date.toString()),
                  subtitle: Text(
                    '${content.substring(0, min(50, content.length))}${content.length > 50 ? '...' : ''}',
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowNotePage(note: note),
                      ),
                    );
                    loadNotes();
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotePage(note: note),
                            ),
                          );

                          loadNotes();
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          await noteService.deleteNote(note.date);
                          loadNotes();
                        },
                      ),
                    ],
                  ),
                );
              },
              itemCount: _notes.length,
            )
          : const Center(
              child: Text('Belumm ada catatan'),
            ),
    );
  }
}
