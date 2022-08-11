import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../model/note.dart';

abstract class NoteService {
  Future<Note> createNote(Note note);
  Future<Note> getNote(DateTime date);
  Future<List<Note>> getNotes();
  Future<Note> updateNote(Note note);
  Future<void> deleteNote(DateTime date);
}

// note service implementation using file storage
class FileStorageNoteService implements NoteService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final file = File('$path/notes.json');

    if (!await file.exists()) {
      await file.create();
    }

    return file;
  }

  @override
  Future<Note> createNote(Note note) async {
    final file = await _localFile;
    final notes = await file.readAsString();
    final newNotes = notes == '' ? [] : json.decode(notes) as List;
    newNotes.add(note.toJson());
    await file.writeAsString(json.encode(newNotes));
    return note;
  }

  @override
  Future<Note> updateNote(Note note) async {
    final file = await _localFile;
    final notes = await file.readAsString();
    final newNotes = notes == '' ? [] : json.decode(notes) as List;
    newNotes.removeWhere((n) => n['date'] == note.date.toIso8601String());
    newNotes.add(note.toJson());
    await file.writeAsString(json.encode(newNotes));
    return note;
  }

  @override
  Future<Note> getNote(DateTime date) async {
    final file = await _localFile;
    final notes = await file.readAsString();
    final newNotes = notes == '' ? [] : json.decode(notes) as List;
    final note =
        newNotes.firstWhere((n) => n['date'] == date.toIso8601String());
    return Note.fromJson(note);
  }

  @override
  Future<List<Note>> getNotes() async {
    final file = await _localFile;
    final notes = await file.readAsString();
    final newNotes = notes == '' ? [] : json.decode(notes) as List;
    return newNotes.map((n) => Note.fromJson(n)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<void> deleteNote(DateTime date) async {
    final file = await _localFile;
    final notes = await file.readAsString();
    final newNotes = notes == '' ? [] : json.decode(notes) as List;
    newNotes.removeWhere((n) => n['date'] == date.toIso8601String());
    await file.writeAsString(json.encode(newNotes));
  }
}
