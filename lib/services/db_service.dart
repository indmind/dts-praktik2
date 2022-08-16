import 'package:sqflite/sqflite.dart';

class DbService {
  Database? _db;

  static const String databaseStudent = 'student_database';
  static const int databaseVersion = 1;
  static const String tableStudent = 'students';
  static const String keyId = 'id';
  static const String keyFirstname = 'firstname';

  Future<void> ensureInitialized() async {
    _db ??= await openDatabase(
      '${await getDatabasesPath()}/$databaseStudent.db',
      version: databaseVersion,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
          CREATE TABLE $tableStudent (
              $keyId INTEGER PRIMARY KEY AUTOINCREMENT,
              $keyFirstname TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> close() async {
    await _db?.close();
  }

  Future<void> insert(String name) async {
    await ensureInitialized();
    await _db!.insert(tableStudent, {keyFirstname: name});
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    await ensureInitialized();
    final result = await _db!.query(tableStudent);

    return result;
  }

  Future<void> delete(int id) async {
    await ensureInitialized();
    await _db!.delete(tableStudent, where: '$keyId = ?', whereArgs: [id]);
  }

  Future<void> update(int id, String name) async {
    await ensureInitialized();
    await _db!.update(
      tableStudent,
      {
        keyFirstname: name,
      },
      where: '$keyId = ?',
      whereArgs: [id],
    );
  }
}
