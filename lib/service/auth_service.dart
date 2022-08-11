import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../model/user.dart';

abstract class AuthService {
  Future<User?> signIn(String username, String password);
  Future<User> signUp(String username, String password);
}

// auth service implementation using file storage
class FileStorageNoteService implements AuthService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final file = File('$path/auth.json');

    if (!await file.exists()) {
      await file.create();
    }

    return file;
  }

  @override
  Future<User> signUp(String username, String password) async {
    final file = await _localFile;
    final users = await file.readAsString();
    final newUsers = users == '' ? [] : json.decode(users) as List;

    final user = User(
      username: username,
      password: password,
    );

    newUsers.add(user.toJson());

    await file.writeAsString(json.encode(newUsers));

    return user;
  }

  @override
  Future<User?> signIn(String username, String password) async {
    final file = await _localFile;
    final users = await file.readAsString();
    final newUsers = users == '' ? [] : json.decode(users) as List;
    final user = newUsers.firstWhere(
      (user) => user['username'] == username && user['password'] == password,
      orElse: () => null,
    );
    return user != null ? User.fromJson(user) : null;
  }
}
